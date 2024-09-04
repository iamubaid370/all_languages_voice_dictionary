import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../controller/dropdownbutton_controller.dart';
import '../../utils/get_language_code.dart';

class TranslationScreenController extends GetxController{
  TextEditingController textEditingController = TextEditingController();
  HomeScreenController homeScreenController = Get.find<HomeScreenController>();
  DropDownButtonController dropDownButtonController = Get.find();
  AdsHelper adsHelper = AdsHelper();
  FocusNode focusNode = FocusNode();

  var translatedText = ''.obs;
  var currentText = ''.obs;

  var speechToText = SpeechToText();
  var speechEnabled = false.obs;
  var lastWords = ''.obs;

  void initSpeech()async{
    speechEnabled.value = await speechToText.initialize();
    update();
  }

  void startListening()async{
    await speechToText.listen(onResult: onSpeechResult);
  }

  void stopListening()async{
    await speechToText.stop();
  }

  void onSpeechResult(SpeechRecognitionResult result){
    lastWords.value = result.recognizedWords;
    textEditingController.text = lastWords.value;
    // var words = result.recognizedWords.trim().split('');
    // if(words.length == 1){
    //   lastWords.value = words[0];
    //   print('@@@@@@@@@@@@@@@@@@@2');
    //   print('@@@@@@@@@@@@@@@@@@@2');
    //   print('@@@@@@@@@@@@@@@@@@@2');
    //   print('@@@@@@@@@@@@@@@@@@@2');
    //   print("$words[0]");
    //   print('@@@@@@@@@@@@@@@@@@@2');
    //   print('@@@@@@@@@@@@@@@@@@@2');
    //   print('@@@@@@@@@@@@@@@@@@@2');
    //
    //   textEditingController.text = lastWords.value;
    //   stopListening();
    //
    // }
  }


  final FlutterTts flutterTts = FlutterTts();
  Future<void> speak(String text,String targetLanguage)async{
    await flutterTts.setLanguage(targetLanguage);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

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
    translatedText.value= '';
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