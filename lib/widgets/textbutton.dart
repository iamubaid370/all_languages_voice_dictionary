import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget customTextButton({
  required VoidCallback voidCallBack,
  required String title,
  EdgeInsets? padding,
  EdgeInsets? margin,
  Color? color,
  Radius? radius,
}) {
  return Container(
    margin: margin,
    padding: padding,
    width: Get.width * 0.65,
    height: Get.height * 0.07,
    child: TextButton(
        onPressed: voidCallBack,
        style: ButtonStyle(
          //backgroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0.r),
            // side: BorderSide(color: Colors.red)
          )),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400),
        )),
  );
}
