import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsHelper {
  RxBool isAppOpenAdShowing = false.obs;
  RxBool isBannerAdLoaded = false.obs;
  RxBool isNativeAdLoaded = false.obs;
  RxBool isInterstitialAdLoaded = false.obs;

  AppOpenAd? appOpenAd;
  BannerAd? bannerAd;
  NativeAd? nativeAd;
  InterstitialAd? interstitialAd;

  final appOpenAdUnitId = "ca-app-pub-3940256099942544/9257395921";
  final bannerAdUnitId = "ca-app-pub-3940256099942544/6300978111";
  final nativeAdUnitId = "ca-app-pub-3940256099942544/2247696110";
  final interstitialAdUnitId ="ca-app-pub-3940256099942544/1033173712";

  void loadAppOpenAd() {
    if (appOpenAd == null && true) {
      AppOpenAd.load(
        adUnitId: appOpenAdUnitId,
        request: AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
            onAdLoaded: (ad) {
              appOpenAd = ad;
            },
            onAdFailedToLoad: (error) {}),
      );
    }
  }

  void appOpenAdCallback() {
    appOpenAd?.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
      appOpenAd?.dispose();
      appOpenAd = null;
      isAppOpenAdShowing.value = false;
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      print("${isAppOpenAdShowing.value.toString()}");
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      loadAppOpenAd();
    });
  }

  Future<void> showAppOpenAd() async {
    if (appOpenAd != null) {
      isAppOpenAdShowing.value = true;
      print(")))))))))))))))))))))))");
      print("${isAppOpenAdShowing.value.toString()}");
      print(")))))))))))))))))))))))");
      appOpenAdCallback();
      await appOpenAd?.show();
    } else {
      loadAppOpenAd();
    }
  }

  // void loadBannerAd() {
  //   if (bannerAd != null) {
  //     bannerAd!.dispose();
  //     bannerAd = null;
  //   }
  //   bannerAd = BannerAd(
  //     size: AdSize.banner,
  //     adUnitId: bannerAdUnitId,
  //     listener: BannerAdListener(onAdLoaded: (ad) {
  //       isBannerAdLoaded.value = true;
  //     }, onAdFailedToLoad: (ad, error) {
  //       ad.dispose();
  //     }),
  //     request: AdRequest(),
  //   );
  //   bannerAd?.load();
  // }

  Future<void> loadBannerAd() async {
      bannerAd = BannerAd(
        // TODO: replace these test ad units with your own ad unit.
        adUnitId: bannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),

        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            debugPrint("----------------------------------------");
            debugPrint('$ad loaded: ${ad.responseInfo}');
            debugPrint("banner ad has now been load");
            bannerAd = ad as BannerAd;
            isBannerAdLoaded.value = true;
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            debugPrint("----------------------------------------");
            debugPrint('Anchored adaptive banner failedToLoad: $error');
            debugPrint("banner ad has failed to load");
            ad.dispose();
          },
        ),
      );
      return bannerAd?.load();
  }

  Future<void> loadNativeAd() async {
    if (nativeAd != null) {
      nativeAd!.dispose();
      nativeAd = null;
    }

    nativeAd = NativeAd(
      adUnitId: nativeAdUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          isNativeAdLoaded.value = true;
          nativeAd = ad as NativeAd;
          debugPrint('NATIVE AD LOADED');
          debugPrint('NATIVE AD LOADED');
          debugPrint('NATIVE AD LOADED');
          debugPrint('NATIVE AD LOADED');
          debugPrint('NATIVE AD LOADED');
          debugPrint('NATIVE AD LOADED');
          debugPrint('NATIVE AD LOADED');
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('NATIVE ADD NOT LOADED:$error');
        },
      ),
      request: AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.orange,
        cornerRadius: 10,
      ),
    );
     await nativeAd?.load();
  }

  void loadInterstitialAd(){
    InterstitialAd.load(adUnitId: interstitialAdUnitId, request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad){
              ad.fullScreenContentCallback= FullScreenContentCallback(onAdShowedFullScreenContent: (ad){
                print('onAdShowedFullScreenContent called');
              },
                onAdFailedToShowFullScreenContent: (ad,error){
                ad.dispose();
                loadInterstitialAd();
                },
                onAdDismissedFullScreenContent: (ad){
                ad.dispose();
                loadInterstitialAd();
                },
                onAdClicked: (ad){
                print('onAdClicked');
                },
              );
              interstitialAd = ad;

            },
            onAdFailedToLoad: (error){
              print('Failed to Load InterstitialAd');
            }));
  }



  disposeAds(){
    appOpenAd?.dispose();
    bannerAd?.dispose();
    nativeAd?.dispose();
    interstitialAd?.dispose();
    nativeAd = null;
  }

}
