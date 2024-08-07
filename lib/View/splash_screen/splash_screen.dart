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

import 'package:all_languages_voice_dictionary/View/splash_screen/splash2.dart';
import 'package:all_languages_voice_dictionary/widgets/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../home_screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  //final LocalizationController localizationController = Get.put(LocalizationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Get.height* 0.17,),
            Text(
              'All Languages Voice Dictionary',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFE64D3D)),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: Get.height * 0.04,
                bottom: Get.height * 0.04,
              ),
              child: Text(
                  'Discover words meaning, hear accurate pronounciations,\n'
                  ' and expand your dictionary with our voice dictionary',
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Arial',
                      //fontWeight: FontWeight.w700,
                      color: Colors.grey)),
            ),
            Image.asset(
              "assets/splash1.png",
              width: 400,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.06,bottom:Get.height * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 10.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFE64D3D)
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child:
                  Container(
                    width: 10,
                    height: 10.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey
                    ),
                  ),
                ),
                Container(
                  width: 10,
                  height: 10.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey
                  ),
                ),
              ],),
            ),

            customTextButton(
                voidCallBack: () {
                  Get.to(Splash2());
                },
                title: 'Next',
                color: Color(0xFFE64D3D),

            ),
          ],
        ),
      ),
    );
  }
}
