import 'dart:async';

import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_controller.dart';
import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:all_languages_voice_dictionary/global/global_variables.dart';
import 'package:all_languages_voice_dictionary/model/dictionary_model.dart';
import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:sqflite/sqflite.dart';
import 'package:translator/translator.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

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

  ///INTERNET CONNECTION DIALOG
  ///
  RxBool isConnected = true.obs;

  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult.toString()); // Print for debugging

    // Check if there is no connection
    if (!connectivityResult.contains(ConnectivityResult.wifi) &&
        !connectivityResult.contains(ConnectivityResult.mobile)) {
      isConnected.value = false;
      showNoInternetDialog();
      print("NOT CONNECTED");
    } else {
      isConnected.value = true;
      print("Connected to the Internet");
    }
  }

  void showNoInternetDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Color(0xFFE64D3D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        titlePadding: EdgeInsets.zero,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(), // empty space to push the cross button to the right
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/no_internet.png', // Your big logo in the center
              height: 100,
              width: 100,
            ),
            SizedBox(height: 20),
            Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: openWifiSettings,
              child: Text(
                "Wi-Fi",
                style: TextStyle(color: Color(0xFFE64D3D)),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: openMobileDataSettings,
              child: Text(
                "Mobile Data",
                style: TextStyle(color: Color(0xFFE64D3D)),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void openWifiSettings() async {
    AppSettings.openAppSettings(type: AppSettingsType.wifi);
  }

  // Method to open Mobile Data settings
  void openMobileDataSettings() async {
    await AppSettings.openAppSettings(type: AppSettingsType.dataRoaming);
  }
  @override
  void onInit() {
    adsHelper.loadBannerAd();
    loadAds();
    textEditingController = TextEditingController();
    initSpeech();
    focusNode.addListener(() {
      update();
    });
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  @override
  void onReady() {
    checkInternetConnection();
    listenToAppStateChanges();
    if (adsHelper.interstitialAd != null) {
      adsHelper.showInterstitialAd(nextScreen: '/home');
      print('Interstitial ad loaded successfully.');
    }
    super.onReady();
  }




  void loadAds() {
    adsHelper.loadAppOpenAd();
     adsHelper?.loadInterstitialAd();

  }

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => onAppStateChanged(state));
  }

  void onAppStateChanged(AppState appState) {
    if (appState == AppState.foreground) {
      if (adsHelper.appOpenAd != null) {
        adsHelper.showAppOpenAd();

        print("---------------1");
        print(appState);
        print("---------------1");
      } else {
        adsHelper.loadAppOpenAd();
        print("---------------2");
        print(appState);
        print("---------------2");
      }
    } else {
      adsHelper.loadAppOpenAd();
      print("---------------3");
      print(appState);
      print("---------------3");
    }
  }

  @override
  void initSpeech() async {
    speechEnabled.value = await speechToText.initialize();
    update();
  }

  void startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
  }

  void stopListening() async {
    await speechToText.stop();
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    lastWords.value = result.recognizedWords;
    textEditingController.text = lastWords.value;
  }

  void updateTextField(String newText) {
    //textFieldText.value = newText;
    //return textEditingController.text = newText;
    currentText.value = newText;
    textEditingController.text = newText;
  }

  void onClose() {
    // adsHelper.bannerAd?.dispose();
    //adsHelper.nativeAd?.dispose();
    focusNode.dispose();
    textEditingController.dispose();
    //scrollController.dispose();
    adsHelper.nativeAd?.dispose();
  }

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
    currentText.value = word;
    try {
      isLoading.value = true;
      update();

      dictionaryModel = await ApiServices.getData(word);

      if (dictionaryModel != null) {
        await Future.wait(dictionaryModel!.meanings!.expand((meaning) {
          return meaning.definitions.map((definition) async {
            definition.definition =
                await translateText(definition.definition, targetLanguage);
          });
        }).toList());
        await Future.wait(dictionaryModel!.meanings!.expand((meaning) {
          return meaning.definitions.map((definition) async {
            definition.example =
                await translateText(definition.definition, targetLanguage);
          });
        }).toList());
        await Future.wait(dictionaryModel!.phonetics!.map((phonetic) async {
          if (phonetic.text != null) {
            phonetic.text = await translateText(phonetic.text!, targetLanguage);
          }
        }));
        dictionaryModel?.word =
            await translateText(dictionaryModel!.word, targetLanguage);
        await Future.wait(dictionaryModel!.meanings!.expand((meaning) {
          return [
            translateList(meaning.synonyms ?? [], targetLanguage)
                .then((translatedList) {
              meaning.synonyms = translatedList;
            }),
            translateList(meaning.antonyms ?? [], targetLanguage)
                .then((translatedList) {
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
    String _capitalizeFirstLetter(String text) {
      if (text == null || text.isEmpty) {
        return text;
      }
      return text[0].toUpperCase() + text.substring(1);
    }

    for (int index = 0; index < meaning.definitions.length; index++) {
      var element = meaning.definitions[index];
      wordDefinition += "\n${index + 1}. ${element.definition}\n";
    }
    return Column(
      children: [
        Divider(
          height: 40.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.028),
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
                // Text(
                //   meaning.partOfSpeech,
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 22.sp,
                //       color: Colors.black,
                //       fontFamily: 'arial'),
                // ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: _capitalizeFirstLetter(
                                meaning.partOfSpeech.split(' ').first) +
                            ' ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'arial',
                        ),
                      ),
                      // TextSpan(
                      //   text: meaning.partOfSpeech.substring(meaning.partOfSpeech.indexOf(' ') + 1),
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 22.sp,
                      //     color: Colors.black,
                      //     fontFamily: 'arial',
                      //   ),
                      // ),
                    ],
                  ),
                ),

                SizedBox(height: 10.h),
                Text(
                  "Definitions : ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: Colors.grey,
                      fontFamily: 'arial'),
                ),
                Text(
                  wordDefinition,
                  style: TextStyle(
                      fontSize: 16.sp, height: 1.h, fontFamily: 'arial'),
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
                fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'arial'),
          ),
          Text(
            setList!.toSet().toString().replaceAll("{", "").replaceAll("}", ""),
            style: const TextStyle(fontSize: 18, fontFamily: 'arial'),
          ),
          const SizedBox(height: 10),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
