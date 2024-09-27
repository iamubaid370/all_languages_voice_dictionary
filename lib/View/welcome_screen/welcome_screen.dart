import 'dart:io';

import 'package:all_languages_voice_dictionary/View/history_screen/history_screen.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/home_screen.dart';
import 'package:all_languages_voice_dictionary/View/setting_screen/setting_screen.dart';
import 'package:all_languages_voice_dictionary/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_screen/homescreen_controller.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // HomeScreenController homeScreenController = Get.find();
  int currentIndex = 0;
  final List screens = [
    HomeScreen(),
    HistoryScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final result = await customDialogBox(
            title: 'Exit App'.tr,
            voidCallBack: () {
              exit(0);
            },
            voidCallBack2: Get.back,
            content: 'Are you sure to exit from App?'.tr,
            context: context);
        return result;
      },
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          selectedItemColor: Color(0xFFE64D3D),
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                height: Get.height * 0.03,
                child: Image.asset('assets/home.png',
                    color: currentIndex == 0 ? Color(0xFFE64D3D) : Colors.grey),
              ),
              label: 'Home'.tr,
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: Get.height * 0.03,
                child: Image.asset('assets/history.png',
                    color: currentIndex == 1 ? Color(0xFFE64D3D) : Colors.grey),
              ),
              label: 'History'.tr,
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: Get.height * 0.03,
                child: Image.asset('assets/setting.png',
                    color: currentIndex == 2 ? Color(0xFFE64D3D) : Colors.grey),
              ),
              label: 'Setting'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
