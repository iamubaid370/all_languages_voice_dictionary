import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget reusableLangSwitch({
// {required IconData icon,
  // required List<Widget> actions,
  //required Color color
  required BuildContext context,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin1,
  EdgeInsetsGeometry? margin2,
}
    ) {
  RxString dropDownvalue = 'English'.obs;
  RxString dropDownValue2 = 'Urdu'.obs;
  var languages = [
    'English',
    'Urdu',
    'Pashto',
    'saraiki',
    'arabi',
    'punjabi',
    'spanish',
    'turkish'
  ];
  return Container(
    //color: Colors.red,
    height: Get.height * 0.07.h,
    //margin: margin,
    child: Material(
      //color: Colors.grey,
      color: Color(0xFFEFEFEF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(
                () => Container(
                  padding: padding,
                  margin: margin1,
                  //EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),color:  Color(0xFFE64D3D),),
                  child: DropdownButton(iconSize: 0,
                  underline: SizedBox(),
                  value: dropDownvalue.value,
                  items: languages.map((String languages) {
                    return DropdownMenuItem(
                      child: Text(languages,style: TextStyle(color: Colors.white),),
                      value: languages,
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    dropDownvalue.value = newValue!;
                  }),
                ),
          ),
          IconButton(
            onPressed: () {
              String temp = dropDownvalue.value;
              dropDownvalue.value = dropDownValue2.value;
              dropDownValue2.value = temp;
            },
            icon:
             SizedBox(
               height: Get.height * 0.035.h,
                 width:Get.height * 0.035.w,
                 //color: Colors.red,
                 child: Image.asset('assets/swap_arrows.png',),),
          ),
          Obx(() {
            return Container(
              padding: padding,
              margin: margin2,
              //EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),color:  Color(0xFFE64D3D),),
              child: DropdownButton(
                iconSize: 0,
                  underline: SizedBox(),
                  value: dropDownValue2.value,
                  items: languages.map((String languages) {
                    return DropdownMenuItem(
                      child: Center(child: Text(languages,style: TextStyle(color: Colors.white),)),
                      value: languages,
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    dropDownValue2.value = newValue!;
                  }),
            );
          }),
        ],
      ),
    ),
  );
}
