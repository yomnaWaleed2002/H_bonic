import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothWidget extends StatefulWidget {
  const BluetoothWidget({Key? key}) : super(key: key);

  @override
  _BluetoothWidgetState createState() => _BluetoothWidgetState();
}

class _BluetoothWidgetState extends State<BluetoothWidget> {
  List<BluetoothDevice> _devices = [];
  BluetoothConnection? _connection;

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  Future<void> _loadDevices() async {
    try {
      await FlutterBluetoothSerial.instance.requestEnable();
      FlutterBluetoothSerial.instance.startDiscovery().listen((result) {
        setState(() {
          final device = result.device;
          if (!_devices.contains(device)) {
            _devices.add(device);
          }
        });
      });
    } catch (e) {
      print('Error starting discovery: $e');
    }
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
  try {
    _connection = await BluetoothConnection.toAddress(device.address);
    // Connection successful, show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Connected to ${device.name ?? 'Unknown device'}'),
      ),
    );
  } catch (e) {
    // Connection failed, show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to connect to ${device.name ?? 'Unknown device'}'),
      ),
    );
    print('Error connecting to device: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("-- Connect to H-bionc --"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30.0),
            Expanded(
              child: ListView.builder(
                itemCount: _devices.length,
                itemBuilder: (context, index) {
                  final device = _devices[index];
                  return ListTile(
                    title: Text(device.name ?? 'Unknown device'),
                    subtitle: Text(device.address),
                    onTap: () async {
                      await _connectToDevice(device);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
