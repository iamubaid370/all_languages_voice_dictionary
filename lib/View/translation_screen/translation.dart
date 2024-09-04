import 'dart:io';
import 'dart:ui';

import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_controller.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/translation_screen/translationscreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/meaning_screen/meaning.dart';
import 'package:all_languages_voice_dictionary/controller/dropdownbutton_controller.dart';
import 'package:all_languages_voice_dictionary/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';

import '../../widgets/dropdown_button.dart';
import '../../widgets/iconbutton.dart';
import '../../widgets/speaker_animation.dart';
import '../history_screen/historyscreen_controller.dart';
import '../home_screen/home_screen.dart';

class TranslationScreen extends StatefulWidget {
  TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  HomeScreenController homeScreenController = Get.find();
  TranslationScreenController translationScreenController =
      Get.put(TranslationScreenController());

  DropDownButtonController dropDownButtonController =
      Get.find<DropDownButtonController>();

  FocusNode? focusNode;

  RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.34,
                child: Stack(
                  children: [
                    Container(
                      height: Get.height * 0.34,
                      width: Get.width,
                      //color: Color(0xFFE64D3D),
                      decoration: BoxDecoration(
                        color: Color(0xFFE64D3D),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 12.0, top: Get.height * 0.03),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 30,
                        )
                        //     Image.asset(
                        //   'assets/drawer.png',
                        //   // height: Get.height * 0.014.h,
                        //   // width: Get.width * 0.07.w,
                        //   height: Get.height * 0.016,
                        //   width: Get.width * 0.08,
                        //   //fit: BoxFit.fill,
                        // ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.1,
                          horizontal: Get.width * 0.2),
                      child: Text('ALL LANGUAGES DICTIONARY',
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: Get.height * 0.03),
                      padding:
                          EdgeInsets.symmetric(vertical: Get.height * 0.12),
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
                                Get.find<HomeScreenController>().dropDownValue1,
                                (String? newValue) {
                              if (newValue != null) {
                                Get.find<HomeScreenController>().dropDownValue1.value =
                                    newValue;
                              }
                            }, Color(0xFFEFEFEF),Color(0xFFE64D3D)),
                          ),
                          customIconButton(
                            () {
                              String temp =
                                  Get.find<HomeScreenController>().dropDownValue1.value;
                              Get.find<HomeScreenController>().dropDownValue1.value =
                                  Get.find<HomeScreenController>().dropDownValue2.value;
                              Get.find<HomeScreenController>().dropDownValue2.value = temp;
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
                              Get.find<HomeScreenController>().dropDownValue2,
                              (String? newValue) async {
                                if (newValue != null) {
                                  Get.find<HomeScreenController>().dropDownValue2.value =
                                      newValue;
                                  String translatedText =
                                      await translationScreenController
                                          .translateText(
                                              translationScreenController
                                                  .textEditingController.text);
                                  Get.find<TranslationScreenController>()
                                      .translatedText
                                      .value = translatedText;
                                }
                              },
                              Color(0xFFFFFFFF),Color(0xFFE64D3D)
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.05, vertical: Get.width * 0.05),
                    child: Container(
                      height: Get.height * 0.25,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 25.0).r,
                        child: Obx(() {
                          String currentText =
                              translationScreenController.currentText.value;
                          bool isFavourite = Get.find<FavouriteController>().favouritesList
                              .contains(currentText);
                          bool isTextEmpty = currentText.isEmpty;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                  //focusNode.hasFocus ? '' :
                                  'Write Something...',
                                ),
                                controller:
                                //homeScreenController.speechToText.isListening ? '${homeScreenController.lastWords}':
                                //homeScreenController.textEditingController,
                                translationScreenController
                                    .textEditingController,
                                focusNode: focusNode,
                                maxLines: 3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await homeScreenController.checkInternetConnection();
                                      if(!homeScreenController.isConnected.value){
                                        homeScreenController.showNoInternetDialog();
                                      }else{
                                        if ( Get.find<TranslationScreenController>()
                                            .speechToText.isNotListening) {
                                          Get.find<TranslationScreenController>().startListening();
                                          showListeningDialog(context);
                                        } else {
                                          Get.find<TranslationScreenController>().stopListening();
                                        }
                                      }

                                    },
                                    tooltip: 'Listen',
                                    icon: Image.asset(
                                      'assets/speaker.png',
                                      height: Get.height * 0.035.h,
                                      width: Get.width * 0.04.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  Obx(() {
                                    String currentText =
                                        translationScreenController.textEditingController.text;
                                    // bool isFavourite =
                                    // Get.find<FavouriteController>()
                                    //     .favouritesList
                                    //     .contains(currentText);
                                    final bool isFavourite =
                                    Get.find<FavouriteController>().isFavourite(currentText);
                                    bool isTextEmpty = currentText.isEmpty;
                                    return IconButton(
                                      onPressed: () {
                                        if (currentText.isNotEmpty) {
                                          if (isFavourite) {
                                            Get.find<FavouriteController>()
                                                .deleteFromFavourite(currentText);
                                          } else {
                                            Get.find<FavouriteController>()
                                                .addToFavourites(currentText);
                                          }
                                        } else {
                                          return;
                                        }
                                      },
                                      icon: Icon(
                                        isFavourite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavourite
                                            ? Color(0xFFE64D3D)
                                            : Color(0xFFE64D3D).withOpacity(0.8),
                                      ),
                                      color: isTextEmpty ? Colors.grey : null,
                                    );
                                  }),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 10.0, top: 4),
                                    child: IconButton(
                                      onPressed: () async {
                                        String translatedText =
                                        await translationScreenController
                                            .translateText( translationScreenController
                                            .textEditingController.text);
                                        translationScreenController
                                            .translatedText.value = translatedText;
                                      },
                                      icon: Image.asset(
                                        'assets/search.png',
                                        height: Get.height * 0.035.h,
                                        width: Get.width * 0.07.w,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.05, vertical: Get.width * 0.03),
                    child: Container(
                      height: Get.height * 0.23.h,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            String translatedText =
                                translationScreenController.translatedText.value;
                            return Padding(
                              padding: const EdgeInsets.only(top: 10, right: 10,left: 10),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(translatedText)),
                            );
                          }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  translationScreenController.speak(translationScreenController.translatedText.value, Get.find<HomeScreenController>().dropDownValue2.value);
                                },
                                tooltip: 'Listen',
                                icon:Icon(Icons.speaker_phone,color:Color(0xFFE64D3D) ,),
                                // Image.asset(
                                //   'assets/speaker.png',
                                //   height: Get.height * 0.035.h,
                                //   width: Get.width * 0.04.w,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              Obx(() {
                                String currentText =
                                    translationScreenController.translatedText.value;
                                // bool isFavourite =
                                // Get.find<FavouriteController>()
                                //     .favouritesList
                                //     .contains(currentText);
                                final bool isFavourite =
                                Get.find<FavouriteController>().isFavourite(currentText);
                                bool isTextEmpty = currentText.isEmpty;
                                return IconButton(
                                  onPressed: () {
                                    if (currentText.isNotEmpty) {
                                      if (isFavourite) {
                                        Get.find<FavouriteController>()
                                            .deleteFromFavourite(currentText);
                                      } else {
                                        Get.find<FavouriteController>()
                                            .addToFavourites(currentText);
                                      }
                                    } else {
                                      return;
                                    }
                                  },
                                  icon: Icon(
                                    isFavourite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavourite
                                        ? Color(0xFFE64D3D)
                                        : Color(0xFFE64D3D).withOpacity(0.8),
                                  ),
                                  color: isTextEmpty ? Colors.grey : null,
                                );
                              }),
                              Padding(
                                padding:
                                const EdgeInsets.only(right: 10.0, top: 4),
                                child: IconButton(
                                  onPressed: () async {
                                      String content = Platform.isAndroid
                                          ? 'Hey check out my app at: https://play.google.com/store/apps/details?id=com.pzapps.alllanguagesdictionary'
                                          : 'Hey check out my app at: https://apps.apple.com/us/developer/zia-ur-rahman/id1529429081';
                                      Share.share(content);

                                  },
                                  icon: Image.asset(
                                    'assets/share.png',
                                    height: Get.height * 0.035.h,
                                    width: Get.width * 0.07.w,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ),
                ],),
              )

            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(currentIndex),
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
