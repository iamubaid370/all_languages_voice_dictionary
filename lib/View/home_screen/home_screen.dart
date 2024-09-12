import 'dart:io';
import 'dart:ui';

import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_controller.dart';
import 'package:all_languages_voice_dictionary/View/history_screen/history_screen.dart';
import 'package:all_languages_voice_dictionary/View/history_screen/historyscreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/setting_screen/setting_screen.dart';
import 'package:all_languages_voice_dictionary/View/translation_screen/translation.dart';
import 'package:all_languages_voice_dictionary/View/meaning_screen/meaning.dart';
import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:all_languages_voice_dictionary/controller/dropdownbutton_controller.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/widgets/bottom_navigation_bar.dart';
import 'package:all_languages_voice_dictionary/widgets/dialog_box.dart';
import 'package:all_languages_voice_dictionary/widgets/drawer_car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../../global/global_variables.dart';
import '../../model/history_model.dart';
import '../../widgets/dropdown_button.dart';
import '../../widgets/iconbutton.dart';
import '../../widgets/reusable_stack.dart';
import '../../widgets/speaker_animation.dart';
import '../favourite_screen/favourite_screen.dart';
import '../language/LanguageSelectionScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  AdsHelper adsHelper = AdsHelper();
  NativeAd? nativeAd;
  RxBool isNativeAdLoaded = false.obs;

  void loadNativeAd() {
    NativeAd(
      adUnitId: adsHelper.nativeAdUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('$NativeAd loaded.');
          nativeAd = null;
          nativeAd = ad as NativeAd;
          isNativeAdLoaded.value = true;
          print(ad.nativeAdOptions?.mediaAspectRatio);
        },
        onAdFailedToLoad: (ad, error) {
          // Dispose the ad here to free resources.
          debugPrint('$NativeAd failed to load: $error');
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small,
        // mainBackgroundColor: ThemeHelper.primaryColor,
        // cornerRadius: 10.0,
        callToActionTextStyle: NativeTemplateTextStyle(
            textColor: Colors.white,
            // backgroundColor: ThemeHelper.secondaryColor,
            style: NativeTemplateFontStyle.bold,
            size: 13.5),
        primaryTextStyle: NativeTemplateTextStyle(
            // textColor: ThemeHelper.s,
            // backgroundColor: ThemeColors.bgColor.withOpacity(0.7),
            style: NativeTemplateFontStyle.italic,
            size: 13.5),
        secondaryTextStyle: NativeTemplateTextStyle(
            // textColor: ThemeColors.secondary,
            // backgroundColor: ThemeColors.bgColor.withOpacity(0.7),
            style: NativeTemplateFontStyle.bold,
            size: 13),
        tertiaryTextStyle: NativeTemplateTextStyle(
            // textColor: ThemeColors.secondary,
            // backgroundColor: ThemeColors.bgColor.withOpacity(0.7),
            style: NativeTemplateFontStyle.normal,
            size: 13),
      ),
    ).load();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNativeAd();
  }

  FavouriteController favouriteController = Get.put(FavouriteController());

  final ScrollController scrollController = ScrollController();

  HistoryScreenController historyScreenController =
      Get.put(HistoryScreenController());

  DropDownButtonController dropDownButtonController =
      Get.put(DropDownButtonController());

  HistoryModel? historyModel;

  BannerAd? bannerAd;

  bool _isLoaded = false;

  RxInt currentIndex = 0.obs;

  List<String> suggestions = [
    'apple'.tr,
    'banana'.tr,
    'cherry'.tr,
    'date'.tr,
    'elderberry'.tr,
    'fig'.tr,
    'grape'.tr,
    'honeydew'.tr,
    'orange'.tr,
    'queen'.tr,
    'kingdom'.tr,
    'viking'.tr,
  ];

  RxInt _page = 0.obs;

  @override
  void dispose() {
    homeScreenController.adsHelper.disposeAds();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final result = await customDialogBox(
            title: 'Exit App'.tr,
            voidCallBack: () {
              exit(0);
            },
            voidCallBack2: Get.back,
            content: 'Are you sure to exit from App?'.tr,
            context: context);
        return result;
      },
      child: SafeArea(
          child: Scaffold(
        bottomNavigationBar: bottomNavigationBar(currentIndex),
        backgroundColor: Colors.grey.shade200,
        //resizeToAvoidBottomInset: false,
        drawer: Drawer(
            width: Get.width * 0.8,
            child: ListView(
              children: [
                Container(
                  color: Color(0xFFE64D3D),
                  height: Get.height * 0.295,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Get.height * 0.11,
                        margin: EdgeInsets.only(top: 30, left: 15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //color: Theme.of(context).colorScheme.primary
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipOval(
                              child: Image.asset(
                            'assets/dictionary.png',
                            fit: BoxFit.cover,
                          )),
                          // Icon(
                          //   Icons.translate,
                          //   size: 40,
                          //   color: Colors.white,
                          // ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 15),
                        child: Text(
                          'All Languages Voice Dictionary'.tr,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                drawerCard(
                    onTap: () {
                      Get.back();
                    },
                    icon: Icons.home,
                    text: 'Home'.tr),
                drawerCard(
                    onTap: () {
                      Get.to(() => LanguageSelectionScreen());
                    },
                    icon: Icons.language,
                    text: 'Select Languages'.tr),
                drawerCard(
                    onTap: () {
                      Get.to(TranslationScreen());
                    },
                    icon: Icons.translate,
                    text: 'Translation'.tr),
                drawerCard(
                    onTap: () {
                      Get.to(HistoryScreen());
                    },
                    icon: Icons.history,
                    text: 'History'.tr),
                drawerCard(
                    onTap: () {
                      Get.to(FavouriteScreen());
                    },
                    icon: Icons.favorite,
                    text: 'Favourites'.tr),
                drawerCard(
                    onTap: () {
                      Get.to(() => SettingScreen());
                    },
                    icon: Icons.settings,
                    text: 'Setting'.tr),
              ],
            )),
        appBar: AppBar(
          title: Text(
            'ALL LANGUAGES DICTIONARY'.tr,
            style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFE64D3D),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.28,
                child: Stack(
                  children: [
                    Container(
                      height: Get.height * 0.28,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Color(0xFFE64D3D),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                      //color: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: 30.w,
                              right: 30.w,
                            ),
                            margin: EdgeInsets.only(left: 10).r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Color(0xFFEFEFEF),
                            ),
                            child: customDropDownButton(
                                homeScreenController.dropDownValue1,
                                (String? newValue) {
                              if (newValue != null) {
                                homeScreenController.dropDownValue1.value =
                                    newValue;
                                //dropDownButtonController.getLangCode(newValue);
                                //String? languageCode = getLanguageCode(newValue);
                                // if (languageCode != null) {
                                //   homeScreenController.searchContain(
                                //       homeScreenController.textEditingController
                                //           .text, languageCode);
                                // }
                              }
                            }, Color(0xFFEFEFEF), Color(0xFFE64D3D)),
                          ),
                          customIconButton(
                            () {
                              String temp =
                                  homeScreenController.dropDownValue1.value;
                              homeScreenController.dropDownValue1.value =
                                  homeScreenController.dropDownValue2.value;
                              homeScreenController.dropDownValue2.value = temp;
                            },
                            'assets/swap_arrows.png',
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 30,
                              right: 30,
                            ).r,
                            margin: EdgeInsets.only(right: 10.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Color(0xFFEFEFEF),
                            ),
                            child: customDropDownButton(
                                homeScreenController.dropDownValue2,
                                (String? newValue) {
                              if (newValue != null) {
                                homeScreenController.dropDownValue2.value =
                                    newValue;
                              }
                            }, Color(0xFFFFFFFF), Color(0xFFE64D3D)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Get.height * 0.13,
                          left: Get.width * 0.06,
                          right: Get.width * 0.06),
                      child: Container(
                        height: Get.height * 0.08,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Obx(() {
                            String currentText =
                                homeScreenController.currentText.value;
                            bool isFavourite = favouriteController
                                .favouritesList
                                .contains(currentText);
                            bool isTextEmpty = currentText.isEmpty;

                            return Autocomplete<String>(
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable.empty();
                                } else {
                                  return suggestions.where((String option) {
                                    return option.contains(
                                        textEditingValue.text.toLowerCase());
                                  });
                                }
                              },
                              fieldViewBuilder: (
                                BuildContext context,
                                TextEditingController textEditingController,
                                FocusNode focusNode,
                                VoidCallback onFieldSubmitted,
                              ) {
                                homeScreenController.textEditingController =
                                    textEditingController;
                                homeScreenController.focusNode = focusNode;
                                focusNode.addListener(() {
                                  homeScreenController.update();
                                });
                                return TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: focusNode.hasFocus
                                        ? ''
                                        : 'Write Something...'.tr,
                                    alignLabelWithHint: true,
                                    contentPadding: EdgeInsets.only(
                                        top: 20, left: 15, right: 15),
                                    suffixIcon: Wrap(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await homeScreenController
                                                .checkInternetConnection();
                                            if (!homeScreenController
                                                .isConnected.value) {
                                              homeScreenController
                                                  .checkInternetConnection();
                                            } else {
                                              if (homeScreenController
                                                  .speechToText
                                                  .isNotListening) {
                                                homeScreenController
                                                    .startListening();
                                                showListeningDialog(context);
                                              } else {
                                                homeScreenController
                                                    .stopListening();
                                              }
                                            }
                                          },
                                          tooltip: 'Listen'.tr,
                                          icon: Image.asset(
                                            'assets/speaker.png',
                                            height: Get.height * 0.035,
                                            width: Get.width * 0.04,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0, top: 4),
                                          child: IconButton(
                                            onPressed: () async {
                                              await homeScreenController
                                                  .checkInternetConnection();

                                              if (!homeScreenController
                                                  .isConnected.value) {
                                                homeScreenController
                                                    .showNoInternetDialog();
                                                return;
                                              }
                                              await dropDownButtonController
                                                  .languageCode(
                                                      homeScreenController
                                                          .dropDownValue2
                                                          .value);
                                              dropDownButtonController
                                                  .getLangCode(
                                                      homeScreenController
                                                          .dropDownValue2
                                                          .value);
                                              if (homeScreenController
                                                      .textEditingController
                                                      .text
                                                      .isNotEmpty
                                                 &&
                                                  historyScreenController
                                                      .historyList
                                                      .any((item) =>
                                                          item.text ==
                                                          homeScreenController
                                                              .textEditingController
                                                              .text
                                                  )
                                              ) {
                                                historyScreenController
                                                    .addToHistory(
                                                        homeScreenController
                                                            .textEditingController
                                                            .text);
                                              }
                                              ;
                                              homeScreenController
                                                      .textEditingController
                                                      .text
                                                      .isNotEmpty
                                                  ? Get.to(() => Meaning())
                                                  : null;
                                              // if (homeScreenController.adsHelper
                                              //         .interstitialAd !=
                                              //     null) {
                                              //   homeScreenController
                                              //       .adsHelper.interstitialAd
                                              //       ?.show();
                                              //   print(
                                              //       'interstitial ad load successfuly');
                                              // } else {
                                              //   print(
                                              //       'interstitial ad not loaded');
                                              // }
                                            },
                                            icon: Image.asset(
                                              'assets/search.png',
                                              height: Get.height * 0.035.h,
                                              width: Get.width * 0.07.w,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        ///
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       right: 10.0, top: 4),
                                        //   child: IconButton(
                                        //     onPressed: () async {
                                        //       try {
                                        //         // Check Internet Connection
                                        //         print(
                                        //             'Checking internet connection...');
                                        //         await homeScreenController
                                        //             .checkInternetConnection();
                                        //
                                        //         if (!homeScreenController
                                        //             .isConnected.value) {
                                        //           print(
                                        //               'No internet connection. Showing dialog.');
                                        //           homeScreenController
                                        //               .showNoInternetDialog();
                                        //           return;
                                        //         }
                                        //
                                        //         // Set Language Code
                                        //         print(
                                        //             'Setting language code...');
                                        //         final selectedLanguage =
                                        //             homeScreenController
                                        //                 .dropDownValue2.value;
                                        //         await dropDownButtonController
                                        //             .languageCode(
                                        //                 selectedLanguage);
                                        //         dropDownButtonController
                                        //             .getLangCode(
                                        //                 selectedLanguage);
                                        //
                                        //         // Add to History
                                        //         final inputText =
                                        //             homeScreenController
                                        //                 .textEditingController
                                        //                 .text;
                                        //         if (inputText.isNotEmpty &&
                                        //             historyScreenController
                                        //                 .historyList
                                        //                 .any((item) =>
                                        //                     item.text ==
                                        //                     homeScreenController
                                        //                         .textEditingController
                                        //                         .text)) {
                                        //           print('Adding to history...');
                                        //           await historyScreenController
                                        //               .addToHistory(
                                        //                   inputText); // Ensure this is awaited
                                        //           print(
                                        //               'Navigating to Meaning screen...');
                                        //           Get.to(() => Meaning());
                                        //         } else {
                                        //           print(
                                        //               'Input text is empty. No navigation.');
                                        //         }
                                        //
                                        //         // Show Interstitial Ad
                                        //         // final interstitialAd = homeScreenController.adsHelper.interstitialAd;
                                        //         //  if (interstitialAd != null) {
                                        //         //    print('Showing interstitial ad...');
                                        //         //    interstitialAd.show();
                                        //         //  } else {
                                        //         //    print('Interstitial ad not loaded');
                                        //         //  }
                                        //       } catch (e) {
                                        //         print(
                                        //             'Error during onPressed: $e');
                                        //       }
                                        //     },
                                        //     icon: Image.asset(
                                        //       'assets/search.png',
                                        //       height: Get.height * 0.035,
                                        //       width: Get.width * 0.07,
                                        //       fit: BoxFit.fill,
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                  controller:
                                      //homeScreenController.speechToText.isListening ? '${homeScreenController.lastWords}':
                                      //homeScreenController.textEditingController,
                                      textEditingController,
                                  focusNode: focusNode,
                                  onChanged: (text) {
                                    homeScreenController.updateTextField(text);
                                  },
                                  maxLines: 3,
                                );
                              },
                              onSelected: (String selection) async {
                                homeScreenController.updateTextField(selection);
                                homeScreenController
                                    .textEditingController.text = selection;
                                await dropDownButtonController.languageCode(
                                    homeScreenController.dropDownValue2.value);
                                dropDownButtonController.getLangCode(
                                    homeScreenController.dropDownValue2.value);
                                Get.find<HistoryScreenController>()
                                    .addToHistory(homeScreenController
                                        .textEditingController.text);
                                Get.to(() => Meaning());
                              },
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Features'.tr,
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE64D3D),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          if (scrollController.hasClients) {
                            scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn);
                          }
                        },
                        child: Text('View all'.tr,
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFE64D3D),
                            )))
                  ],
                ),
              ),
              Container(
                height: Get.height * 0.17,
                margin: EdgeInsets.only(left: 11, right: 11),
                child: ListView(
                  shrinkWrap: true,
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  children: [
                    reusableStack1(
                        image: 'assets/translations.png',
                        title: 'Translations'.tr,
                        onTap: () async {
                          await homeScreenController.checkInternetConnection();

                          if (!homeScreenController.isConnected.value) {
                            Get.to(() => TranslationScreen());
                            homeScreenController.showNoInternetDialog();
                          } else {
                            if (homeScreenController.adsHelper.interstitialAd !=
                                null) {
                              homeScreenController.adsHelper.showInterstitialAd(
                                  nextScreen: '/translation');
                              // Get.to(() => TranslationScreen());
                              print('interstitial ad load successfully');
                            } else {
                              Get.to(() => TranslationScreen());
                            }
                          }

                          //Get.to(() => TranslationScreen());
                        }),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    reusableStack1(
                      image: 'assets/favourite.png',
                      title: 'Save Words'.tr,
                      onTap: () {
                        //Get.to(() => FavouriteScreen());
                        if (homeScreenController.adsHelper.interstitialAd !=
                            null) {
                          homeScreenController.adsHelper
                              .showInterstitialAd(nextScreen: '/favourite');
                          print('interstitial ad load successfuly');
                        } else {
                          Get.to(() => FavouriteScreen());
                          print('interstitial ad not loaded');
                        }
                      },
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    reusableStack1(
                        image: 'assets/history.png',
                        title: 'History'.tr,
                        onTap: () {
                          //Get.to(() => HistoryScreen());
                          if (homeScreenController.adsHelper.interstitialAd !=
                              null) {
                            homeScreenController.adsHelper
                                .showInterstitialAd(nextScreen: '/history');
                            print('interstitial ad load successfuly');
                          } else {
                            Get.to(() => HistoryScreen());
                            print('interstitial ad not loaded');
                          }
                        }),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    reusableStack1(
                      image: 'assets/share.png',
                      title: 'Share'.tr,
                      onTap: () async {
                        await homeScreenController.checkInternetConnection();

                        if (!homeScreenController.isConnected.value) {
                          homeScreenController.showNoInternetDialog();
                        } else {
                          String content = Platform.isAndroid
                              ? 'Hey check out my app at: https://play.google.com/store/apps/details?id=com.pzapps.alllanguagesdictionary'
                              : 'Hey check out my app at: https://apps.apple.com/us/developer/zia-ur-rahman/id1529429081';
                          Share.share(content);
                          print('clicked');
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Obx(
                () => (isNativeAdLoaded.value &&
                        !GlobalVariable.isAppOpenAdShowing.value)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 2),
                        child: SizedBox(
                          width: Get.width,
                          height: 320,
                          child: AdWidget(ad: nativeAd!),
                        ))
                    : (!GlobalVariable.isPurchasedMonthly.value &&
                            !GlobalVariable.isPurchasedYearly.value &&
                            !GlobalVariable.isPurchasedLifeTime.value)
                        ? SizedBox()
                        // Expanded(
                        // flex: 1,
                        // child: Shimmer.fromColors(
                        //     baseColor: Colors.black,
                        //     highlightColor: Colors.white,
                        //     child: const NewsCardSkelton()),
                        //    )
                        : const SizedBox(),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void showListeningDialog(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              color: Colors.black.withOpacity(0), // Adjust opacity as needed
            ),
          ),
          Center(
            child: SpeakerAnimation(),
          ),
        ],
      ),
    );

    overlayState?.insert(overlayEntry);

    // Remove the overlay entry after some time or based on some condition
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry?.remove();
    });
  }
}
