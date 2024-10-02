// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../home_screen/home_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   SplashScreen();
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   // void initState() {
//   //   super.initState();
//   //   Timer(Duration(seconds: 3), () {
//   //     Navigator.of(context).pushReplacement(MaterialPageRoute(
//   //         builder: (BuildContext context) => TodoList(
//   //               title: "Todo Manager",
//   //             )));
//   //   });
//   // }
//   // @override
//   // void initState(){
//   //   super.initState();
//   //   _setLanguageBasedOnLocation();
//   // }
//   // Future<void> _setLanguageBasedOnLocation() async {
//   //   try {
//   //     Position position = await Geolocator.getCurrentPosition(
//   //       desiredAccuracy: LocationAccuracy.high,
//   //     );
//   //     List<Placemark> placemarks = await placemarkFromCoordinates(
//   //       position.latitude,
//   //       position.longitude,
//   //     );
//   //     if (placemarks.isNotEmpty) {
//   //       String? country = placemarks.first.country;
//   //       _setLanguageForCountry(country!);
//   //     }
//   //   } catch (e) {
//   //     print('Error getting location: $e');
//   //     // Set default language if location cannot be determined
//   //     _setLanguageForCountry('default');
//   //   }
//   //   // Navigate to the next screen after setting the language
//   //   Get.offNamed('/home');
//   // }
//   //
//   // void _setLanguageForCountry(String country) {
//   //   // Map country to language
//   //   String languageCode = 'en'; // default to English
//   //   switch (country) {
//   //     case 'France':
//   //       languageCode = 'fr';
//   //       break;
//   //     case 'Germany':
//   //       languageCode = 'de';
//   //       break;
//   //     case 'Spain':
//   //       languageCode = 'es';
//   //       break;
//   //   // Add more countries and languages as needed
//   //     default:
//   //       languageCode = 'en';
//   //   }
//   //   var locale = Locale(languageCode);
//   //   Get.updateLocale(locale);
//   // }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             "assets/animation.gif",
//             width : 400,
//             height: MediaQuery.sizeOf(context).height * 0.3,
//             //width: MediaQuery.sizeOf(context).width * 0.4,
//           ),
//           Center(
//             child: Text(
//               'Welcome',
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//           SizedBox(height: 100),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()));
//             },
//             child: Text('Lets Go'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:geocoding/geocoding.dart'; // Import the geocoding package
// // import 'package:get/get.dart';
// // import '../home_screen/home_screen.dart';
// //
// // class SplashScreen extends StatefulWidget {
// //   @override
// //   State<SplashScreen> createState() => _SplashScreenState();
// // }
// //
// // class _SplashScreenState extends State<SplashScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     _setLanguageBasedOnLocation();
// //   }
// //
// //   Future<void> _setLanguageBasedOnLocation() async {
// //     try {
// //       Position position = await Geolocator.getCurrentPosition(
// //         desiredAccuracy: LocationAccuracy.high,
// //       );
// //       List<Placemark> placemarks = await placemarkFromCoordinates(
// //         position.latitude,
// //         position.longitude,
// //       );
// //       if (placemarks.isNotEmpty) {
// //         String? country = placemarks.first.country;
// //         if (country != null) {
// //           _setLanguageForCountry(country);
// //         } else {
// //           _setLanguageForCountry('default');
// //         }
// //       }
// //     } catch (e) {
// //       print('Error getting location: $e');
// //       // Set default language if location cannot be determined
// //       _setLanguageForCountry('default');
// //     }
// //     // Navigate to the next screen after setting the language
// //     Get.offNamed('/home');
// //   }
// //
// //   void _setLanguageForCountry(String country) {
// //     // Map country to language
// //     String languageCode = 'en'; // default to English
// //     switch (country) {
// //       case 'France':
// //         languageCode = 'fr';
// //         break;
// //       case 'Germany':
// //         languageCode = 'de';
// //         break;
// //       case 'Spain':
// //         languageCode = 'es';
// //         break;
// //     // Add more countries and languages as needed
// //       default:
// //         languageCode = 'en';
// //     }
// //     var locale = Locale(languageCode);
// //     Get.updateLocale(locale);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Image.asset(
// //             "assets/animation.gif",
// //             width: 400,
// //             height: MediaQuery.sizeOf(context).height * 0.3,
// //           ),
// //           Center(
// //             child: Text(
// //               'Welcome',
// //               style: TextStyle(fontSize: 20),
// //             ),
// //           ),
// //           SizedBox(height: 100),
// //           ElevatedButton(
// //             onPressed: () {
// //               Navigator.of(context).push(
// //                   MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
// //             },
// //             child: Text('Lets Go'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

///new splashscreen

import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/splash_screen/splash2.dart';
import 'package:all_languages_voice_dictionary/View/splash_screen/splash4.dart';
import 'package:all_languages_voice_dictionary/View/splash_screen/splashscreen_controller.dart';
import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:all_languages_voice_dictionary/widgets/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';
import '../../global/global_variables.dart';
import '../home_screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  //final LocalizationController localizationController = Get.put(LocalizationController());
  SplashController splashController = Get.put(SplashController());
  //HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:Obx(
            () {
          bool isAdLoaded = splashController.adsHelper.isBannerAdLoaded.value &&
              splashController.adsHelper.bannerAd != null &&
              !GlobalVariable.isAppOpenAdShowing.value &&
              !GlobalVariable.isInterstitialAdShowing.value;

          return isAdLoaded
              ? Container(

            child: SizedBox(
              width: Get.width,
              height: splashController.adsHelper.bannerAd!.size.height
                  .toDouble(),
              child: AdWidget(ad: splashController.adsHelper.bannerAd!),
            ),
          )
              : Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: Get.width,
              height: 55,
              color: Colors.grey.shade300,
              child: Center(
                child: Text(
                  'Loading ad...', // Optional placeholder text
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Center(
          child: Column(
             //mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
        Text('WELCOME TO',  // First part of the text
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w800,
            color: Color(0xFFE64D3D), // Color for the first part
          ),
          ),
          Text('All Languages Voice Dictionary\nNo 1 Dictionary in the World',  // Second part of the text
            style: TextStyle(
              overflow: TextOverflow.visible, //

              fontSize: 12,
              fontFamily: 'Arial',
              //fontWeight: FontWeight.w400,
              color: Color(0xFFE64D3D),  // Same color or change if needed
            ),
          ),
              //Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Image.asset('assets/dictionary1.png'),
              ),
              Spacer(),
              SplashController(). progressValue.value == 100.0 ?CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE64D3D)),
              ):SizedBox(),




            ],
          ),
        ),
      ),
    );
  }
}
