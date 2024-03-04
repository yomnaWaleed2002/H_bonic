import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class bluetooth extends StatefulWidget {
  const bluetooth({super.key});

  @override
  State<bluetooth> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<bluetooth> {
  List<BluetoothDevice> _devices = [];
 BluetoothConnection? connection;
  String adr = "00:21:07:00:50:69"; // my bluetooth device MAC Adres
  String recData = "....";

  late Timer _timer;
  @override
  

    void initState() {
      super.initState();
      _loadDevices();
    }

    Future<void> _loadDevices() async {
      List<BluetoothDevice> devices =
          await FlutterBluetoothSerial.instance.getBondedDevices();

      setState(() {
        _devices = devices;
      });
    }

    //----------------------------
    Future<void> sendData(String data) async {
      data = data.trim();
      try {
        List<int> list = data.codeUnits;
        Uint8List bytes = Uint8List.fromList(list);
        connection?.output.add(bytes);
        await connection?.output.allSent;
      } catch (e) {
        //print(e.toString());
      }
    }

    // data RECEIVED --------------

    Future<void> receiveData() async {
      connection?.input!.listen((Uint8List data) {
        //Data entry point
        setState(() {
          recData = ascii.decode(data);
        });
      });
    }
    //--------------------------------------

// TIMER START-----------
    void _startTimer() {
      _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
        receiveData();
      });
    }

//---------------------------------------------
    @override
    void dispose() {
      _timer.cancel();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
              "----Temperature and Humidity Meter with BlueTooth-----"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("MAC Adress: 00:21:07:00:50:69"),

              ElevatedButton(
                child: Text("Connect"),
                onPressed: () {
                  connect(adr);
                },
              ),

              const SizedBox(
                height: 30.0,
              ),

              const Text(
                "Temperature-Humidity: ",
                style: TextStyle(fontSize: 55.0),
              ),
              Text(
                recData,
                style: TextStyle(fontSize: 40.0),
              ),

              const SizedBox(
                height: 10.0,
              ),
              // Text(_timeString),
              const SizedBox(
                height: 10.0,
              ),

              const SizedBox(
                height: 10.0,
              ),

              ElevatedButton(
                child: Text("Start timer"),
                onPressed: () {
                  _startTimer();
                },
              ),
            ],
          ),
        ),
      );
    }

    Future connect(String address) async {
      try {
        connection = await BluetoothConnection.toAddress(address);
      } catch (exception) {
        // durum="Cannot connect, exception occured";
      }
    }

    @override
    void debugFillProperties(DiagnosticPropertiesBuilder properties) {
      super.debugFillProperties(properties);
    }
  }

