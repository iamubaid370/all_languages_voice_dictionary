import 'package:all_languages_voice_dictionary/View/language/languagescreen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../global/global_variables.dart';
import '../../widgets/flag_widget.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  LanguageSelectionScreenState createState() => LanguageSelectionScreenState();
}

class LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  LanguageScreenController languageScreenController =
      Get.put(LanguageScreenController());
  String? _selectedLanguage;
  RxBool isSelected = true.obs;
  void selectLanguage(String languageCode) async {
    setState(() {
      _selectedLanguage = languageCode;
    });
  }

  Future<void> saveLanguageSelection() async {
    if (_selectedLanguage != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('selectedLanguage', _selectedLanguage!);
      await prefs.setBool('seenLanguageSelection', true);

      // Update the locale after saving
      Get.updateLocale(Locale(_selectedLanguage!));
    }
  }

  void _checkLanguageSelectionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? seenLanguageSelection =
        prefs.getBool('seenLanguageSelection') ?? false;
    bool? seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

    if (seenLanguageSelection) {
      if (seenOnboarding) {
        Get.offNamed('/welcome');
        print(seenOnboarding);
      } else {
        Get.offNamed('/onBoardingScreen');
        print(seenOnboarding);
      }
    } else {
      Get.offNamed('/languageLocalizationScreen');
      print(seenOnboarding);
    }
  }

  void goNext() {
    //  adsHelper.showAppOpenAd();
    // Get.offNamed('/dash');
    saveLanguageSelection();
    _checkLanguageSelectionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE64D3D),
      appBar: AppBar(
        backgroundColor: Color(0xFFE64D3D),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Select Language',
          style: TextStyle(
              fontFamily: 'Arial',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: _selectedLanguage != null
                ? () {
                    // Get.offNamed('/onBoardingScreen');
                    goNext();
                  }
                : null,
            child: Text("Save",style: TextStyle(color: isSelected.value?Colors.white:Color(0xFFE64D3D)),),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: GridView.builder(
              //shrinkWrap: true,
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 7,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 2,
              ),
              itemCount: languages.length,
              itemBuilder: (context, index) {
                isSelected.value =
                    _selectedLanguage == languages[index]['locale'];
                return GestureDetector(
                  onTap: () async {
                    String? languageCode = languages[index]['locale'];
                    if (languageCode != null) {
                      selectLanguage(languageCode);

                    }
                  },
                  child: Container(
                    height: 140,
                    child: Card(
                      color: isSelected.value ? Colors.grey : Colors.white,
                      shape: isSelected.value
                          ? RoundedRectangleBorder(
                              // side:
                              // BorderSide(color: const Color(0xFF575DDC), width: 2),
                              borderRadius: BorderRadius.circular(8),
                            )
                          : RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlagWidget(
                            countryCode: languages[index]['country']!,
                          ),
                          SizedBox(height: 1),
                          Text(
                            languages[index]['name']!,
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 5,),
          Obx(
            () {
              bool isAdLoaded =
                  languageScreenController.adsHelper.isNativeAdLoaded.value;
              bool isAppOpenAdShowing = GlobalVariable.isAppOpenAdShowing.value;


              if (!isAdLoaded) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  child: SizedBox(
                    width: Get.width,
                    height: 120,
                    child: Shimmer.fromColors(
                      // baseColor: Colors.orange[300]!, // Change this to your desired orange shade
                      // highlightColor: Colors.orange[100]!, // Change this to a lighter orange shade
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.white // Placeholder color
                      ),
                    ),
                  ),
                );
              } else if (isAdLoaded && !isAppOpenAdShowing) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  child: SizedBox(
                    width: Get.width,
                    height: 120,
                    child: AdWidget(
                        ad: languageScreenController.adsHelper.nativeAd!),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }

  final List<Map<String, String>> languages = [
    {'name': 'English', 'country': 'us', 'locale': 'en'},
    {'name': 'Afrikaans', 'country': 'za', 'locale': 'af'},
    {'name': 'Arabic', 'country': 'sa', 'locale': 'ar'},
    {'name': 'Chinese', 'country': 'cn', 'locale': 'zh'},
    {'name': 'Czech', 'country': 'cz', 'locale': 'cs'},
    {'name': 'Danish', 'country': 'dk', 'locale': 'da'},
    {'name': 'Dutch', 'country': 'nl', 'locale': 'nl'},
    {'name': 'French', 'country': 'fr', 'locale': 'fr'},
    {'name': 'German', 'country': 'de', 'locale': 'de'},
    {'name': 'Greek', 'country': 'gr', 'locale': 'el'},
    {'name': 'Hindi', 'country': 'in', 'locale': 'hi'},
    {'name': 'Indonesian', 'country': 'id', 'locale': 'id'},
    {'name': 'Italian', 'country': 'it', 'locale': 'it'},
    {'name': 'Japanese', 'country': 'jp', 'locale': 'ja'},
    {'name': 'Korean', 'country': 'kr', 'locale': 'ko'},
    {'name': 'Malay', 'country': 'my', 'locale': 'ms'},
    {'name': 'Norwegian', 'country': 'no', 'locale': 'no'},
    {'name': 'Persian', 'country': 'ir', 'locale': 'fa'},
    {'name': 'Portuguese', 'country': 'pt', 'locale': 'pt'},
    {'name': 'Russian', 'country': 'ru', 'locale': 'ru'},
    {'name': 'Spanish', 'country': 'es', 'locale': 'es'},
    {'name': 'Thai', 'country': 'th', 'locale': 'th'},
    {'name': 'Turkish', 'country': 'tr', 'locale': 'tr'},
    {'name': 'Urdu', 'country': 'pk', 'locale': 'ur'},
    {'name': 'Vietnamese', 'country': 'vn', 'locale': 'vi'},
  ];
}
