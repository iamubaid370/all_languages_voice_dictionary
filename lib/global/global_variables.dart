import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

Color primaryColor = Color(0xff20B1B4);

// to manage left and right side
bool isRightSideLangSelect = false;

RxBool isUrdu = true.obs;
RxBool isPashto = false.obs;
RxBool isArabic = false.obs;
RxBool isSpanish = false.obs;

// const Color primaryColor = Color(0xFF2967FF);
const Color grayColor = Color(0xFF8D8D8E);

final FlutterTts flutterTts = FlutterTts();
var selectedText = "".obs;

class GlobalVariable {
  /// ----------------------- IAP IDs ---------------------------
  static String monthlyId = Platform.isIOS ? 'com.pz.le.monthly' : 'and';
  static String yearlyId = Platform.isIOS ? 'com.pz.le.yearly' : 'and';
  static String lifeTimeId =
  Platform.isIOS ? 'com.learnenglish.removeads' : 'and';
  static Set<String> IAP_IDs = {monthlyId, yearlyId, lifeTimeId};

  static RxBool isPurchasedMonthly = false.obs;
  static RxBool isPurchasedYearly = false.obs;
  static RxBool isPurchasedLifeTime = false.obs;

  static bool showInterstitialAd = true;
  static RxBool isInterstitialAdShowing = false.obs;
  static RxBool isAppOpenAdShowing = false.obs;

  static const bannerAdAndroid = 'ca-app-pub-3940256099942544/6300978111';
  static const bannerAdIOS = !kDebugMode
      ? 'ca-app-pub-2874777513435684/6036202105'
      : //real
  'ca-app-pub-3940256099942544/2934735716'; // testing

  static const interAdAndroid = 'ca-app-pub-3940256099942544/1033173712';
  static const interAdIOS = !kDebugMode
      ? 'ca-app-pub-2874777513435684/3218467076'
      : // real
  'ca-app-pub-3940256099942544/4411468910'; // test

  static const nativeAdAndroid = 'ca-app-pub-3940256099942544/2247696110';
  static const nativeAdIOS = !kDebugMode
      ? 'ca-app-pub-2874777513435684/8049504813'
      : // real
  'ca-app-pub-3940256099942544/3986624511'; //test

  static const openAppAndroid = 'ca-app-pub-3940256099942544/3419835294';
  static const openAppAdIOS = !kDebugMode
      ? 'ca-app-pub-2874777513435684/5730710659'
      : //real
  'ca-app-pub-3940256099942544/5662855259'; //testing

// ----------------in app purchase ----------------------------------------

// static bool iadspurchase = false;
// static RxBool purchaseads = false.obs;
}
