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
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        screenWidth as int);

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
            listener: const BannerAdListener())
        .load();
  }

  disposeAds() {
    bannerAd?.dispose();
    nativeAd?.dispose();
    interstitialAd?.dispose();
    appOpenAd?.dispose();
  }
}
