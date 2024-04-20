import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:siri_wave/siri_wave.dart';

class heart extends StatefulWidget {
  @override
  State<heart> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<heart> {
  String _receivedData = '';
  String heartRate = '';
  String oxygenSaturation = '';
  String temperature = '';
  bool _isConnected = false; // Track connection status
  BluetoothConnection? connection; // Track the connection status

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
    final controller = IOS7SiriWaveformController(
      amplitude: 0.9,
      color: const Color(0xff466AFF),
      frequency: 5,
      speed: 0.18,
    );
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 28, top: 50, right: 28),
            child: Row(
              children: [
                Image.asset(
                  'images/heart-rate (1) 2.png',
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "Heart Rate".tr,
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
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 50, right: 10),
            child: Row(
              children: [
                Text(
                  'Heart AVG bpm'.tr,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 23,
                    fontFamily: 'Century Gothic',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    heartRate,
                    style: const TextStyle(
                      color: Color(0xFF459ED1),
                      fontSize: 17,
                      fontFamily: 'Century Gothic',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: 350,
              height: 280,
              decoration: BoxDecoration(
                color: const Color(0xff282A2C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 80, left: 80),
                          child: Text(
                            'Heart’s bpm'.tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Century Gothic',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                        const Icon(Icons.comment, color: Colors.white),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(
                            Icons.reply_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SiriWaveform.ios7(
                    controller: controller,
                    options: const IOS7SiriWaveformOptions(
                      height: 190,
                      width: 400,
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 350,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xff282A2C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
                child: Row(children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15, right: 80, left: 6),
                    child: Column(
                      children: [
                        Text(
                          'Heart Health',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: 'Century Gothic',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        Text('55',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: 'Century Gothic',
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              _isConnected
                                  ? Color(0xFF459ED1)
                                  : Color(
                                      0xFF459ED1), // Change color based on condition
                            ),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(20))),
                        onPressed: _isConnected
                            ? _disconnectBluetooth
                            : _connectBluetooth,
                        child: Text(_isConnected ? 'stoping' : 'Measure',
                            style: TextStyle(color: Colors.white))),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
