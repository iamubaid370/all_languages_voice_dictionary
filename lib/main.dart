import 'dart:ui';

import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_screen.dart';
import 'package:all_languages_voice_dictionary/View/history_screen/history_screen.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/language/LanguageSelectionScreen.dart';
import 'package:all_languages_voice_dictionary/View/meaning_screen/meaning.dart';
import 'package:all_languages_voice_dictionary/View/splash_screen/splash3.dart';
import 'package:all_languages_voice_dictionary/View/splash_screen/splash4.dart';
import 'package:all_languages_voice_dictionary/View/splash_screen/splash_screen.dart';
import 'package:all_languages_voice_dictionary/services/analytics_services.dart';
import 'package:all_languages_voice_dictionary/services/notification.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'View/home_screen/home_screen.dart';
import 'View/onboarding/onboading_screen.dart';
import 'View/splash_screen/splash2.dart';
import 'View/translation_screen/translation.dart';
import 'firebase_options.dart';
import 'localiztion/localiztion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ///crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };


  // await LocalNotification.init();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await MobileAds.instance.initialize();
  final translator = GoogleTranslator();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    //DeviceOrientation.portraitDown
  ]);

  LocalNotification service = LocalNotification();
  service.initializeLocalNotifications();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString('selectedLanguage') ?? 'en';
  runApp( MyApp(languageCode: languageCode));
}

class MyApp extends StatelessWidget {
  //final bool onboarding;
  MyApp({super.key, required this.languageCode, });
  final String languageCode;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    //var localizationDelegate = LocalizedApp.of(context).delegate;
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) => GetMaterialApp(
        translations: Languages(),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'US'),
        title: 'Flutter Demo',

        navigatorObservers:<NavigatorObserver> [
          AnalyticsService().getAnalyticsObserver()
        ],
        //home: SplashScreen(),
        initialRoute: '/',
        getPages:[
          GetPage(name: '/',page: ()=>SplashScreen()),
          GetPage(name: '/splash2',page: ()=>Splash2()),
          GetPage(name: '/splash3',page: ()=>Splash3()),
          GetPage(name: '/onBoardingScreen',page: ()=>OnboardingScreen()),
          GetPage(name: '/languageLocalizationScreen',page: ()=>LanguageSelectionScreen()),
          GetPage(name: '/home',page: ()=>HomeScreen()),
          GetPage(name: '/translation',page: ()=>TranslationScreen()),
          GetPage(name: '/favourite',page: ()=>FavouriteScreen()),
          GetPage(name: '/history',page: ()=>HistoryScreen()),
          GetPage(name: '/meaning',page: ()=>Meaning()),
          //GetPage(name: '/history',page: ()=>HistoryScreen()),
        ],
        debugShowCheckedModeBanner: false,
      ),
      designSize: Size(384, 854),
    );
  }
}
//////////third comit

