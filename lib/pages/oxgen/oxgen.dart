import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class oxgen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(42),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/oxygen (1) 1.png'),
                radius: 30,
                backgroundColor: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28,right: 28),
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
                color: Color(0xff282A2C),
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
                        size: Size(180, 180),
                        child: Center(
                          child: LiquidCircularProgressIndicator(
                            value: 0.30, // Defaults to 0.5.
                            valueColor: AlwaysStoppedAnimation(Color(0xff469FD1),), // Defaults to the current Theme's accentColor.
                            backgroundColor: Color(0xff282A2C),// Defaults to the current Theme's backgroundColor.
                            borderColor: Colors.grey,
                            borderWidth: 5.0,
                            direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                            center: Text("30%",style:TextStyle(color: Colors.white,fontSize: 20) ,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Text(
                      'Oxygen Ratio'.tr,
                      style: TextStyle(
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
        SizedBox(
          height: 70,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff469FD1),
            fixedSize: const Size(175, 73),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: SizedBox(
            width: 103,
            height: 32,
            child: Text(
              "Measure".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}