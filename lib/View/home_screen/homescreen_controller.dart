import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_controller.dart';
import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:all_languages_voice_dictionary/model/dictionary_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:sqflite/sqflite.dart';
import 'package:translator/translator.dart';
import 'package:path/path.dart';

import '../../services/api_services.dart';
import '../../translate_data/data_processor.dart';

class HomeScreenController extends GetxController {

  TextEditingController textEditingController = TextEditingController();
  FavouriteController favouriteController = Get.put(FavouriteController());
  final translator = GoogleTranslator();
  var textFieldText = ''.obs;
  DictionaryModel? dictionaryModel;
  RxBool isLoading = false.obs;
  RxString dropDownValue1 = 'English'.obs;
  RxString dropDownValue2 = 'Urdu'.obs;
  var currentText = ''.obs;
  RxList<String> suggestions = <String>[].obs;

  var speechToText = SpeechToText();
  var speechEnabled = false.obs;
  var lastWords = ''.obs;

  AdsHelper adsHelper = AdsHelper();
  FocusNode focusNode = FocusNode();

  @override
  void onReady(){
    loadAds();
    ListenToAppStateChanges();
    super.onReady();
  }


  void loadAds(){
//  adsHelper.loadBannerAd();
  adsHelper.loadAppOpenAd();
  adsHelper?.loadInterstitialAd();
}


  void ListenToAppStateChanges(){
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state)=>OnAppStateChanged(state));
  }

  void OnAppStateChanged(AppState appState){
    if(appState == AppState.foreground){
      if(adsHelper.appOpenAd!= null){
        adsHelper.showAppOpenAd();
      }else{
        adsHelper.loadAppOpenAd();
      }
    }else{
      adsHelper.loadAppOpenAd();
    }

  }


  @override
  void onInit() {
    textEditingController = TextEditingController();
    initSpeech();
    focusNode.addListener((){
      update();
    });
    super.onInit();
  }

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

  void updateTextField(String newText) {
    //textFieldText.value = newText;
   //return textEditingController.text = newText;
     currentText.value = newText;
     textEditingController.text = newText;

  }
  void onClose(){
    // adsHelper.bannerAd?.dispose();
    //adsHelper.nativeAd?.dispose();
    focusNode.dispose();
    textEditingController.dispose();
  }

  // Future<void> fetchSuggestions(String query) async {
  //   if (query.isEmpty) {
  //     suggestions.clear();
  //     return;
  //   }
  //   suggestions.value = await ApiServices.getSuggestions(query);
  // }


  // searchContain(String word) async {
  //   try {
  //     dictionaryModel = await ApiServices.getData(word);
  //   } catch (e) {
  //     dictionaryModel = null;
  //   }
  //
  ///searchContain
  // Future<void> searchContain(String word, String targetLanguage) async {
  //   try {
  //     isLoading.value = true;
  //     update();
  //     dictionaryModel = await ApiServices.getData(word);
  //     if (dictionaryModel != null) {
  //       for (var meaning in dictionaryModel!.meanings!) {
  //         for (var definition in meaning.definitions) {
  //           definition.definition =
  //               await translateText(definition.definition, targetLanguage);
  //         }
  //       }
  //       for (var meaning in dictionaryModel!.meanings!) {
  //         meaning.synonyms =
  //             await translateList(meaning.synonyms ?? [], targetLanguage);
  //         meaning.antonyms =
  //             await translateList(meaning.antonyms ?? [], targetLanguage);
  //       }
  //     }
  //
  //     // if (dictionaryModel != null) {
  //     //   for (int i = 0; i < dictionaryModel!.meanings!.length; i++) {
  //     //     var meaning = dictionaryModel!.meanings![i];
  //     //
  //     //     // Translate definitions
  //     //     for (int j = 0; j < meaning.definitions.length; j++) {
  //     //       var definition = meaning.definitions[j];
  //     //       definition.definition = await translateText(definition.definition, targetLanguage);
  //     //     }
  //     //
  //     //     // Translate synonyms and antonyms
  //     //     meaning.synonyms = await translateList(meaning.synonyms ?? [], targetLanguage);
  //     //     meaning.antonyms = await translateList(meaning.antonyms ?? [], targetLanguage);
  //     //   }
  //     // }
  //   } catch (e) {
  //     dictionaryModel = null;
  //   } finally {
  //     isLoading.value = false;
  //     update();
  //   }
  // }

  Future<void> searchContain(String word, String targetLanguage) async {
    try {
      isLoading.value = true;
      update();

      dictionaryModel = await ApiServices.getData(word);

      if (dictionaryModel != null) {
        // Translate definitions in parallel
        await Future.wait(dictionaryModel!.meanings!.expand((meaning) {
          return meaning.definitions.map((definition) async {
            definition.definition =
            await translateText(definition.definition, targetLanguage);
          });
        }).toList());

        // Translate synonyms and antonyms in parallel
        await Future.wait(dictionaryModel!.meanings!.expand((meaning) {
          return [
            translateList(meaning.synonyms ?? [], targetLanguage).then((translatedList) {
              meaning.synonyms = translatedList;
            }),
            translateList(meaning.antonyms ?? [], targetLanguage).then((translatedList) {
              meaning.antonyms = translatedList;
            }),
          ];
        }).toList());
      }
    } catch (e) {
      dictionaryModel = null;
    } finally {
      isLoading.value = false;
      update();
    }
  }


  Future<String> translateText(String text, String targetLanguage) async {
    final translator = GoogleTranslator();
    try {
      var translation = await translator.translate(
        text,
        to: targetLanguage,
      );
      return translation.text;
    } catch (e) {
      print('Translation error: $e');
      return text;
    }
  }

  Future<List<String>> translateList(
      List<String> list, String targetLanguage) async {
    List<String> translatedList = [];
    for (var item in list) {
      var translatedItem = await translateText(item, targetLanguage);
      translatedList.add(translatedItem);
    }
    return translatedList;
  }


  showMeaning(Meaning meaning) {
    String wordDefinition = "";
    // for (var element in meaning.definitions) {
    //   int index = meaning.definitions.indexOf(element);
    //   wordDefinition += "\n${index + 1}.${element.definition}\n";
    // }

    for (int index = 0; index < meaning.definitions.length; index++) {
      var element = meaning.definitions[index];
      wordDefinition += "\n${index + 1}. ${element.definition}\n";
    }
    return
    //   Padding(
    //   padding: const EdgeInsets.symmetric(
    //     vertical: 10,
    //   ),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(20.r),
    //       color: Colors.white.withOpacity(0.55),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey.withOpacity(0.2),
    //           spreadRadius: 5,
    //           blurRadius: 7,
    //           offset: Offset(0, 3), // changes position of shadow
    //         ),
    //       ],
    //     ),
    //     padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.h),
    //     margin: EdgeInsets.symmetric(
    //       horizontal: 15.w,
    //     ),
    //     child: Material(
    //       elevation: 2,
    //       color: Color(0xFFEFEFEF),
    //       borderRadius: BorderRadius.circular(20),
    //       child: Padding(
    //         padding: const EdgeInsets.all(10.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               meaning.partOfSpeech,
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 22,
    //                 color: Colors.grey,
    //               ),
    //             ),
    //             SizedBox(height: 10),
    //             Text(
    //               "Definations : ",
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 18,
    //                 color: Colors.black,
    //               ),
    //             ),
    //             Text(
    //               wordDefinition,
    //               style: const TextStyle(
    //                 fontSize: 16,
    //                 height: 1,
    //               ),
    //             ),
    //             wordRelation("Synonyms", meaning.synonyms),
    //             wordRelation("Antonyms", meaning.antonyms),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
      Column(
        children: [
          Divider(height: 40.h,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w,),
                margin: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),

            color: Color(0xFFEFEFEF),
            //borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meaning.partOfSpeech,
                    style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                      color: Colors.grey,
                        fontFamily: 'arial'
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Definitions : ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: Colors.black,
                        fontFamily: 'arial'
                    ),
                  ),
                  Text(
                    wordDefinition,
                    style:  TextStyle(
                      fontSize: 16.sp,
                      height: 1.h,
                        fontFamily: 'arial'
                    ),
                  ),
                  wordRelation("Synonyms", meaning.synonyms),
                  wordRelation("Antonyms", meaning.antonyms),
                ],
              ),
            ),
          ),
        ],
      );
  }

  wordRelation(String title, List<String>? setList) {
    if (setList?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
                fontFamily: 'arial'
            ),
          ),
          Text(
            setList!.toSet().toString().replaceAll("{", "").replaceAll("}", ""),
            style: const TextStyle(fontSize: 18,fontFamily: 'arial'),
          ),
          const SizedBox(height: 10),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
