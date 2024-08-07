// import 'dart:ui';
//
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
//
// class LocalizationController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();
//     _setLanguageBasedOnLocation();
//   }
//
//   Future<void> _setLanguageBasedOnLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );
//       if (placemarks.isNotEmpty) {
//         String country = placemarks.first.country ?? 'default';
//         _setLanguageForCountry(country);
//       }
//     } catch (e) {
//       print('Error getting location: $e');
//       // Set default language if location cannot be determined
//       _setLanguageForCountry('default');
//     }
//     // Navigate to the next screen after setting the language
//     Get.offNamed('/home');
//   }
//
//   void _setLanguageForCountry(String country) {
//     String languageCode = 'en'; // default to English
//     switch (country) {
//       case 'France':
//         languageCode = 'fr';
//         break;
//       case 'Germany':
//         languageCode = 'de';
//         break;
//       case 'Spain':
//         languageCode = 'es';
//         break;
//     // Add more countries and languages as needed
//       default:
//         languageCode = 'en';
//     }
//     var locale = Locale(languageCode);
//     Get.updateLocale(locale);
//   }
// }
