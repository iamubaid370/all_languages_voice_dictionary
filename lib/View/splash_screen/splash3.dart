import 'package:all_languages_voice_dictionary/View/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/textbutton.dart';

class Splash3 extends StatelessWidget {
  const Splash3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          SizedBox(height: Get.height* 0.17,),
          Text(
            'Save The Words',
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
                'Easily save and organize words you want to learn.\n'
                    'Our feature lets you build your own personal dictinary ',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Arial',
                    //fontWeight: FontWeight.w700,
                    color: Colors.grey)),
          ),
          Image.asset(
            "assets/splash3.png",
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
                    width: 10,
                    height: 10.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey
                    ),
                  ),

                ),
                Container(
                  width: 20,
                  height: 10.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFFE64D3D)
                  ),
                ),

              ],),
          ),
          customTextButton(
            voidCallBack: () {
              Get.to(HomeScreen());
            },
            title: 'Next',
            color: Color(0xFFE64D3D),

          ),
        ],
      ),
    );
  }
}
