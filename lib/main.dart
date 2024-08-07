import 'package:all_languages_voice_dictionary/View/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:translator/translator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'View/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  final translator = GoogleTranslator();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    //DeviceOrientation.portraitDown
  ]);

  // var delegate = await LocalizationDelegate.create(
  //   fallbackLocale: 'en_US', // Fallback locale if translation is not available
  //   supportedLocales: ['en_US', 'es_ES'], // Add more locales as needed
  //   // preferences: TranslatePreferences(),
  //   // baseUrl: 'https://your-translation-service.com/',  // URL to Google Translate or custom service
  //   // //apiKey: 'YOUR_GOOGLE_TRANSLATE_API_KEY',  // API key for Google Translate (optional)
  // );

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    //var localizationDelegate = LocalizedApp.of(context).delegate;
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) => GetMaterialApp(
        // translations: AppTranslations(),
        // locale: Locale('en'), // default locale
        // fallbackLocale: Locale('en'),
        title: 'Flutter Demo',
        localizationsDelegates: [
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          // GlobalCupertinoLocalizations.delegate,
          // TranslateLocalizationDelegate.delegate, // Add TranslateLocalizationDelegate
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
      designSize: Size(384, 854),
    );
  }
}
//////////third comit

///
// class AppTranslations extends Translations {
//   @override
//   Map<String, Map<String, String>> get keys => {
//     'en': {
//       'title': 'Hello',
//     },
//     'fr': {
//       'title': 'Bonjour',
//     },
//     'de': {
//       'title': 'Hallo',
//     },
//     'es': {
//       'title': 'Hola',
//     },
//   };
// }
