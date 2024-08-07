import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget reusableStack({
  required String title,
  String? image1,
  String? image2,
  EdgeInsets? padding,
  EdgeInsets? padding1,
  EdgeInsets? padding2,
  double? height,
  double? width,
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Stack(
      children: [
        Container(
          //padding: padding,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: Get.height * 0.14.h,
          width: Get.width * 0.27.w,
          child: Image.asset(image1!),
        ),
        Padding(
          //padding: EdgeInsets.only(top: 60,left: 20),
          padding: padding2!,
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          // height: Get.height * 0.07,
          // width: Get.width * 0.18,
          //color: Colors.green,
          //padding: EdgeInsets.only(left:85,bottom: 20),

          padding: padding1,
          //margin: EdgeInsets.only(bottom:10 ),
          child: Image.asset(
            image2!,
            // height: Get.height * 0.1,
            // width: Get.width * 0.1,
            height: height?.h,
            width: width?.h,
            fit: BoxFit.contain,
          ),
        ),
      ],
    ),
  );
}

Widget reusableStack1({
  required String image,
  required String title,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Stack(
      children: [
        Container(
          height: Get.height * 0.17.h,
          width: Get.width * 0.29.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: EdgeInsets.only(
                left: Get.width * 0.07,
                right: Get.width * 0.07,
                bottom: Get.width * 0.1,
                top: Get.width * 0.07),
            padding: EdgeInsets.only(bottom: 5),
            //color: Colors.blue,
            alignment: Alignment.center,
            height: 45,
            width: 30,
            child: Image.asset(
              image,
              // height: 44,
              // width: 42,
              //width: Get.width * 0.23,
              fit: BoxFit.cover,
            ),
          ),
          // Image.asset(
          //   image,
          //   fit: BoxFit.fitWidth,),
        ),
        Padding(
          padding: EdgeInsets.only(top: Get.height * 0.1, left: 15),
          child: Center(
              child: Text(
            title,
            style: TextStyle(
                color: Color(0xFFE64D3D), fontFamily: 'Arial', fontSize: 13),
          )),
        ),
      ],
    ),
  );
}
