import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../controller/dropdownbutton_controller.dart';
import '../../utils/get_language_code.dart';

class TranslationScreenController extends GetxController{
  TextEditingController textEditingController = TextEditingController();
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  DropDownButtonController dropDownButtonController = Get.find();
  AdsHelper adsHelper = AdsHelper();
  FocusNode focusNode = FocusNode();

  var translatedText = ''.obs;
  var currentText = ''.obs;

  @override
  Future<void> onInit() async {
    focusNode.addListener((){
      update();
    });
    adsHelper.loadBannerAd();
    super.onInit();
  }

  @override
  void onClose(){
    textEditingController.clear();
    textEditingController.dispose();
    focusNode.dispose();
    super.onClose();
  }


  // String? getLangCode(String language) {
  //   String? languageCode = getLanguageCode(language);
  //   if (languageCode == null) {
  //     throw ArgumentError('The language $language is not supported.');
  //   }
  //   return languageCode;
  // }

  Future<String> translateText(String text) async {
   // String textToTranslate = textEditingController.text;
    String textToTranslate =text;
    String targetLanguage = homeScreenController.dropDownValue2.value;
    String? targetLanguageCode = getLanguageCode(targetLanguage);

    if (targetLanguageCode == null) {
      throw ArgumentError('The language $targetLanguage is not supported.');
    }

    return await homeScreenController.translateText(textToTranslate, targetLanguageCode);
  }

}