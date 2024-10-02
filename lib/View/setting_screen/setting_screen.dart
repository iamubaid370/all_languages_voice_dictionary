import 'package:all_languages_voice_dictionary/View/setting_screen/settingscreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';
import '../../global/global_variables.dart';
import '../language/LanguageSelectionScreen.dart';
import '../translation_screen/translation.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  SettingScreenController settingScreenController =
      Get.put(SettingScreenController());
  RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Setting'.tr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.white,
                fontFamily: 'arial')),
        centerTitle: true,
        backgroundColor: const Color(0xFFE64D3D),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Colors.grey.shade700,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Notifications'.tr,
                        style: TextStyle(
                            fontFamily: 'Arial',
                            color: Colors.grey.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
              trailing: Obx(
                () => Switch(
                  activeColor: Color(0xFFE64D3D),
                  value: settingScreenController.notificationSwitchValue.value,
                  onChanged: settingScreenController.onChangeNotificationSwitch,
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                Get.to(() => LanguageSelectionScreen(type: 'setting',));
              },
              child: ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.language,
                      color: Colors.grey.shade700,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Select Languages'.tr,
                          style: TextStyle(
                              fontFamily: 'Arial',
                              color: Colors.grey.shade700,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                        onPressed: () {
                          Get.to(() => LanguageSelectionScreen(type: 'setting',));
                        },
                        icon: Icon(Icons.keyboard_double_arrow_down,size: 25,color: Colors.grey.shade700,)),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Get.to(() => LanguageSelectionScreen());
            //   },
            //   child: ListTile(
            //     title: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Icon(
            //           Icons.language,
            //           color: Colors.grey.shade700,
            //         ),
            //         Expanded(
            //           child: Center(
            //             child: Text(
            //               'Languages',
            //               style: TextStyle(
            //                   fontFamily: 'Arial',
            //                   color: Colors.grey.shade700,
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.w700),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //     trailing: IconButton(
            //         onPressed: () {
            //           Get.to(() => LanguageSelectionScreen(type: 'setting',));
            //         },
            //         icon: Icon(Icons.arrow_drop_down_rounded,color: Colors.grey.shade700,)),
            //   ),
            // )
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        bool adLoaded =
            settingScreenController.adsHelper.isBannerAdLoaded.value &&
                settingScreenController.adsHelper.bannerAd != null &&
                !GlobalVariable.isAppOpenAdShowing.value &&
                !GlobalVariable.isInterstitialAdShowing.value;
        return adLoaded
            ? Container(
                child: SizedBox(
                  width: Get.width,
                  height: settingScreenController
                      .adsHelper.bannerAd!.size.height
                      .toDouble(),
                  child:
                      AdWidget(ad: settingScreenController.adsHelper.bannerAd!),
                ),
              )
            : Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: Get.width,
                  height: 55, // Adjust the height to match the ad height
                  color: Colors.grey.shade300, // Background color for shimmer
                  child: Center(
                    child: Text(
                      'Loading ad...', // Optional placeholder text
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
