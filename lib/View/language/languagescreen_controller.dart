import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LanguageScreenController extends GetxController {
  AdsHelper adsHelper = AdsHelper();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    loadAds();
  }

  void loadAds() {
    adsHelper.loadNativeAd(templateType: TemplateType.small);
  }
}
