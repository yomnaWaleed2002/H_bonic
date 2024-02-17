import 'dart:async';
import 'package:h_bionic/pages/custom_container.dart';
import 'package:h_bionic/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
 

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  LoginScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(),
              const Text(
                'H-BIONIC',
                style: TextStyle(fontSize: 55, fontWeight: FontWeight.normal),
              ),
              const Spacer(),
              CircleAvatar(
                radius: 150,
                child: Image.asset('images/logo.jpg', fit: BoxFit.fill),
              ),
              const Spacer(),
              ClipPath(
                clipper: CurvedClipper(),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: const Color.fromARGB(255, 67, 159, 210),
                  child:  Column(
                    children: [
                      SizedBox(height: 110),
                      Text("Electronic Human Limbs".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
