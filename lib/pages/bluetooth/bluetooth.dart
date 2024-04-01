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

  Timer? _timer;
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

  //--------------------------------------

// TIMER START-----

//---------------------------------------------
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("--connect to H-bionc--"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("images/hand.png"),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              "MAC Adress: 00:21:07:00:50:69",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              child: Text(
                "connect",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff469FD1),
              ),
              onPressed: () {
                connect(adr);
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
