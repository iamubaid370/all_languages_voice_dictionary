import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class OnBoardingController extends GetxController {
  RxBool isLastPage = false.obs;

  AdsHelper adsHelper = AdsHelper();
  @override
  void onInit() {
    // TODO: implement onReady
    super.onInit();
    loadAds();
  }

  void loadAds() {
    // adsHelper.loadNativeAd(templateType: TemplateType.medium);
    // adsHelper.loadNativeAd2();
    // adsHelper.loadNativeAd3();
    adsHelper.loadBannerAd();
    adsHelper.loadBannerAd2();
    adsHelper.loadBannerAd3();
    adsHelper.loadInterstitialAd();
  }

  // Future  loadFirstAd()async{
  //   if(adsHelper.nativeAd==null){
  //     adsHelper.loadNativeAd();
  //   }
  //
  // }
  //
  // Future loadSecondAd()async{
  //   if(adsHelper.nativeAd2==null){
  //     adsHelper.loadNativeAd2();
  //   }
  //
  //
  // }
  //
  // Future loadThirdAd()async{
  //   if(adsHelper.nativeAd3==null){
  //     adsHelper.loadNativeAd3();
  //   }
  //   print("Third Ad loaded");
  // }

  NativeAd? getAd(int index) {
    switch (index) {
      case 0:
        return adsHelper.nativeAd;
      case 1:
        return adsHelper.nativeAd2;
      case 2:
        return adsHelper.nativeAd3;
      default:
        return adsHelper.nativeAd;
    }
  }

  @override
  void onClose() {
    adsHelper.nativeAd?.dispose();
    adsHelper.nativeAd2?.dispose();
    adsHelper.nativeAd3?.dispose();
    // TODO: implement onClose
    super.onClose();
    print('Controller onclosed Called');
  }
}
