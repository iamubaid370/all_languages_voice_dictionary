// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class AdsHelper {
//   RxBool isAppOpenAdShowing = false.obs;
//   RxBool isBannerAdLoaded = false.obs;
//   RxBool isNativeAdLoaded = false.obs;
//   RxBool isInterstitialAdLoaded = false.obs;
//
//   AppOpenAd? appOpenAd;
//   BannerAd? bannerAd;
//   NativeAd? nativeAd;
//   InterstitialAd? interstitialAd;
//
//   final appOpenAdUnitId = "ca-app-pub-3940256099942544/9257395921";
//   final bannerAdUnitId = "ca-app-pub-3940256099942544/6300978111";
//   final nativeAdUnitId = "ca-app-pub-3940256099942544/2247696110";
//   final interstitialAdUnitId ="ca-app-pub-3940256099942544/1033173712";
//
//   void loadAppOpenAd() {
//     if (appOpenAd == null && true) {
//       AppOpenAd.load(
//         adUnitId: appOpenAdUnitId,
//         request: AdRequest(),
//         adLoadCallback: AppOpenAdLoadCallback(
//             onAdLoaded: (ad) {
//               appOpenAd = ad;
//             },
//             onAdFailedToLoad: (error) {}),
//       );
//     }
//   }
//
//   void appOpenAdCallback() {
//     appOpenAd?.fullScreenContentCallback =
//         FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
//       appOpenAd?.dispose();
//       appOpenAd = null;
//       isAppOpenAdShowing.value = false;
//       print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//       print("${isAppOpenAdShowing.value.toString()}");
//       print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//       loadAppOpenAd();
//     });
//   }
//
//   Future<void> showAppOpenAd() async {
//     if (appOpenAd != null) {
//       isAppOpenAdShowing.value = true;
//       print(")))))))))))))))))))))))");
//       print("${isAppOpenAdShowing.value.toString()}");
//       print(")))))))))))))))))))))))");
//       appOpenAdCallback();
//       await appOpenAd?.show();
//     } else {
//       loadAppOpenAd();
//     }
//   }
//
//   // void loadBannerAd() {
//   //   if (bannerAd != null) {
//   //     bannerAd!.dispose();
//   //     bannerAd = null;
//   //   }
//   //   bannerAd = BannerAd(
//   //     size: AdSize.banner,
//   //     adUnitId: bannerAdUnitId,
//   //     listener: BannerAdListener(onAdLoaded: (ad) {
//   //       isBannerAdLoaded.value = true;
//   //     }, onAdFailedToLoad: (ad, error) {
//   //       ad.dispose();
//   //     }),
//   //     request: AdRequest(),
//   //   );
//   //   bannerAd?.load();
//   // }
//
//   Future<void> loadBannerAd() async {
//       bannerAd = BannerAd(
//         // TODO: replace these test ad units with your own ad unit.
//         adUnitId: bannerAdUnitId,
//         size: AdSize.banner,
//         request: const AdRequest(),
//
//         listener: BannerAdListener(
//           onAdLoaded: (Ad ad) {
//             debugPrint("----------------------------------------");
//             debugPrint('$ad loaded: ${ad.responseInfo}');
//             debugPrint("banner ad has now been load");
//             bannerAd = ad as BannerAd;
//             isBannerAdLoaded.value = true;
//           },
//           onAdFailedToLoad: (Ad ad, LoadAdError error) {
//             debugPrint("----------------------------------------");
//             debugPrint('Anchored adaptive banner failedToLoad: $error');
//             debugPrint("banner ad has failed to load");
//             ad.dispose();
//           },
//         ),
//       );
//       return bannerAd?.load();
//   }
//
//   Future<void> loadNativeAd() async {
//     if (nativeAd != null) {
//       nativeAd!.dispose();
//       nativeAd = null;
//     }
//
//     nativeAd = NativeAd(
//       adUnitId: nativeAdUnitId,
//       listener: NativeAdListener(
//         onAdLoaded: (ad) {
//           isNativeAdLoaded.value = true;
//           nativeAd = ad as NativeAd;
//           debugPrint('NATIVE AD LOADED');
//           debugPrint('NATIVE AD LOADED');
//           debugPrint('NATIVE AD LOADED');
//           debugPrint('NATIVE AD LOADED');
//           debugPrint('NATIVE AD LOADED');
//           debugPrint('NATIVE AD LOADED');
//           debugPrint('NATIVE AD LOADED');
//         },
//         onAdFailedToLoad: (ad, error) {
//           ad.dispose();
//           debugPrint('NATIVE ADD NOT LOADED:$error');
//         },
//       ),
//       request: AdRequest(),
//       nativeTemplateStyle: NativeTemplateStyle(
//         templateType: TemplateType.small,
//         mainBackgroundColor: Colors.orange,
//         cornerRadius: 10,
//       ),
//     );
//      await nativeAd?.load();
//   }
//
//   void loadInterstitialAd(){
//     InterstitialAd.load(adUnitId: interstitialAdUnitId, request: AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//             onAdLoaded: (ad){
//               ad.fullScreenContentCallback= FullScreenContentCallback(onAdShowedFullScreenContent: (ad){
//                 print('onAdShowedFullScreenContent called');
//               },
//                 onAdFailedToShowFullScreenContent: (ad,error){
//                 ad.dispose();
//                 loadInterstitialAd();
//                 },
//                 onAdDismissedFullScreenContent: (ad){
//                 ad.dispose();
//                 loadInterstitialAd();
//                 },
//                 onAdClicked: (ad){
//                 print('onAdClicked');
//                 },
//               );
//               interstitialAd = ad;
//
//             },
//             onAdFailedToLoad: (error){
//               print('Failed to Load InterstitialAd');
//             }));
//   }
//
//
//
//   disposeAds(){
//     appOpenAd?.dispose();
//     bannerAd?.dispose();
//     nativeAd?.dispose();
//     interstitialAd?.dispose();
//     nativeAd = null;
//   }
//
// }




///Ads Helper Class
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../global/global_variables.dart';

class AdsHelper {
  RxBool isBannerAdLoaded = false.obs;
  RxBool isNativeAdLoaded = false.obs;
  RxBool isNativeAd2Loaded = false.obs;
  RxBool isNativeAd3Loaded = false.obs;


  BannerAd? bannerAd;
  NativeAd? nativeAd;
  NativeAd? nativeAd2;
  NativeAd? nativeAd3;
  AppOpenAd? appOpenAd;
  InterstitialAd? interstitialAd;

  final bannerAdUnitId = Platform.isAndroid
      ? GlobalVariable.bannerAdAndroid
      : GlobalVariable.bannerAdIOS;

  final nativeAdUnitId = Platform.isAndroid
      ? GlobalVariable.nativeAdAndroid
      : GlobalVariable.nativeAdIOS;

  final interAdUnitId = Platform.isAndroid
      ? GlobalVariable.interAdAndroid
      : GlobalVariable.interAdIOS;

  final appOpenAdUnitId = Platform.isAndroid
      ? GlobalVariable.openAppAndroid
      : GlobalVariable.openAppAdIOS;

  void loadInterstitialAd() {
    if (!GlobalVariable.isPurchasedMonthly.value &&
        !GlobalVariable.isPurchasedYearly.value &&
        !GlobalVariable.isPurchasedLifeTime.value) {
      InterstitialAd.load(
          adUnitId: interAdUnitId,
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            // Called when an ad is successfully received.
            onAdLoaded: (ad) {
              debugPrint('$ad loaded.');
              print('InterstitialAd Loaded');
              // Keep a reference to the ad so you can show it later.
              interstitialAd = ad;
            },
            // Called when an ad request failed.
            onAdFailedToLoad: (LoadAdError error) {
              debugPrint('InterstitialAd failed to load: $error');
              print('InterstitialAd Not Loaded');
            },
          ));
    }
  }

  void showInterstitialAd({bool isSplash = false, required String nextScreen}) {
    if (GlobalVariable.showInterstitialAd) {
      if (interstitialAd != null) {
        GlobalVariable.isInterstitialAdShowing.value = true;
        interstitialAdCallback(isSplash: isSplash, nextScreen: nextScreen);
        interstitialAd?.show();
      } else {
        Get.toNamed(nextScreen);
        loadInterstitialAd();
      }
    } else {
      Get.toNamed(nextScreen);
      GlobalVariable.showInterstitialAd = true;
    }
  }

  void interstitialAdCallback(
      {required bool isSplash, required String nextScreen}) {
    interstitialAd?.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
          interstitialAd?.dispose();
          interstitialAd = null;
          GlobalVariable.showInterstitialAd = false;
          GlobalVariable.isInterstitialAdShowing.value = false;
          if (!isSplash) {
            Get.toNamed(nextScreen);
            loadInterstitialAd();
          } else {
            Get.offNamed(nextScreen);
          }
        });
  }

  void loadAppOpenAd() {
    if (appOpenAd == null) {
      AppOpenAd.load(
        adUnitId: appOpenAdUnitId,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            appOpenAd = ad;
            print('openAppAd loaded');
          },
          onAdFailedToLoad: (error) {
            print('openAppAd error');
          },
        ),
      );
    }
  }

  void showAppOpenAd() {
    if (appOpenAd != null) {
      GlobalVariable.isAppOpenAdShowing.value = true;
      appOpenAdCallback();
      appOpenAd?.show();
    } else {
      loadAppOpenAd();
    }
  }

  void appOpenAdCallback() {
    appOpenAd?.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
          appOpenAd?.dispose();
          appOpenAd = null;
          GlobalVariable.isAppOpenAdShowing.value = false;
          loadAppOpenAd();
        });
  }

  void loadNativeAd() {
    NativeAd(
      adUnitId: nativeAdUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('$NativeAd loaded.');
          nativeAd = null;
          nativeAd = ad as NativeAd;
          isNativeAdLoaded.value = true;
          print(ad.nativeAdOptions?.mediaAspectRatio);
        },
        onAdFailedToLoad: (ad, error) {
          // Dispose the ad here to free resources.
          debugPrint('$NativeAd failed to load: $error');
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        // mainBackgroundColor: ThemeHelper.primaryColor,
        // cornerRadius: 10.0,
        callToActionTextStyle: NativeTemplateTextStyle(
            textColor: Colors.white,
            // backgroundColor: ThemeHelper.secondaryColor,
            style: NativeTemplateFontStyle.bold,
            size: 13.5),
        primaryTextStyle: NativeTemplateTextStyle(
          // textColor: ThemeHelper.s,
          // backgroundColor: ThemeColors.bgColor.withOpacity(0.7),
            style: NativeTemplateFontStyle.italic,
            size: 13.5),
        secondaryTextStyle: NativeTemplateTextStyle(
          // textColor: ThemeColors.secondary,
          // backgroundColor: ThemeColors.bgColor.withOpacity(0.7),
            style: NativeTemplateFontStyle.bold,
            size: 13),
        tertiaryTextStyle: NativeTemplateTextStyle(
          // textColor: ThemeColors.secondary,
          // backgroundColor: ThemeColors.bgColor.withOpacity(0.7),
            style: NativeTemplateFontStyle.normal,
            size: 13),
      ),
    ).load();
  }

  void loadNativeAd2() {
    NativeAd(
      adUnitId: nativeAdUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('$NativeAd Native2 loaded.');
          nativeAd2 = null;
          nativeAd2 = ad as NativeAd;
          isNativeAd2Loaded.value = true;
          print(ad.nativeAdOptions?.mediaAspectRatio);
        },
        onAdFailedToLoad: (ad, error) {
          // Dispose the ad here to free resources.
          debugPrint('$NativeAd failed to load: $error');
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        // mainBackgroundColor: ThemeHelper.primaryColor,
        // cornerRadius: 10.0,
        callToActionTextStyle: NativeTemplateTextStyle(
            textColor: Colors.white,
            // backgroundColor: ThemeHelper.secondaryColor,
            style: NativeTemplateFontStyle.bold,
            size: 13.5),
        primaryTextStyle: NativeTemplateTextStyle(
          // textColor: ThemeHelper.s,
          // backgroundColor: ThemeColors.bgColor.withOpacity(0.7),
            style: NativeTemplateFontStyle.italic,
            size: 13.5),
        secondaryTextStyle: NativeTemplateTextStyle(
          // textColor: ThemeColors.secondary,
          // backgroundColor: ThemeColors.bgColor.withOpacity(0.7),
            style: NativeTemplateFontStyle.bold,
            size: 13),
        tertiaryTextStyle: NativeTemplateTextStyle(
          // textColor: ThemeColors.secondary,
          // backgroundColor: ThemeColors.bgColor.withOpacity(0.7),
            style: NativeTemplateFontStyle.normal,
            size: 13),
      ),
    ).load();
  }
  void loadNativeAd3() {
    NativeAd(
      adUnitId: nativeAdUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('$NativeAd Native3 loaded.');
          nativeAd3 = null;
          nativeAd3 = ad as NativeAd;
          isNativeAd3Loaded.value = true;
          print(ad.nativeAdOptions?.mediaAspectRatio);
        },
        onAdFailedToLoad: (ad, error) {
          // Dispose the ad here to free resources.
          debugPrint('$NativeAd failed to load: $error');
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small,
        // mainBackgroundColor: ThemeHelper.primaryColor,
        // cornerRadius: 10.0,
        callToActionTextStyle: NativeTemplateTextStyle(
            textColor: Colors.white,
            // backgroundColor: ThemeHelper.secondaryColor,
            style: NativeTemplateFontStyle.bold,
            size: 13.5),
        primaryTextStyle: NativeTemplateTextStyle(
          // textColor: ThemeHelper.s,
          // backgroundColor: ThemeColors.bgColor.withOpacity(0.7),
            style: NativeTemplateFontStyle.italic,
            size: 13.5),
        secondaryTextStyle: NativeTemplateTextStyle(
          // textColor: ThemeColors.secondary,
          // backgroundColor: ThemeColors.bgColor.withOpacity(0.7),
            style: NativeTemplateFontStyle.bold,
            size: 13),
        tertiaryTextStyle: NativeTemplateTextStyle(
          // textColor: ThemeColors.secondary,
          // backgroundColor: ThemeColors.bgColor.withOpacity(0.7),
            style: NativeTemplateFontStyle.normal,
            size: 13),
      ),
    ).load();
  }

  void loadBannerAd() async {
    final AnchoredAdaptiveBannerAdSize? size =
    await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        Get.width.truncate());

    BannerAd(
      adUnitId: bannerAdUnitId,
      //adUnitId: bannerAdUnitId,
      size: size!,
      //request: const AdRequest(),
      request: const AdRequest(extras: {"collapsible": "bottom"}),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          log('Banner loaded');
          bannerAd = ad as BannerAd;
          isBannerAdLoaded.value = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    ).load();
  }

  void loadCollapsibleAd() async {
    // Replace these test ad units with your own ad units.
    final String adUnitId = Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/2014213617'
        : 'ca-app-pub-3940256099942544/8388050270';

    // Get the size before loading the ad.
    double screenWidth = Get.size.width.truncateToDouble();
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(screenWidth as int);

    if (size == null) {
      // Unable to get the size.
      return;
    }

    // Create an extra parameter that aligns the bottom of the expanded ad to the
    // bottom of the banner ad.
    const adRequest = AdRequest(extras: {
      "collapsible": "bottom",
    });

    BannerAd(
        adUnitId: adUnitId,
        request: adRequest,
        size: size,
        listener: const BannerAdListener()
    ).load();
  }

  disposeAds() {
    bannerAd?.dispose();
    nativeAd?.dispose();
    interstitialAd?.dispose();
    appOpenAd?.dispose();
  }
}
