

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'network.dart';
import 'proto/flock.pb.dart';


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
    sendWakeOnLAN(ipAddr, netMask, hwAddr, port: port);
  }

  void hibernate() async {
    var socket = await Socket.connect(ipAddr, commandPort);

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
    if(await persistenceFile!.exists()) {
      var contents = await persistenceFile!.readAsString();
      try {
        for (var decoded in jsonDecode(contents)) {
          var device = Device.fromJson(decoded);
          devices[device.name] = device;
        }
        print("State loaded from $persistenceFile");
        notifyListeners();
      } catch (exception) {
        log(exception.toString());
        await persistenceFile!.delete();
      }
    }
  }


  void runPersistence() async {
    if(persistenceFile != null) {
      print("App documents: $persistenceFile");
      var encoded = jsonEncode(devices.values.toList());
      persistenceFile!.writeAsString(encoded);
    }
  }

  void runAnnounceListener() async {
    var socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, broadcastPort);
    socket.listen((event) {
      var packet = socket.receive();
      if(packet != null) {
        var broadcastPacket = Broadcast.fromBuffer(packet.data);
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
    }, onError: (error) {
      stderr.writeln(error);
    });
    print("Announce Listener exited");
  }




}