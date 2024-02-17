import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_bionic/pages/heart/heart.dart';
import 'package:h_bionic/pages/oxgen/oxgen.dart';
import 'package:h_bionic/pages/tempruture/temp.dart';
import 'package:h_bionic/pages/chat.dart';
import '../main.dart';

class Bottom_bar extends StatefulWidget {
  @override
  _Bottom_barState createState() => _Bottom_barState();
}

class _Bottom_barState extends State<Bottom_bar> {
  int _currentIndex = 0;
  List<Widget> Options = [heart(),oxgen(),chat(),temp(),Setting()];
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Options.elementAt(_currentIndex),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(
              icon: Image.asset(
                "images/heart-rate 1.png",
                width: 100,
                height: 100,
              ),
              title: 'heart'.tr,
              activeIcon: Image.asset(
                "images/heart-rate 1.png",
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
              ),
          TabItem(
              icon: Image.asset(
                "images/oxygen 2.png",
                width: 100,
                height: 100,
              ),
              title:'oxygen'.tr,
              activeIcon: Image.asset(
                "images/oxygen 2.png",
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
              ),
          TabItem(
              icon: Image.asset(
                "images/customer-service 1.png",
                width: 100,
                height: 100,
              ),
              title: 'chat'.tr),
          TabItem(
              icon: Image.asset(
                "images/thermometer 2.png",
                width: 100,
                height: 100,
               
              ),
              title: 'temp'.tr),
          TabItem(
              icon: Image.asset(
                "images/settings 3.png",
                width: 100,
                height: 100,
              ),
             
              title: 'setting'.tr),
        ],
        //initialActiveIndex: _current_index,
        activeColor: Colors.white,
        color: Colors.black,
        backgroundColor: Colors.grey[200],
        onTap: changeItem,
      ),

    );
  }
  void changeItem(int index) {
    setState(() {
      _currentIndex=index;
    });
  }

}