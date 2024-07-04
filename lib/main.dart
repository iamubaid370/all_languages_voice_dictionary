import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'View/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    //DeviceOrientation.portraitDown
  ]);

  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en_US', // Fallback locale if translation is not available
    supportedLocales: ['en_US', 'es_ES'], // Add more locales as needed
    // preferences: TranslatePreferences(),
    // baseUrl: 'https://your-translation-service.com/',  // URL to Google Translate or custom service
    // //apiKey: 'YOUR_GOOGLE_TRANSLATE_API_KEY',  // API key for Google Translate (optional)
  );

  runApp(LocalizedApp(delegate, MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: ScreenUtilInit(
        builder: (BuildContext context, Widget? child) => GetMaterialApp(
          title: 'Flutter Demo',
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomeScreen(),
          debugShowCheckedModeBanner: false,
        ),
        designSize: Size(384, 854),
      ),
    );
  }
}
