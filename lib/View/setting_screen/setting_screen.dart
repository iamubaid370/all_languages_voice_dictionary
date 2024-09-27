import 'package:all_languages_voice_dictionary/View/setting_screen/settingscreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';
import '../../global/global_variables.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Colors.grey.shade700,
                  ),
                  Text(
                    '           Notifications',
                    style: TextStyle(
                        fontFamily: 'Arial',
                        color: Colors.grey.shade700,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
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
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // Add blue border when ad is loaded
                    width: 1.5, // Border width
                  ),
                ),
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
