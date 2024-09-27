import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:get/get.dart';

import '../utils/get_language_code.dart';

class DropDownButtonController extends GetxController{
  var translatedText = ''.obs;

  HomeScreenController homeScreenController = Get.put(HomeScreenController());
//    getLangCode(String language){
//     String? languageCode = getLanguageCode(language);
//     if(languageCode != null){
//       print(languageCode.toString());
//
//       try{
//         homeScreenController.searchContain(homeScreenController.textEditingController.text, languageCode);
//         //homeScreenController.dropDownValue2.value = languageCode;
//       }
//       catch(e){print(e.toString());}
//
// //
//     }
//    }

  void getLangCode(String language) {
    String? languageCode = getLanguageCode(language);
    if (languageCode != null) {
      print('Language Code: $languageCode');
      try {
        homeScreenController.searchContain(homeScreenController.textEditingController.text, languageCode);
      } catch (e) {
        print('Error in getLangCode: ${e.toString()}');
      }
    } else {
      print('Language code not found for language: $language');
    }
  }


  // languageCode(String language) async {
  //    String? languageCode = getLanguageCode(language);
  //    if (languageCode != null) {
  //      String translation = await oneWordMeaning(homeScreenController.textEditingController.text, languageCode);
  //      translatedText.value = translation;
  //    }
  //  }

  Future<void> languageCode(String language) async {
    String? languageCode = getLanguageCode(language);
    if (languageCode != null) {
      try {
        String translation = await oneWordMeaning(homeScreenController.textEditingController.text, languageCode);
        translatedText.value = translation;
      } catch (e) {
        print('Error in languageCode: ${e.toString()}');
      }
    } else {
      print('Language code not found for language: $language');
    }
  }


  // oneWordMeaning(String text,String targetLanguage){
  //    final translatedText = homeScreenController.translateText(text, targetLanguage);
  //    return translatedText;
  //  }

  Future<String> oneWordMeaning(String text, String targetLanguage) async {
    try {
      // Await the asynchronous translateText method
      final translatedText = await homeScreenController.translateText(text, targetLanguage);
      return translatedText;
    } catch (e) {
      // Handle potential errors and provide a fallback
      print('Error in oneWordMeaning: ${e.toString()}');
      return 'Error translating text';
    }
  }



}

