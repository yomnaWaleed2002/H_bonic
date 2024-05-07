import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class oxgen extends StatefulWidget {
  final Stream<Uint8List>? dataStream;
  const oxgen({Key? key, this.dataStream}) : super(key: key);
  @override
  State<oxgen> createState() => _oxgenState();
}

class _oxgenState extends State<oxgen> {
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
    double oxgen2 = 0.0;
    try {
      // Attempt to parse the temperature string to a double
      double parsedTemperature = double.tryParse(temperature) ?? 0.0;

      // Divide the parsed temperature by 100
      oxgen2 = parsedTemperature / 100;
    } catch (e) {
      // Handle parsing exceptions, such as invalid input
      print("Error parsing temperature string to double: $e");
    }
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(42),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('images/oxygen (1) 1.png'),
                radius: 30,
                backgroundColor: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Text(
                  "Oxygen Ratio".tr,
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
              decoration: BoxDecoration(
                color: const Color(0xff282A2C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: RippleAnimation(
                        key: UniqueKey(),
                        repeat: true,
                        duration: const Duration(milliseconds: 3000),
                        color: Colors.grey,
                        minRadius: 40,
                        ripplesCount: 20,
                        size: const Size(180, 180),
                        child: Center(
                          child: LiquidCircularProgressIndicator(
                            value: oxgen2, // Defaults to 0.5.
                            valueColor: const AlwaysStoppedAnimation(
                              Color(0xff469FD1),
                            ), // Defaults to the current Theme's accentColor.
                            backgroundColor: const Color(
                                0xff282A2C), // Defaults to the current Theme's backgroundColor.
                            borderColor: Colors.grey,
                            borderWidth: 5.0,
                            direction: Axis
                                .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                            center: Text(
                              oxygenSaturation,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Text(
                      'Oxygen Ratio'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Century Gothic',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              )),
        ),
        const SizedBox(
          height: 70,
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                _isConnected
                    ? Color(0xFF459ED1)
                    : Color(0xFF459ED1), // Change color based on condition
              ),
              fixedSize: MaterialStateProperty.all<Size>(
                Size(200, 80), // Change the size of the button
              ),
            ),
            onPressed: _isConnected ? _disconnectBluetooth : _connectBluetooth,
            child: Text(_isConnected ? 'stoping' : 'Measure',
                style: TextStyle(color: Colors.white, fontSize: 22))),
      ],
    );
  }
}
