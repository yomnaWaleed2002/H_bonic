import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siri_wave/siri_wave.dart';
class heart extends StatefulWidget {
  
  @override
  State<heart> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<heart> {
  @override
  Widget build(BuildContext context) {
    final controller = IOS7SiriWaveformController(
      amplitude: 0.9,
      color: Color(0xff466AFF),
      frequency: 5,
      speed: 0.18,
    );
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:28,top: 50,right: 28),
          child: Row(
            children: [
              Image.asset(
                'images/heart-rate (1) 2.png',
                width: 60,
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28, right: 28),
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
           padding: const EdgeInsets.only(left: 40,top:70,right: 40),
           child: Row(children: [
             Text('Heart AVG bpm'.tr,style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 23,
                      fontFamily: 'Century Gothic',
                      fontWeight: FontWeight.w400,
                    ),),
                    Text('79',style: TextStyle(
                      color: Color(0xff466AFF),
                      fontSize: 30,
                      fontFamily: 'Century Gothic',
                      fontWeight: FontWeight.w400,
                    ),)
                   ],),
         ),
         Container(
            width: 350,
            height: 280,
            decoration: BoxDecoration(
              color: Color(0xff282A2C),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                 Padding(
                   padding: const EdgeInsets.only(top:20),
                   child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:80 ,left: 80),
                        child: Text(
                          'Heart’s bpm'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Century Gothic',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                             
                      Icon(Icons.comment,color: Colors.white),
                       Padding(
                         padding: const EdgeInsets.only(left: 10,right: 10),
                         child: Icon(Icons.reply_sharp,color: Colors.white,),
                       ),
                      
                    ],
                   ),
                 ),
                SiriWaveform.ios7(
              controller: controller,
              options: IOS7SiriWaveformOptions(
                height: 190,
                width: 400,
              ),
            ),
          
           
              ],
            )
          ),
        
        Padding(
          padding: const EdgeInsets.only(top:50),
          child: Container(
            width: 350,
            height: 70,
            decoration: BoxDecoration(
              color: Color(0xff282A2C),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left:10,top: 5,right: 10),
              child: Row(children: [
                Icon(Icons.favorite,color: Colors.red,size: 60,),
                Padding(
                  padding: const EdgeInsets.only(top:15,right: 80,left: 6),
                  child: Column(children: [Text('Heart Health',style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontFamily: 'Century Gothic',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),),
                            Text('55',style:TextStyle(color: Colors.white,fontSize: 22,
                              fontFamily: 'Century Gothic',
                              fontWeight: FontWeight.w400,))
                  ],),
                ),
            
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: ElevatedButton(
              style:ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(20)),
              backgroundColor: MaterialStateProperty.all(Color(0xff469FD1)),
              ),
              onPressed: () {},
              child: const Text('measure',style: TextStyle(color: Colors.white),),
            ),
          ),
        
              ]),
            ),
            
          ),
        ),
      ],
    );
  }
}
