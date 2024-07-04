
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


}){
  return
    InkWell(
      onTap:onTap ,
      child: Stack(
        children: [
          Container(
            //color: Colors.blue,
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
  //   Stack(
  //   children: [
  //     Container(
  //       color: Colors.red,
  //       height: Get.height * 0.1,
  //         width: Get.width * 0.25,
  //         child: Image.asset(image1!),),
  //     Text(title),
  //     Container(
  //       height: Get.height * 0.1,
  //         width: Get.width * 0.25,
  //         child: Image.asset(image2!),),
  //   ],
  // );
}