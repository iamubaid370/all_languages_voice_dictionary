import 'dart:async';
import 'dart:io';

import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:all_languages_voice_dictionary/fireBase/remoteConfig/remoteConfigServices.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class SplashController extends GetxController{
//
//
//   @override
//   void onReady(){
//     super.onReady();
//     checkNotificationSetting();
//   }
//   checkNotificationSetting() {
//     bool? res = GetStorage().read('notificationValue');
//     if (res == null) {
//       GetStorage().write('notificationValue', true);
//       showLocalNotificationPeriodically();
//     }
//   }
// }

import '../../database/db_helper.dart';
import '../../fireBase/remoteConfig/remoteConfigKeys.dart';
import '../../global/global_variables.dart';
import '../../services/notification.dart'; // Update this import to your DbHelper class

class SplashController extends GetxController {
  //HomeScreenController homeScreenController = Get.put(HomeScreenController());
  AdsHelper adsHelper = AdsHelper();
  var loadingProgress = 0.obs;
  RxDouble progressValue = 0.0.obs;
  RxBool showProgressBar = true.obs;


  final remoteConfig =  FirebaseRemoteConfig.instance;

  @override
  Future<void> onReady() async {
    super.onReady();
    checkNotificationSetting();
    startLoading();



    ///Get Remote Config
     FirebaseRemoteConfigService().fetchAndActivate();


    if (Platform.isAndroid) {
      await getAllTheValesOfRemoteConfigAndroid();
      await getAllTheValesOfRemoteConfigAndroid_update();
      print("PLAT FORM IS ANDROID +_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_");
     }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    adsHelper.loadAppOpenAd();
    adsHelper.loadBannerAd();
    super.onInit();
  }

  void checkNotificationSetting() async {
    bool res = await DbHelper.dbInstance.getNotificationSetting();
    if (res == null) {
      /// If there is no value in the database, set it to true by default
      await DbHelper.dbInstance.insertOrUpdateNotificationSetting(true);
      showLocalNotificationPeriodically();
    } else if (res == true) {
      /// If the value is true, continue with periodic notifications
      showLocalNotificationPeriodically();
    }

    /// If the value is false, do nothing (notifications are disabled)
  }

  void _checkLanguageSelectionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? seenLanguageSelection =
        prefs.getBool('seenLanguageSelection') ?? false;
    bool? seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

    if (seenLanguageSelection) {
      if (seenOnboarding) {
        Get.offNamed('/welcome');
        print(seenOnboarding);
      } else {
        Get.offNamed('/onBoardingScreen');
        print(seenOnboarding);
      }
    } else {
      Get.offNamed('/languageLocalizationScreen');
      print(seenOnboarding);
    }
  }

  // void startLoading(){
  //   Timer.periodic(Duration(seconds:15 ),(timer){
  //     if(loadingProgress.value<100){
  //       loadingProgress.value+=10;
  //
  //     }else{
  //       timer.cancel();
  //       print("Progress complete, showing ad...");
  //       adsHelper.showAppOpenAd();
  //     }
  //   });
  //
  // }

  void startLoading() {
    const totalDuration = Duration(seconds: 5); // Adjust the duration as needed
    const updateFrequency = Duration(milliseconds: 100);
    final totalSteps =
        totalDuration.inMilliseconds ~/ updateFrequency.inMilliseconds;

    int currentStep = 0;

    Timer.periodic(updateFrequency, (Timer timer) {
      if (currentStep >= totalSteps) {
        progressValue.value = 100.0;
        timer.cancel();
        showProgressBar.value = false;
        adsHelper.showAppOpenAd();
        _checkLanguageSelectionStatus();
      } else {
        progressValue.value = (currentStep / totalSteps) * 100;
        currentStep++;
      }
    });
  }






  Future<void> getAllTheValesOfRemoteConfigAndroid() async {
    try {
      FirebaseRemoteConfigService remoteConfigService =
          FirebaseRemoteConfigService();

      await remoteConfigService.fetchAndActivate();

      ///Collapsible Banner Ad Remote Config
      ///
      ///
      GlobalVariable.instatitalRemoteConfig.value = remoteConfigService.getBool(RemoteConfigKeys.interstitialAdKey);
      GlobalVariable.nativeAdRemoteConfig.value = remoteConfigService.getBool(RemoteConfigKeys.nativeAdKey);
      GlobalVariable.isAdShowRemoteConfig.value = remoteConfigService.getBool(RemoteConfigKeys.showAds);
      GlobalVariable.homeNativeAdRemoteConfig.value = remoteConfigService.getBool(RemoteConfigKeys.homeScreenNativeAd);
      GlobalVariable.homeBannerAdRemoteConfig.value = remoteConfigService.getBool(RemoteConfigKeys.homeScreenBannerAd);
      GlobalVariable.LanguageSelectionScreenNativeAd.value = remoteConfigService.getBool(RemoteConfigKeys.LanguageSelectionScreenNativeAd);
      GlobalVariable.LanguageSelectionScreenBannerAd.value = remoteConfigService.getBool(RemoteConfigKeys.LanguageSelectionScreenBannerAd);



      print("++++++++++++++++++++++++++++++++++++");

      print(
          "Text to Speech Screen Banner: ${GlobalVariable.instatitalRemoteConfig.value}\n"
          "Remote Config nativeAdRemoteConfig String is: ${GlobalVariable.nativeAdRemoteConfig.value}\n"
          "IS NATIVE AD SHOW value IS: ${GlobalVariable.isAdShowRemoteConfig.value}");
    } catch (e) {
      print("Exception Of getAllTheValesOfRemoteConfig${e.toString()}");
    }
  }



  Future<void> getAllTheValesOfRemoteConfigAndroid_update() async {


    try {
      FirebaseRemoteConfigService remoteConfigService =
      FirebaseRemoteConfigService();


      remoteConfig.onConfigUpdated.listen((event) async {
        await remoteConfig.activate();

        await remoteConfigService.fetchAndActivate();

        ///Collapsible Banner Ad Remote Config
        ///
        ///
        GlobalVariable.instatitalRemoteConfig.value = remoteConfigService.getBool(RemoteConfigKeys.interstitialAdKey);
        GlobalVariable.nativeAdRemoteConfig.value = remoteConfigService.getBool(RemoteConfigKeys.nativeAdKey);
        GlobalVariable.isAdShowRemoteConfig.value = remoteConfigService.getBool(RemoteConfigKeys.showAds);
        GlobalVariable.homeNativeAdRemoteConfig.value = remoteConfigService.getBool(RemoteConfigKeys.homeScreenNativeAd);
        GlobalVariable.homeBannerAdRemoteConfig.value = remoteConfigService.getBool(RemoteConfigKeys.homeScreenBannerAd);
        GlobalVariable.LanguageSelectionScreenNativeAd.value = remoteConfigService.getBool(RemoteConfigKeys.LanguageSelectionScreenNativeAd);
        GlobalVariable.LanguageSelectionScreenBannerAd.value = remoteConfigService.getBool(RemoteConfigKeys.LanguageSelectionScreenBannerAd);

        print("++++++++++++++++++++++++++++++++++++");

        print(
            " After Update  ::Text to Speech Screen Banner: ${GlobalVariable.instatitalRemoteConfig.value}\n"
                " After Update ::    Remote Config nativeAdRemoteConfig String is: ${GlobalVariable.nativeAdRemoteConfig.value}\n"
                "After Update :: IS NATIVE AD SHOW value IS: ${GlobalVariable.isAdShowRemoteConfig.value}");
      }
      );

    } catch (e) {
      print("Exception Of getAllTheValesOfRemoteConfig${e.toString()}");
    }
  }



}
