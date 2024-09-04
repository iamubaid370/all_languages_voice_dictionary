import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MeaningScreenController extends GetxController{

  AdsHelper adsHelper = AdsHelper();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadAd();
  }

  void loadAd(){
    //adsHelper.loadCollapsibleAd();
    adsHelper.loadBannerAd();
  }

}