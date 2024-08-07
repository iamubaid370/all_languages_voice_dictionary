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

import '../../widgets/dropdown_button.dart';
import '../../widgets/iconbutton.dart';
import '../../widgets/speaker_animation.dart';
import '../history_screen/historyscreen_controller.dart';
import '../home_screen/home_screen.dart';

class TranslationScreen extends StatelessWidget {
  TranslationScreen({super.key});

  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  FavouriteController favouriteController = Get.put(FavouriteController());
  TranslationScreenController translationScreenController =
      Get.put(TranslationScreenController());
  DropDownButtonController dropDownButtonController =
      Get.put(DropDownButtonController());
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
              // SizedBox(
              //   height: 40.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     IconButton(
              //       onPressed: () {
              //         Get.to(()=>HomeScreen());
              //       },
              //       icon: const Icon(
              //         Icons.arrow_back_ios_new,
              //         color: Colors.deepOrange,
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(left: 90.0).r,
              //       child: const Text('Translation',
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 28,
              //               color: Colors.deepOrange,
              //               fontFamily: 'arial')),
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 50.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Container(
              //       padding: EdgeInsets.only(
              //         left: 30.w,
              //         right: 30.w,
              //       ),
              //       margin: EdgeInsets.only(left: 42).r,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(30.r),
              //         color: Color(0xFFE64D3D),
              //       ),
              //       child: customDropDownButton(
              //         homeScreenController.dropDownValue1,
              //             (String? newValue) {
              //           if (newValue != null) {
              //             homeScreenController.dropDownValue1.value = newValue;
              //             //dropDownButtonController.getLangCode(newValue);
              //             //String? languageCode = getLanguageCode(newValue);
              //             // if (languageCode != null) {
              //             //   homeScreenController.searchContain(
              //             //       homeScreenController.textEditingController
              //             //           .text, languageCode);
              //             // }
              //           }
              //         },Color(0xFFEFEFEF)
              //       ),
              //     ),
              //     Container(
              //       //height: Get.height*0.09,
              //       padding: EdgeInsets.all(6).w,
              //       decoration: BoxDecoration(
              //           shape: BoxShape.circle, color: Colors.white),
              //       child: customIconButton(
              //             () {
              //           String temp = homeScreenController.dropDownValue1.value;
              //           homeScreenController.dropDownValue1.value =
              //               homeScreenController.dropDownValue2.value;
              //           homeScreenController.dropDownValue2.value = temp;
              //         },
              //         'assets/swap_arrows.png',
              //       ),
              //     ),
              //     Container(
              //       padding: EdgeInsets.only(
              //         left: 30,
              //         right: 30,
              //       ).r,
              //       margin: EdgeInsets.only(right: 42.w),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(30.r),
              //         color: Color(0xFFE64D3D),
              //       ),
              //       child: customDropDownButton(
              //         homeScreenController.dropDownValue2,
              //             (String? newValue) {
              //           if (newValue != null) {
              //             homeScreenController.dropDownValue2.value = newValue;
              //           }
              //         },Color(0xFFEFEFEF)
              //       ),
              //     )
              //   ],
              // ),

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
                        onPressed: () {},
                        icon:
                            // Icon(
                            //   Icons.drag_handle,
                            //   color: Colors.white,
                            //   size: 30,
                            // )
                            Image.asset(
                          'assets/drawer.png',
                          // height: Get.height * 0.014.h,
                          // width: Get.width * 0.07.w,
                          height: Get.height * 0.016,
                          width: Get.width * 0.08,
                          //fit: BoxFit.fill,
                        ),
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
                            }, Color(0xFFEFEFEF)),
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
                              (String? newValue) async {
                                if (newValue != null) {
                                  homeScreenController.dropDownValue2.value =
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
                              Color(0xFFFFFFFF),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding:  EdgeInsets.only(top:Get.height * 0.22,left: Get.width * 0.06,right:Get.width * 0.06),
                    //   child: Container(
                    //     height: Get.height * 0.08,
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(12)
                    //     ),
                    //     child: Padding(
                    //       padding: EdgeInsets
                    //           .only(left: 25.0)
                    //           .r,
                    //       child:
                    //       Obx(() {
                    //
                    //         String currentText = translationScreenController.currentText.value;
                    //         bool isFavourite = favouriteController.favouritesList
                    //             .contains(currentText);
                    //         bool isTextEmpty = currentText.isEmpty;
                    //         return TextField(
                    //           decoration: InputDecoration(
                    //             border: InputBorder.none,
                    //             hintText:
                    //             //focusNode.hasFocus ? '' :
                    //             'Write Something...',
                    //             suffixIcon:
                    //             Wrap(
                    //               children: [
                    //                 // Padding(
                    //                 //   padding: EdgeInsets
                    //                 //       .only(bottom: 50)
                    //                 //       .r,
                    //                 //   child: Padding(
                    //                 //     padding: EdgeInsets
                    //                 //         .only(top: 8.0, right: 10)
                    //                 //         .r,
                    //                 //     child:
                    //                 //     ///favourite-button
                    //                 //     IconButton(
                    //                 //       onPressed: () {
                    //                 //         if (currentText.isNotEmpty) {
                    //                 //           if (isFavourite) {
                    //                 //             favouriteController
                    //                 //                 .deleteFromFavourite(
                    //                 //                 currentText
                    //                 //             );
                    //                 //           } else {
                    //                 //             favouriteController.addToFavourites(
                    //                 //                 currentText);
                    //                 //           }
                    //                 //         } else {
                    //                 //           return;
                    //                 //         }
                    //                 //       },
                    //                 //       icon: Icon(
                    //                 //         isFavourite ? Icons.favorite : Icons
                    //                 //             .favorite_border,
                    //                 //         color: isFavourite ? Colors.red : Color(
                    //                 //             0xFFE64D3D),
                    //                 //       ),
                    //                 //       color: isTextEmpty ? Colors.grey : null,
                    //                 //     ),
                    //                 //   ),
                    //                 // ),
                    //                 IconButton(
                    //                   onPressed: () {
                    //                     if (homeScreenController.speechToText
                    //                         .isNotListening) {
                    //                       homeScreenController.startListening();
                    //                       showListeningDialog(context);
                    //                     } else {
                    //                       homeScreenController.stopListening();
                    //                     }
                    //                   },
                    //                   tooltip: 'Listen',
                    //                   icon: Image.asset(
                    //                     'assets/speaker.png',
                    //                     height: Get.height * 0.035.h,
                    //                     width: Get.width * 0.04.w,
                    //                     fit: BoxFit.cover,
                    //                   ),
                    //                 ),
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(right: 10.0,top: 4),
                    //                   child: IconButton(onPressed: () async {
                    //                     String translatedText = await translationScreenController.translateText();
                    //                     translationScreenController.translatedText.value = translatedText;
                    //                   },
                    //                     icon: Image.asset('assets/search.png',
                    //                       height: Get.height * 0.035.h,
                    //                       width: Get.width * 0.07.w,
                    //                       fit: BoxFit.fill,
                    //                     ),),
                    //                 ),
                    //               ],),
                    //
                    //           ),
                    //           controller:
                    //           //homeScreenController.speechToText.isListening ? '${homeScreenController.lastWords}':
                    //           //homeScreenController.textEditingController,
                    //           translationScreenController.textEditingController,
                    //           focusNode: focusNode,
                    //           onChanged: (text)  {
                    //             homeScreenController.updateTextField(text);
                    //
                    //           },
                    //           maxLines: 3,
                    //         );
                    //       }),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05, vertical: Get.width * 0.05),
                child: Container(
                  height: Get.height * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 25.0).r,
                    child: Obx(() {
                      String currentText =
                          translationScreenController.currentText.value;
                      bool isFavourite = favouriteController.favouritesList
                          .contains(currentText);
                      bool isTextEmpty = currentText.isEmpty;
                      return Column(
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  //focusNode.hasFocus ? '' :
                                  'Write Something...',
                              // suffixIcon:
                              // Wrap(
                              //   children: [
                              //     // Padding(
                              //     //   padding: EdgeInsets
                              //     //       .only(bottom: 50)
                              //     //       .r,
                              //     //   child: Padding(
                              //     //     padding: EdgeInsets
                              //     //         .only(top: 8.0, right: 10)
                              //     //         .r,
                              //     //     child:
                              //     //     ///favourite-button
                              //     //     IconButton(
                              //     //       onPressed: () {
                              //     //         if (currentText.isNotEmpty) {
                              //     //           if (isFavourite) {
                              //     //             favouriteController
                              //     //                 .deleteFromFavourite(
                              //     //                 currentText
                              //     //             );
                              //     //           } else {
                              //     //             favouriteController.addToFavourites(
                              //     //                 currentText);
                              //     //           }
                              //     //         } else {
                              //     //           return;
                              //     //         }
                              //     //       },
                              //     //       icon: Icon(
                              //     //         isFavourite ? Icons.favorite : Icons
                              //     //             .favorite_border,
                              //     //         color: isFavourite ? Colors.red : Color(
                              //     //             0xFFE64D3D),
                              //     //       ),
                              //     //       color: isTextEmpty ? Colors.grey : null,
                              //     //     ),
                              //     //   ),
                              //     // ),
                              //     IconButton(
                              //       onPressed: () {
                              //         if (homeScreenController.speechToText
                              //             .isNotListening) {
                              //           homeScreenController.startListening();
                              //           showListeningDialog(context);
                              //         } else {
                              //           homeScreenController.stopListening();
                              //         }
                              //       },
                              //       tooltip: 'Listen',
                              //       icon: Image.asset(
                              //         'assets/speaker.png',
                              //         height: Get.height * 0.035.h,
                              //         width: Get.width * 0.04.w,
                              //         fit: BoxFit.cover,
                              //       ),
                              //     ),
                              //     Padding(
                              //       padding: const EdgeInsets.only(right: 10.0,top: 4),
                              //       child: IconButton(onPressed: () async {
                              //         String translatedText = await translationScreenController.translateText();
                              //         translationScreenController.translatedText.value = translatedText;
                              //       },
                              //         icon: Image.asset('assets/search.png',
                              //           height: Get.height * 0.035.h,
                              //           width: Get.width * 0.07.w,
                              //           fit: BoxFit.fill,
                              //         ),),
                              //     ),
                              //   ],),
                            ),
                            controller:
                                //homeScreenController.speechToText.isListening ? '${homeScreenController.lastWords}':
                                //homeScreenController.textEditingController,
                                translationScreenController
                                    .textEditingController,
                            focusNode: focusNode,
                            onChanged: (text) {
                              homeScreenController.updateTextField(text);
                            },
                            maxLines: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (homeScreenController
                                      .speechToText.isNotListening) {
                                    homeScreenController.startListening();
                                    showListeningDialog(context);
                                  } else {
                                    homeScreenController.stopListening();
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
                                    homeScreenController.currentText.value;
                                bool isFavourite =
                                    Get.find<FavouriteController>()
                                        .favouritesList
                                        .contains(currentText);
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

              /// textfield and button
              // Container(
              //   height: Get.height * 0.23.h,
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 25.0).r,
              //     child: Obx(() {
              //       String currentText = translationScreenController.currentText.value;
              //       bool isFavourite = favouriteController.favouritesList
              //           .contains(currentText);
              //       bool isTextEmpty = currentText.isEmpty;
              //
              //       return TextField(
              //         decoration: InputDecoration(
              //           border: InputBorder.none,
              //           hintText: translationScreenController.focusNode.hasFocus? '' : 'Write Something...',
              //           suffixIcon: Padding(
              //             padding: EdgeInsets.only(bottom: 50).r,
              //             child: Padding(
              //               padding: EdgeInsets.only(top: 8.0, right: 10).r,
              //               ///favoritebutton
              //               // child: IconButton(
              //               //   onPressed: () {
              //               //     if (currentText.isNotEmpty) {
              //               //       if (isFavourite) {
              //               //         favouriteController
              //               //             .deleteFromFavourite(currentText);
              //               //       } else {
              //               //         favouriteController
              //               //             .addToFavourites(currentText);
              //               //       }
              //               //     } else {
              //               //       return;
              //               //     }
              //               //   },
              //               //   icon: Icon(
              //               //     isFavourite
              //               //         ? Icons.favorite
              //               //         : Icons.favorite_border,
              //               //     color: isFavourite
              //               //         ? Colors.red
              //               //         : Color(0xFFE64D3D),
              //               //   ),
              //               //   color: isTextEmpty ? Colors.grey : null,
              //               // ),
              //             ),
              //           ),
              //         ),
              //         controller:
              //             translationScreenController.textEditingController,
              //         // onChanged: (text) {
              //         //   homeScreenController.updateTextField(text);
              //         // },
              //         maxLines: 3,
              //       );
              //     }),
              //   ),
              // ),
              // SizedBox(
              //   width:Get.width * 0.8.w,
              //   height: Get.width * 0.12.h,
              //   child: ElevatedButton(
              //     onPressed: () async {
              //       //dropDownButtonController.getLangCode(homeScreenController.dropDownValue2.value);
              //       // String targetLanguage =
              //       //     homeScreenController.dropDownValue2.value;
              //       // translationScreenController.getLangCode(targetLanguage);
              //       String translatedText = await translationScreenController.translateText();
              //       translationScreenController.translatedText.value = translatedText;
              //
              //     },
              //     style: ButtonStyle(
              //       backgroundColor: MaterialStateProperty.all(
              //         Color(0xFFE64D3D),
              //       ),
              //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10.0.r),
              //             // side: BorderSide(color: Colors.red)
              //           )),
              //     ),
              //     child: const Text(
              //       'Search',
              //       style: TextStyle(color: Colors.white,fontFamily: 'arial'),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 2.h,
              // ),
              // Divider(),

              // Container(
              //   height: Get.height * 0.23.h,
              //   child: Obx(() {
              //     String textToTranslate =
              //         translationScreenController.textEditingController.text;
              //     String targetLanguage =
              //         homeScreenController.dropDownValue2.value;
              //     String? targetLanguageCode = translationScreenController.getLangCode(targetLanguage);
              //
              //     if (targetLanguageCode == null) {
              //       return Center(child: Text('Target language is not supported.'));
              //     }
              //
              //     Future<String> translatedTextFuture = homeScreenController
              //         .translateText(textToTranslate, targetLanguageCode!);
              //     //Future<String> translatedText = translationScreenController.getLangCode(targetLanguage);
              //
              //     return FutureBuilder<String>(
              //       future: translatedTextFuture,
              //       builder: (context, snapshot) {
              //         if (snapshot.connectionState == ConnectionState.waiting) {
              //           return Center(child: CircularProgressIndicator());
              //         } else if (snapshot.hasError) {
              //           return Center(
              //               child:
              //                   Text('Translation error: ${snapshot.error}'));
              //         } else {
              //           String translatedText = snapshot.data ?? '';
              //           return Text(translatedText);
              //         }
              //       },
              //     );
              //   }),
              // ),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05, vertical: Get.width * 0.05),
                child: Container(
                  height: Get.height * 0.23.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Obx(() {
                    // String textToTranslate =
                    //     translationScreenController.textEditingController.text;
                    // String targetLanguage =
                    //     homeScreenController.dropDownValue2.value;
                    // String? targetLanguageCode = translationScreenController.getLangCode(targetLanguage);

                    // if (targetLanguageCode == null) {
                    //   return Center(child: Text('Target language is not supported.'));
                    // }

                    // Future<String> translatedTextFuture = homeScreenController
                    //     .translateText(textToTranslate, targetLanguageCode!);
                    //Future<String> translatedText = translationScreenController.getLangCode(targetLanguage);
                    String translatedText =
                        translationScreenController.translatedText.value;
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, right: 10),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Text(translatedText)),
                    );
                    //   FutureBuilder<String>(
                    //   future: translatedTextFuture,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.waiting) {
                    //       return Center(child: CircularProgressIndicator());
                    //     } else if (snapshot.hasError) {
                    //       return Center(
                    //           child:
                    //               Text('Translation error: ${snapshot.error}'));
                    //     } else {
                    //       String translatedText = snapshot.data ?? '';
                    //       return Text(translatedText);
                    //     }
                    //   },
                    // );
                  }),
                ),
              ),
              // Obx(() {
              //   if (homeScreenController.adsHelper.isBannerAdLoaded.value) {
              //     return Container(
              //       width: homeScreenController.adsHelper.bannerAd!.size.width.toDouble(),
              //       height: homeScreenController.adsHelper.bannerAd!.size.height.toDouble(),
              //       child: AdWidget(ad: homeScreenController.adsHelper.bannerAd!),
              //     );
              //   }
              //   else {
              //     return SizedBox.shrink();
              //   }
              // }),
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
