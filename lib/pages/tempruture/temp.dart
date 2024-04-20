import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class tmp extends StatefulWidget {
  final BluetoothConnection? connection;

  const tmp({Key? key, this.connection}) : super(key: key);
  @override
  State<tmp> createState() => _tmpState();
}

class _tmpState extends State<tmp> {
   String _receivedData = '';
  String heartRate = '';
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
            // Split received data into three values
            List<String> values = _receivedData.split(',');
            if (values.length >= 3) {
              heartRate = values[0];
              oxygenSaturation = values[1];
              temperature = values[2];

              // Do something with the received data
              print('Heart Rate: $heartRate');
              print('Oxygen Saturation: $oxygenSaturation');
              print('Temperature: $temperature');
              // Clear received data buffer
              _receivedData = '';
            }
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
    double temperature2 = 0.5 ;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(42),
          child: Row(
            children: [
              Image.asset(
                'images/thermometer_3-removebg-preview.png',
                width: 60,
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Text(
                  "Temperature".tr,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 30,
                    fontFamily: 'Century Gothic',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
            child: Container(
                width: 340,
                height: 340,
                child: CircularPercentIndicator(
                  radius: 110.0,
                  arcType: ArcType.FULL,
                  lineWidth: 15,
                  percent: temperature2,
                  circularStrokeCap: CircularStrokeCap.round,
                  arcBackgroundColor: Colors.grey.withOpacity(0.3),
                  center: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        Text(
                          temperature,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF469FD1),
                            fontSize: 60,
                            fontFamily: 'Century Gothic',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: -2.64,
                          ),
                        ),
                        Text(
                          'Degrees'.tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF459ED1),
                            fontSize: 26,
                            fontFamily: 'Century Gothic',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        )
                      ],
                    ),
                  ),
                  progressColor: Colors.deepOrange,
                ))),
        SizedBox(
          height: 40,
        ),
         ElevatedButton(
             style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      _isConnected ?  Color(0xFF459ED1):  Color(0xFF459ED1), // Change color based on condition
    ),
    fixedSize: MaterialStateProperty.all<Size>(
      Size(200, 80), // Change the size of the button
    ),
  ),
              onPressed:
                  _isConnected ? _disconnectBluetooth : _connectBluetooth,
              child: Text(_isConnected
                  ? 'stoping'
                  : 'Measure',style: TextStyle(color: Colors.white,fontSize: 22))
            ),
      ],
    );
  }
}
