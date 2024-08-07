import 'package:all_languages_voice_dictionary/View/splash_screen/splash3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/textbutton.dart';

class Splash2 extends StatelessWidget {
  const Splash2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: Get.height* 0.17,),
          Text(
            'Instant Translation',
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w800,
                color: Color(0xFFE64D3D)),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Get.height * 0.02,
              bottom: Get.height * 0.03,
            ),
            child: Text(
                'Our Translation feature makes it simple to understand and language.\n'
                    '        Just enter your text and get a clear translation in seconds',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Arial',
                    //fontWeight: FontWeight.w700,
                    color: Colors.grey)),
          ),
          Image.asset(
            "assets/splash2.png",
            width: 400,
            height: MediaQuery.of(context).size.height * 0.3,
          ),

          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.06,bottom:Get.height * 0.05 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 20,
                    height: 10.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFE64D3D)
                    ),
                  ),
                ),
                Container(
                  width: 10,
                  height: 10.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey
                  ),
                ),
              ],),
          ),
          customTextButton(
            voidCallBack: () {
              Get.to(Splash3());
            },
            title: 'Next',
            color: Color(0xFFE64D3D),

          ),
        ],
      ),
    );
  }
}
