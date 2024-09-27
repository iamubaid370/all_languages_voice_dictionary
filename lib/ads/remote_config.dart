// import 'dart:math';
//
// import 'package:firebase_remote_config/firebase_remote_config.dart';
//
// class RemoteConfig{
//   static final _remoteConfig = FirebaseRemoteConfig.instance;
//
//   static const _defaultValues ={
//     "interstitial_ad": "ca-app-pub-3940256099942544/4411468910",
//     "native_ad": "ca-app-pub-3940256099942544/3986624511",
//     "show_ads": "true"
//
//   };
//
//   static Future<void> initConfig()async {
//     await _remoteConfig.setConfigSettings(RemoteConfigSettings(
//       fetchTimeout: const Duration(minutes: 1),
//       minimumFetchInterval: const Duration(minutes: 30),
//     ));
//
//     await _remoteConfig.setDefaults(_defaultValues);
//     await _remoteConfig.fetchAndActivate();
//     print("Remote Config Data: ${_remoteConfig.getBool('show_ads')}");
//
//     _remoteConfig.onConfigUpdated.listen((event) async {
//       await _remoteConfig.activate();
//       print("update: ${_remoteConfig.getBool('show_ads')}");
//     });
//   }
//
//
//
//   static bool get _showAd => _remoteConfig.getBool("show_ads");
//   static String get NativeAd => _remoteConfig.getString("native_ad");
//   static String get InterstitialAd => _remoteConfig.getString("interstitial_ad");
//
//
//
//   static bool get hideAd => !_showAd;
// }