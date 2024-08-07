import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class SpeakerAnimation extends StatelessWidget {
  const SpeakerAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Positioned(
        // bottom: 100.h,
        // right: 100.w,
        child: Image.asset(
          'assets/speaker_animation.gif',
          height: Get.height.h,

          //fit: BoxFit.fill,

        ),
      ),
    );
  }
}
