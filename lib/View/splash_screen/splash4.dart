import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/dropdown_button.dart';
import '../../widgets/iconbutton.dart';
import '../../widgets/textbutton.dart';
import '../home_screen/home_screen.dart';

class Splash4 extends StatelessWidget {
   Splash4({super.key});
  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top:Get.width* 0.14,left: Get.width * 0.6 ),
            child: TextButton(onPressed: (){Get.to(()=>HomeScreen());}, child: Text('Skip',style: TextStyle(color: Colors.grey),)),
          ),
          SizedBox(height: Get.height* 0.08,),
          Text(
            'Set Your Primary Language',
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
                'Selective your native language from here.\n'
                    'You can change it anytime inside the app',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Arial',
                    //fontWeight: FontWeight.w700,
                    color: Colors.grey)),
          ),
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 30,right: 30,),
                height: Get.height * 0.25,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Color(0xFFE64D3D),
                  borderRadius: BorderRadius.circular(15)
                ),
                //color: Colors.blue,
              ),

              SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      margin: EdgeInsets.only(left: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFEFEFEF),
                      ),
                      child: customDropDownButton(
                          homeScreenController.dropDownValue1,
                              (String? newValue) {
                            if (newValue != null) {
                              homeScreenController.dropDownValue1.value =
                                  newValue;
                            }
                          }, Color(0xFFEFEFEF),Color(0xFFE64D3D)),
                    ),
                    customIconButton(
                          () {
                        String temp =
                            homeScreenController.dropDownValue1.value;
                        homeScreenController.dropDownValue1.value =
                            homeScreenController.dropDownValue2.value;
                        homeScreenController.dropDownValue2.value = temp;
                      },
                      'assets/swap_arrows.png',
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      margin: EdgeInsets.only(right: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFEFEFEF),
                      ),
                      child: customDropDownButton(
                          homeScreenController.dropDownValue2,
                              (String? newValue) {
                            if (newValue != null) {
                              homeScreenController.dropDownValue2.value =
                                  newValue;
                            }
                          },
                          Color(0xFFFFFFFF),Color(0xFFE64D3D)
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 60,),
          customTextButton(
            voidCallBack: () {
              Get.to(()=>HomeScreen());
            },
            title: 'Next',
            color: Color(0xFFE64D3D),

          ),
        ],
      ),
    );
  }
}
