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
  int temperature = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (widget.connection != null && widget.connection!.isConnected) {
        widget.connection!.input!.listen((Uint8List data) {
          setState(() {
            temperature = int.parse(ascii.decode(data));
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double temperature2 = temperature / 100;
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
                padding: const EdgeInsets.only(left: 28, right: 28),
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
                          '$temperature',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF469FD1),
                            fontSize: 88,
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
          onPressed: () {
            _startTimer();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff469FD1),
            fixedSize: const Size(175, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: SizedBox(
            width: 103,
            height: 32,
            child: Text(
              "Measure".tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w500,
                height: 0.8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
