import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../controller/dropdownbutton_controller.dart';
import '../../utils/get_language_code.dart';

class TranslationScreenController extends GetxController {
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

  final FlutterTts flutterTts = FlutterTts();
  Future<void> speak(String text, String targetLanguage) async {
    await flutterTts.setLanguage(targetLanguage);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Future<void> onInit() async {
    focusNode.addListener(() {
      update();
    });
    adsHelper.loadBannerAd();
    checkInternetConnection();
    if (!isConnected.value) {
      showNoInternetDialog();
    }
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.clear();
    textEditingController.dispose();
    focusNode.dispose();
    translatedText.value = '';
    super.onClose();
  }

  RxBool isConnected = true.obs;
  Future<String> translateText(String text) async {
    // String textToTranslate = textEditingController.text;
    String textToTranslate = text;
    String targetLanguage = homeScreenController.dropDownValue2.value;
    String? targetLanguageCode = getLanguageCode(targetLanguage);

    if (targetLanguageCode == null) {
      throw ArgumentError('The language $targetLanguage is not supported.');
    }

    return await homeScreenController.translateText(
        textToTranslate, targetLanguageCode);
  }

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
}
