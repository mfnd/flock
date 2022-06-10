

import 'dart:io';

import 'package:flock_ui/device.dart';
import 'package:flock_ui/proto/flock.pb.dart';

void sendWakeOnLAN(String broadcastIP, MACAddress hwAddr, {int port = 9}) async {
  List<int> buffer = [
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
  ];
  for(var i=0; i < 16; i++) {
    buffer.addAll(hwAddr.addr);
  }
  var socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 9);
  var n = socket.send(buffer, InternetAddress(broadcastIP), 9);
  if(n == 0) {
    print("Failed to send datagram");
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
      6666
  );
  print("Socket address ${socket.address}");
  if(n == 0) {
    print("Failed to send datagram");
  }
}