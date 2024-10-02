import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/splash_screen/splash2.dart';
import 'package:all_languages_voice_dictionary/View/splash_screen/splash4.dart';
import 'package:all_languages_voice_dictionary/View/splash_screen/splashscreen_controller.dart';
import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:all_languages_voice_dictionary/widgets/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';
import '../../global/global_variables.dart';
import '../home_screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  //final LocalizationController localizationController = Get.put(LocalizationController());
  SplashController splashController = Get.put(SplashController());

  //HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () {
          bool isAdLoaded = splashController.adsHelper.isBannerAdLoaded.value &&
              splashController.adsHelper.bannerAd != null &&
              !GlobalVariable.isAppOpenAdShowing.value &&
              !GlobalVariable.isInterstitialAdShowing.value;

          return isAdLoaded
              ? Container(
                  child: SizedBox(
                    width: Get.width,
                    height: splashController.adsHelper.bannerAd!.size.height
                        .toDouble(),
                    child: AdWidget(ad: splashController.adsHelper.bannerAd!),
                  ),
                )
              : Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: Get.width,
                    height: 55,
                    color: Colors.grey.shade300,
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
        },
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: Get.height * 0.5,
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      'WELCOME TO', // First part of the text
                      style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFE64D3D), // Color for the first part
                      ),
                    ),
                    Text(
                      'All Languages Voice Dictionary\nNo 1 Dictionary in the World',
                      // Second part of the text
                      style: TextStyle(
                        overflow: TextOverflow.visible, //

                        fontSize: 12,
                        fontFamily: 'Arial',
                        //fontWeight: FontWeight.w400,
                        color:
                            Color(0xFFE64D3D), // Same color or change if needed
                      ),
                    ),
                    //Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Image.asset('assets/dictionary1.png'),
                    ),
                    Spacer(),
                  ],
                ),
              ),

              // Inside your SplashController (assuming you have a controller for the splash screen)
              Obx(() {
                return splashController.showProgressBar.value
                    ? CircularProgressIndicator(
                        value: splashController.progressValue.value / 100,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFFE64D3D)),
                      )
                    :ElevatedButton(
                  onPressed: () {
                    splashController.checkLanguageSelectionStatus();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2, vertical: 15), // Horizontal padding based on screen width
                    backgroundColor: Color(0xFFE64D3D), // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 16, // Font size
                      fontWeight: FontWeight.bold, // Bold text
                    ),
                  ),
                );

              }),

              // SplashController(). progressValue.value <= 100.0 ?
              // CircularProgressIndicator(
              //   valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE64D3D)),
              // )
              //     :TextButton(onPressed: (){}, child: Text('Get Started')),
            ],
          ),
        ),
      ),
    );
  }
}
