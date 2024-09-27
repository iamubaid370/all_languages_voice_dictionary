import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._()
      : _remoteConfig = FirebaseRemoteConfig.instance;

  static FirebaseRemoteConfigService? _instance;
  factory FirebaseRemoteConfigService() =>
      _instance ??= FirebaseRemoteConfigService._();

  final FirebaseRemoteConfig _remoteConfig;
  bool getBool(String key) => _remoteConfig.getBool(key);
  String getString(String key) => _remoteConfig.getString(key);
  int getIntForInterstitialAdLimit(String key) => _remoteConfig.getInt(key);

  Future<void> _setConfigSettings() async => _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(seconds: 1), // MODIFIED
        ),
      );

  Future<void> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();

    if (updated) {
      debugPrint('The config has been updated.');
    } else {
      debugPrint('The config is not updated..');
    }
  }

  Future<void> initialize() async {
    await _setConfigSettings();
    await fetchAndActivate();

    // These will be used before the values are fetched from Firebase Remote Config.
    await _remoteConfig.setDefaults(const {
      'requiredMinimumVersion': '4.0.0',
      'recommendedMinimumVersion': '4.0.0',
    });

    // Optional: listen for and activate changes to the Firebase Remote Config values
    _remoteConfig.onConfigUpdated.listen((event) async {
      await _remoteConfig.activate();
    });
  }
}
