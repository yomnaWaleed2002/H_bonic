import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(42),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('images/customer-service 1.png'),
                        radius: 30,
                        backgroundColor: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: Text(
                          "H-Bionic Chat".tr,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 26,
                            fontFamily: 'Century Gothic',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset("images/chatnoow.png"),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF459ED1), // Change color based on condition
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(
                        Size(200, 80), // Change the size of the button
                      ),
                    ),
                    onPressed: () {
                      launch(
                          'https://663a63028e221e2f2500b8a2--velvety-madeleine-db0d9a.netlify.app/');
                    },
                    child: Text('chat now'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 22))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
