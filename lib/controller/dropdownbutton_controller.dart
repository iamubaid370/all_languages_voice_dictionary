import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:get/get.dart';

import '../utils/get_language_code.dart';

class DropDownButtonController extends GetxController{
  var translatedText = ''.obs;

  HomeScreenController homeScreenController = Get.put(HomeScreenController());
   getLangCode(String language){
    String? languageCode = getLanguageCode(language);
    if(languageCode != null){
      print(languageCode.toString());

      try{
        homeScreenController.searchContain(homeScreenController.textEditingController.text, languageCode);
        //homeScreenController.dropDownValue2.value = languageCode;
      }
      catch(e){print(e.toString());}

//
    }
   }
   languageCode(String language) async {
     String? languageCode = getLanguageCode(language);
     if (languageCode != null) {
       String translation = await oneWordMeaning(homeScreenController.textEditingController.text, languageCode);
       translatedText.value = translation;
     }
   }

   oneWordMeaning(String text,String targetLanguage){
     final translatedText = homeScreenController.translateText(text, targetLanguage);
     return translatedText;
   }


}

