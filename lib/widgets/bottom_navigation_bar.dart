import 'package:all_languages_voice_dictionary/View/history_screen/history_screen.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/home_screen.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/setting_screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

 // Widget bottomNavigationBar(RxInt currentIndex) {
//   HomeScreenController homeScreenController = Get.find();
//   return Expanded(
//     //height: Get.height * 0.06,
//     child: BottomNavigationBar(
//       onTap: (index) {
//         currentIndex.value = index;
//         if (currentIndex.value == 0) {
//           // Get.to(HomeScreen());
//           if (homeScreenController.adsHelper.interstitialAd != null) {
//             homeScreenController.adsHelper
//                 .showInterstitialAd(nextScreen: '/home');
//             Get.to(() => HomeScreen());
//             print('interstitial ad load successfuly');
//           } else {
//             print('interstitial ad not loaded');
//           }
//         } else if (currentIndex.value == 1) {
//           //Get.to(HistoryScreen());
//           if (homeScreenController.adsHelper.interstitialAd != null) {
//             Get.to(() => HistoryScreen());
//             homeScreenController.adsHelper
//                 .showInterstitialAd(nextScreen: '/history');
//             print('interstitial ad load successfuly');
//           } else {
//             print('interstitial ad not loaded');
//           }
//         } else if (currentIndex.value == 2) {
//           Get.to(SettingScreen());
//         }
//       },
//       selectedItemColor: Colors.grey,
//       unselectedItemColor: Colors.grey,
//       // selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
//       // unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
//       items: [
//         BottomNavigationBarItem(
//           icon: SizedBox(
//             height: Get.height * 0.03,
//             child: Image.asset(
//               'assets/home.png',
//             ),
//           ),
//           label: 'Home'.tr,
//         ),
//         BottomNavigationBarItem(
//           icon: SizedBox(
//             height: Get.height * 0.03,
//             child: Image.asset('assets/history.png'),
//           ),
//           label: 'History'.tr,
//         ),
//         BottomNavigationBarItem(
//           icon: SizedBox(
//             height: Get.height * 0.03,
//             child: Image.asset('assets/setting.png'),
//           ),
//           label: 'Setting'.tr,
//         ),
//       ],
//     ),
//   );
// }

Widget bottomNavigationBar(RxInt currentIndex) {
  HomeScreenController homeScreenController = Get.find();

  return BottomNavigationBar(
    onTap: (index) {
      currentIndex.value = index;

      if (currentIndex.value == 0) {
        if (homeScreenController.adsHelper.interstitialAd != null) {
          homeScreenController.adsHelper
              .showInterstitialAd(nextScreen: '/home');
          Get.to(() => HomeScreen());
          print('Interstitial ad loaded successfully.');
        } else {
          Get.to(() => HomeScreen());
          print('Interstitial ad not loaded.');
        }
      } else if (currentIndex.value == 1) {
        if (homeScreenController.adsHelper.interstitialAd != null) {
          Get.to(() => HomeScreen());
          homeScreenController.adsHelper
              .showInterstitialAd(nextScreen: '/history');
          print('Interstitial ad loaded successfully.');
        } else {
          Get.to(() => HomeScreen());
          print('Interstitial ad not loaded.');
        }
      } else if (currentIndex.value == 2) {
        Get.to(() => SettingScreen());
      }
    },
    selectedItemColor: Colors.grey,
    unselectedItemColor: Colors.grey,
    items: [
      BottomNavigationBarItem(
        icon: SizedBox(
          height: Get.height * 0.03,
          child: Image.asset('assets/home.png'),
        ),
        label: 'Home'.tr,
      ),
      BottomNavigationBarItem(
        icon: SizedBox(
          height: Get.height * 0.03,
          child: Image.asset('assets/history.png'),
        ),
        label: 'History'.tr,
      ),
      BottomNavigationBarItem(
        icon: SizedBox(
          height: Get.height * 0.03,
          child: Image.asset('assets/setting.png'),
        ),
        label: 'Setting'.tr,
      ),
    ],
  );
}
