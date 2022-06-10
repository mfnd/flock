import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'device.dart';
import 'network.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
          create: (context) {
            var model = NetworkModel();
            model.initializePersistence();
            model.runAnnounceListener();
            return model;
          },
          child: const MaterialApp(
              title: "Flock",
              home: FlockUI()
          )
      )

  );
}

class FlockUI extends StatelessWidget {
  const FlockUI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flock')
      ),
      body: DeviceView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sendAnnounceRequest(),
        tooltip: "Refresh",
        child: const Icon(Icons.refresh)
      ),
    );
  }

}

class DeviceView extends StatelessWidget {
  const DeviceView();

  //final Device devices;

  @override
  Widget build(BuildContext context) {
    var network = context.watch<NetworkModel>();
    return ListView(
      children: network.devices.values.map((e) =>
          ListTile(
            leading: const Icon(
                Icons.computer
            ),
            title: Text(e.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Interface: ${e.interfaceName}"),
                Text("HW Addr: ${e.hwAddr.toString()}"),
                Text("IP: ${e.ipAddr.address}"),
                Text("Last seen: ${e.lastSeen.toIso8601String()}"),
              ]
            ),
            trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    child: const Text("Wake Up"),
                    onPressed: () => e.wakeUp()
                  ),
                  TextButton(
                    child: const Text("Sleep"),
                    onPressed: () => e.hibernate(),
                  )
              ]
            )
          )
      ).toList(),
    );

  }
}
