
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget customIconButton(VoidCallback voidCallback, String icon){
  return IconButton(
    onPressed:voidCallback,
    icon: SizedBox(
      height: Get.height * 0.035.h,
      width: Get.height * 0.035.w,
      //color: Colors.red,
      child: Image.asset(
        icon,
      ),
    ),
  );
}