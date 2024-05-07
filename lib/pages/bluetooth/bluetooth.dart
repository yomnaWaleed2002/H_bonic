import 'dart:async';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothReceiver extends StatefulWidget {
  @override
  _BluetoothReceiverState createState() => _BluetoothReceiverState();
}

class _BluetoothReceiverState extends State<BluetoothReceiver> {
  String _receivedData = '';
  String heartRate = '';
  String deleting = '';
  String oxygenSaturation = '';
  String temperature = '';
  bool _isConnected = false; // Track connection status
  BluetoothConnection? connection;

  @override
  void initState() {
    super.initState();
  }

  void _connectBluetooth() async {
    try {
      // Fetch all bonded devices
      List<BluetoothDevice> devices =
          await FlutterBluetoothSerial.instance.getBondedDevices();

      // Find the device by name
      BluetoothDevice device = devices.firstWhere(
        (device) => device.name == 'HC-05',
      );

      if (device != null) {
        // Connect to the device
        connection = await BluetoothConnection.toAddress(device.address);
        connection!.input!.listen((Uint8List data) {
          setState(() {
            _receivedData += String.fromCharCodes(data);

            // Split received data into three values after a delay
            Timer(Duration(milliseconds: 100), () {
              List<String> values = _receivedData.split(',');
              if (values.length >= 3) {
                
                heartRate = values[0];
                oxygenSaturation = values[1];
                temperature = values[2];

                print('Heart Rate: $heartRate');
                print('Oxygen Saturation: $oxygenSaturation');
                print('Temperature: $temperature');
                // Clear received data buffer
                _receivedData = '';
              }
            });
          });
        });

        setState(() {
          _isConnected = true; // Update connection status
        });
      } else {
        print('Device not found.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _disconnectBluetooth() {
    setState(() {
      _isConnected = false; // Update connection status
      _receivedData = '';
      heartRate = '';
      oxygenSaturation = '';
      temperature = '';
      // Close the Bluetooth connection
      if (connection != null) {
        connection!.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect to a H-bionc'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/hand.png"),
            Text(
              'heart rate: $heartRate'.tr,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'oxygen rate: $oxygenSaturation'.tr,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'temperature: $temperature'.tr,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  _isConnected ? _disconnectBluetooth : _connectBluetooth,
              child: Text(_isConnected ? 'Disconnect '.tr : 'Connect '.tr),
            ),
          ],
        ),
      ),
    );
  }
}
