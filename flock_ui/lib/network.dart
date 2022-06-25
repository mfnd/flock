

import 'dart:io';

import 'package:flock_ui/proto/flock.pb.dart';

const broadcastPort = 6666;
const commandPort = 7777;

class MACAddress {

  MACAddress.fromString(String hwAddr)
      : addr = hwAddr.split(':').map((e) => int.parse(e, radix: 16)).toList();

  final List<int> addr;

  @override
  String toString() {
    return addr.map((e) => e.toRadixString(16).padLeft(2,'0').toUpperCase()).join(":");
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


void sendWakeOnLAN(InternetAddress ipAddr, NetMask netMask, MACAddress hwAddr, {int port = 9}) async {
  List<int> buffer = [
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
  ];
  for(var i=0; i < 16; i++) {
    buffer.addAll(hwAddr.addr);
  }
  try {
    var socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    socket.broadcastEnabled = true;
    var broadcastAddr = getBroadcastAddress(ipAddr, netMask);
    var n = socket.send(buffer, broadcastAddr, 9);
    if(n == 0) {
      print("Failed to send datagram");
    }
  } catch(e) {
    print("Error: $e");
  }
}

void sendAnnounceRequest() async {
  var announceRequest = Broadcast(
    type: Broadcast_Type.ANNOUNCE_REQUEST,
    announceRequest: null
  );

  var socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 6666);
  socket.broadcastEnabled = true;
  var n = socket.send(
      announceRequest.writeToBuffer(),
      InternetAddress("255.255.255.255"),
      broadcastPort
  );
  if(n == 0) {
    print("Failed to send datagram");
  }
}