

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'proto/flock.pb.dart';

class MACAddress {

  MACAddress.fromString(String hwAddr)
    : addr = hwAddr.split(':').map((e) => int.parse(e, radix: 16)).toList();

  final List<int> addr;

  @override
  String toString() {
    return addr.map((e) => e.toRadixString(16)).join(":");
  }

}

class NetMask {
  
  NetMask.fromInt(int netMask) {
    mask = [
      (netMask & 0xFF000000) >> 24,
      (netMask & 0x00FF0000) >> 16,
      (netMask & 0x0000FF00) >> 8,
      netMask & 0x000000FF
    ];
  }

  late final List<int> mask;

  int toInt() {
    return mask[0] << 24 | mask[1] << 16 | mask[2] << 8 | mask[3];
  }

}

InternetAddress getBroadcastAddress(InternetAddress addr, NetMask netMask) {
  var raw = addr.rawAddress;
  for(var i=0; i < 4; i++) {
    raw[i] &= netMask.mask[i];
    raw[i] |= ~netMask.mask[i];
  }
  var broadcastAddr = InternetAddress.fromRawAddress(raw);
  print("Broadcast address: $broadcastAddr");
  return broadcastAddr;
}

class Device {
  Device({
    required this.name,
    required this.interfaceName,
    required this.hwAddr,
    required this.ipAddr,
    required this.netMask,
    required this.lastSeen
  });

  String name;
  String interfaceName;
  MACAddress hwAddr;
  InternetAddress ipAddr;
  NetMask netMask;
  DateTime lastSeen;

  void wakeUp({int port = 9}) async {
    List<int> buffer = [
      0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
    ];
    for(var i=0; i < 16; i++) {
      buffer.addAll(hwAddr.addr);
    }
    var socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 9);
    var broadcastAddr = getBroadcastAddress(ipAddr, netMask);
    var n = socket.send(buffer, broadcastAddr, 9);
    if(n == 0) {
      print("Failed to send datagram");
    }
  }

  void hibernate() async {
    var socket = await Socket.connect(ipAddr, 7777);

    var hibernateCommand = Command(
      shutdown: ShutdownCommand(
        mode: ShutdownCommand_Mode.SLEEP
      )
    );

    socket.add(hibernateCommand.writeToBuffer());
    socket.close();
  }

  Device.fromJson(Map<String, dynamic> json)
    : name = json["name"],
      interfaceName = json["ifName"],
      hwAddr = MACAddress.fromString(json["mac"]),
      ipAddr = InternetAddress(json["ip"]),
      netMask = NetMask.fromInt(json["netMask"]),
      lastSeen = DateTime.parse(json["lastSeen"]);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "ifName": interfaceName,
      "mac": hwAddr.toString(),
      "ip": ipAddr.address,
      "netMask": netMask.toInt(),
      "lastSeen": lastSeen.toIso8601String()
    };
  }
}

class NetworkModel extends ChangeNotifier {
  final Map<String, Device> devices = {};

  File? persistenceFile;

  void initializePersistence() async {
    var documentPath = await getApplicationDocumentsDirectory();
    persistenceFile = File(join(documentPath.path, "flock.data"));
    var contents = await persistenceFile!.readAsString();
    try {
      for (var decoded in jsonDecode(contents)) {
        var device = Device.fromJson(decoded);
        devices[device.name] = device;
      }
    } catch (exception) {
      log(exception.toString());
      await persistenceFile!.delete();
    }
    notifyListeners();
    print("State loaded from $persistenceFile");
  }


  void runPersistence() async {
    if(persistenceFile != null) {
      print("App documents: $persistenceFile");
      var encoded = jsonEncode(devices.values.toList());
      persistenceFile!.writeAsString(encoded);
    }
  }

  void runAnnounceListener() async {
    var socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 6666);
    socket.listen((event) {
      var packet = socket.receive();
      if(packet != null) {
        var broadcastPacket = Broadcast.fromBuffer(packet.data);
        print(broadcastPacket);
        if(broadcastPacket.hasAnnounce()) {
          var announcePacket = broadcastPacket.announce;
          var device = devices[announcePacket.name];
          if(device == null) {
            devices[announcePacket.name] = Device(
                name: announcePacket.name,
                interfaceName: announcePacket.interface,
                hwAddr: MACAddress.fromString(announcePacket.hwAddr),
                ipAddr: InternetAddress.tryParse(announcePacket.ipAddr)!,
                netMask: NetMask.fromInt(int.tryParse(announcePacket.netmask, radix: 16)!),
                lastSeen: DateTime.now()
            );
          } else {
            device.lastSeen = DateTime.now();
          }
          runPersistence();
          notifyListeners();
        }
      }
    });
  }




}