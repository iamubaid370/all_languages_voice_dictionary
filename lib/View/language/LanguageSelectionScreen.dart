// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LanguageSelectionScreen extends StatefulWidget {
//   @override
//   LanguageSelectionScreenState createState() => LanguageSelectionScreenState();
// }
//
// class LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
//   final List<Map<String, String>> languages = [
//     {'name': 'English', 'flag': 'assets/flag.jpg'},
//     {'name': 'Afrikaans', 'flag': 'assets/flag.jpg'},
//     {'name': 'Arabic', 'flag': 'assets/flag.jpg'},
//     {'name': 'Chines', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Czech', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Danish', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Dutch', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'French', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'German', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Greek', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Hindi', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Indonesian', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Italian', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Japanese', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Korean', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Malay', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Norwegian', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Persion', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Portuguese', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Russian', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Spanish', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Thai', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Turkish', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Urdu', 'flag': 'assets/icons/gps_logo.png'},
//     {'name': 'Vietnamese', 'flag': 'assets/icons/gps_logo.png'},
//   ];
//
//   String? _selectedLanguage;
//
//   void _selectLanguage(String language) async {
//     setState(() {
//       _selectedLanguage = language;
//     });
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('selectedLanguage', language);
//     await prefs.setBool('seenLanguageSelection', true);
//     Get.updateLocale(Locale(languageCode));
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // leading: IconButton(
//         //   onPressed: () {
//         //     Get.offNamed('/');
//         //   },
//         //   icon: Icon(Icons.arrow_back),
//         // ),
//         title: Text('Select Language',style:TextStyle(
//           fontSize: 18,
//           fontFamily: 'Arial',
//           fontWeight: FontWeight.w800,
//           color: Color(0xFFE64D3D),),),
//         centerTitle: true,
//         actions: [
//           ElevatedButton(
//               onPressed: _selectedLanguage != null
//                   ? () {
//                     () => Get.updateLocale(const Locale('ko', 'KR'));
//                 Get.offNamed('/onBoardingScreen');
//               }
//                   : null,
//               child: Text("Next")),
//           SizedBox(
//             width: 10,
//           ),
//         ],
//       ),
//       body: GridView.builder(
//         padding: EdgeInsets.all(10),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//           childAspectRatio: 2 / 2, // Increase width and decrease height
//         ),
//         itemCount: languages.length,
//         itemBuilder: (context, index) {
//           bool isSelected = _selectedLanguage == languages[index]['name'];
//           return GestureDetector(
//             onTap: () => _selectLanguage(languages[index]['name']!),
//             child: Card(
//               color: isSelected ? Color(0xFFE64D3D) : Colors.white,
//               shape: isSelected
//                   ? RoundedRectangleBorder(
//                 side: BorderSide(color: Colors.blue, width: 2),
//                 borderRadius: BorderRadius.circular(8),
//               )
//                   : RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(languages[index]['flag']!, width: 80, height: 80),
//                   SizedBox(height: 6),
//                   Text(
//                     languages[index]['name']!,
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

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

  void selectLanguage(String languageCode) async {
    setState(() {
      _selectedLanguage = languageCode;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', languageCode);
    await prefs.setBool('seenLanguageSelection', true);

    // Update the locale
    Get.updateLocale(Locale(languageCode));
  }

  void _checkLanguageSelectionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? seenLanguageSelection =
        prefs.getBool('seenLanguageSelection') ?? false;
    bool? seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

    if (seenLanguageSelection) {
      if (seenOnboarding) {
        Get.offNamed('/home');
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
    _checkLanguageSelectionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE64D3D),
        // leading: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(Icons.arrow_back),
        // ),
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
            child: Text("Save"),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                bool isSelected =
                    _selectedLanguage == languages[index]['locale'];
                return GestureDetector(
                  onTap: () async {
                    String? languageCode = languages[index]['locale'];
                    if (languageCode != null) {
                      // Update the state to reflect the selected language
                      setState(() {
                        _selectedLanguage = languageCode;
                      });

                      // Save the selected language to SharedPreferences
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('selectedLanguage', languageCode);
                      await prefs.setBool('seenLanguageSelection', true);

                      // Update the app's locale
                      Get.updateLocale(Locale(languageCode));
                    }
                  },
                  child: Container(
                    height: 140,
                    child: Card(
                      color: isSelected ? Colors.grey : Colors.white,
                      shape: isSelected
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

          Obx(
            () {
              bool isAdLoaded =
                  languageScreenController.adsHelper.isNativeAdLoaded.value;
              bool isAppOpenAdShowing = GlobalVariable.isAppOpenAdShowing.value;
              bool isPurchased = GlobalVariable.isPurchasedMonthly.value ||
                  GlobalVariable.isPurchasedYearly.value ||
                  GlobalVariable.isPurchasedLifeTime.value;

              if (!isAdLoaded) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  child: SizedBox(
                    width: Get.width,
                    height: 360,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.white, // Placeholder color
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
                    height: 360,
                    child: AdWidget(
                        ad: languageScreenController.adsHelper.nativeAd!),
                  ),
                );
              }  else {
                return const SizedBox();
              }
            },
          )

          ///
          // Obx(
          //       () {
          //     if (languageScreenController.adsHelper.isNativeAdLoaded!.value) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
          //         child: SizedBox(
          //           width: 360,
          //           height: 232,
          //           child: Shimmer.fromColors(
          //             baseColor: Colors.grey.shade300,
          //             highlightColor: Colors.grey.shade100,
          //             child: Container(
          //               color: Colors.white,
          //             ),
          //           ),
          //         ),
          //       );
          //     } else if (languageScreenController.adsHelper.isNativeAdLoaded.value) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
          //         child: SizedBox(
          //           width: 360,
          //           height: 232,
          //           child: AdWidget(
          //             ad: languageScreenController.adsHelper.nativeAd!,
          //           ),
          //         ),
          //       );
          //     } else {
          //       return SizedBox();
          //     }
          //   },
          // ),
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
