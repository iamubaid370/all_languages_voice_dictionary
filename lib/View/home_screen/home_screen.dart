import 'dart:ui';

import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_controller.dart';
import 'package:all_languages_voice_dictionary/View/history_screen/history_screen.dart';
import 'package:all_languages_voice_dictionary/View/history_screen/historyscreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/translation_screen/translation.dart';
import 'package:all_languages_voice_dictionary/View/meaning_screen/meaning.dart';
import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:all_languages_voice_dictionary/controller/dropdownbutton_controller.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/widgets/bottom_navigation_bar.dart';
import 'package:all_languages_voice_dictionary/widgets/drawer_car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../model/history_model.dart';
import '../../widgets/dropdown_button.dart';
import '../../widgets/iconbutton.dart';
import '../../widgets/reusable_stack.dart';
import '../../widgets/speaker_animation.dart';
import '../favourite_screen/favourite_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  AdsHelper adsHelper = AdsHelper();
  HomeScreenController homeScreenController = Get.put(
    HomeScreenController(),
  );
  FavouriteController favouriteController = Get.put(FavouriteController());
  HistoryScreenController historyScreenController =
      Get.put(HistoryScreenController());
  DropDownButtonController dropDownButtonController =
      Get.put(DropDownButtonController());

  HistoryModel? historyModel;

  BannerAd? bannerAd;
  bool _isLoaded = false;
  RxInt currentIndex = 0.obs;

  List<String> suggestions = [
    'apple',
    'banana',
    'cherry',
    'date',
    'elderberry',
    'fig',
    'grape',
    'honeydew',
    'orange'
        'queen',
    'kingdom',
    'viking',
  ];

  RxInt _page = 0.obs;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
      // CurvedNavigationBar(
      //     key: _bottomNavigationKey,
      //     index: 0,
      //     items: <Widget>[
      //       Icon(Icons.home, size: 30),
      //       Icon(Icons.history, size: 30),
      //       Icon(Icons.settings, size: 30),
      //       Icon(Icons.settings, size: 30),
      //       Icon(Icons.settings, size: 30),
      //
      //     ],
      //     color: Colors.white,
      //     buttonBackgroundColor: Colors.white,
      //     backgroundColor: Colors.deepOrange,
      //     animationCurve: Curves.easeInOut,
      //     animationDuration: Duration(milliseconds: 400),
      //     onTap: (index) {
      //         _page.value = index;
      //     },
      //     //letIndexChange: (index) => true,
      //   ),
      bottomNavigationBar(currentIndex),
      backgroundColor: Colors.grey.shade200,
      //resizeToAvoidBottomInset: false,
      drawer:Drawer(
                width: Get.width * 0.8,
                child: ListView(
                  children: [
                    Container(
                      color: Color(0xFFE64D3D),
                      height: Get.height * 0.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30, left: 15),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.primary),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.translate,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40, left: 15),
                            child: Text(
                              'All Languages Voice Dictionary',
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
                        onTap: (){Get.back();
                          }, icon: Icons.home,
                        text: 'Home'),
                    drawerCard(
                        onTap: (){Get.to(TranslationScreen());
                        }, icon: Icons.translate,
                        text: 'Translation'),
                    drawerCard(
                        onTap: (){Get.to(HistoryScreen());
                        }, icon: Icons.history,
                        text: 'History'),
                    drawerCard(
                        onTap: (){Get.to(FavouriteScreen());
                        }, icon: Icons.favorite,
                        text: 'Favourites'),
                    drawerCard(
                        onTap: (){Get.back();
                        }, icon: Icons.settings,
                        text: 'Setting'),

                  ],
                )),
      appBar: AppBar(
        title: const Text('ALL LANGUAGES DICTIONARY',
            style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xFFE64D3D),
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
                  // Padding(
                  //   padding:
                  //       EdgeInsets.only(left: 12.0, top: Get.height * 0.03),
                  //   child: IconButton(
                  //     onPressed: () {
                  //
                  //     },
                  //     icon: Image.asset(
                  //       'assets/drawer.png',
                  //       // height: Get.height * 0.014.h,
                  //       // width: Get.width * 0.07.w,
                  //       height: Get.height * 0.016,
                  //       width: Get.width * 0.08,
                  //       //fit: BoxFit.fill,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //       vertical: Get.height * 0.09,
                  //       horizontal: Get.width * 0.2),
                  //   child: Text('ALL LANGUAGES DICTIONARY',
                  //       style: TextStyle(
                  //           fontFamily: 'Arial',
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w600,
                  //           color: Colors.white)),
                  // ),
                  Padding(
                    padding:  EdgeInsets.only(top: Get.height * 0.04),
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
                            (String? newValue) {
                              if (newValue != null) {
                                homeScreenController.dropDownValue2.value =
                                    newValue;
                              }
                            },
                            Color(0xFFFFFFFF),
                          ),
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
                        padding: EdgeInsets.only(left: 25.0).r,
                        child: Obx(() {
                          String currentText =
                              homeScreenController.currentText.value;
                          bool isFavourite = favouriteController.favouritesList
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
                                homeScreenController
                                    .update(); // Trigger rebuild on focus change
                              });
                              return TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: focusNode.hasFocus
                                      ? ''
                                      : 'Write Something...',
                                  suffixIcon: Wrap(
                                    children: [
                                      // Padding(
                                      //   padding: EdgeInsets
                                      //       .only(bottom: 50)
                                      //       .r,
                                      //   child: Padding(
                                      //     padding: EdgeInsets
                                      //         .only(top: 8.0, right: 10)
                                      //         .r,
                                      //     child:
                                      //     ///favourite-button
                                      //     IconButton(
                                      //       onPressed: () {
                                      //         if (currentText.isNotEmpty) {
                                      //           if (isFavourite) {
                                      //             favouriteController
                                      //                 .deleteFromFavourite(
                                      //                 currentText
                                      //             );
                                      //           } else {
                                      //             favouriteController.addToFavourites(
                                      //                 currentText);
                                      //           }
                                      //         } else {
                                      //           return;
                                      //         }
                                      //       },
                                      //       icon: Icon(
                                      //         isFavourite ? Icons.favorite : Icons
                                      //             .favorite_border,
                                      //         color: isFavourite ? Colors.red : Color(
                                      //             0xFFE64D3D),
                                      //       ),
                                      //       color: isTextEmpty ? Colors.grey : null,
                                      //     ),
                                      //   ),
                                      // ),
                                      IconButton(
                                        onPressed: () {
                                          if (homeScreenController
                                              .speechToText.isNotListening) {
                                            homeScreenController
                                                .startListening();
                                            showListeningDialog(context);
                                          } else {
                                            homeScreenController
                                                .stopListening();
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, top: 4),
                                        child: IconButton(
                                          onPressed: () async {
                                            await dropDownButtonController
                                                .languageCode(
                                                    homeScreenController
                                                        .dropDownValue2.value);
                                            dropDownButtonController
                                                .getLangCode(
                                                    homeScreenController
                                                        .dropDownValue2.value);
                                            historyScreenController
                                                .addToHistory(
                                                    homeScreenController
                                                        .textEditingController
                                                        .text);
                                            homeScreenController
                                                    .textEditingController
                                                    .text
                                                    .isNotEmpty
                                                ? Get.to(() => Meaning())
                                                : null;
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
                              homeScreenController.textEditingController.text =
                                  selection;
                              await dropDownButtonController.languageCode(
                                  homeScreenController.dropDownValue2.value);
                              dropDownButtonController.getLangCode(
                                  homeScreenController.dropDownValue2.value);
                              historyScreenController.addToHistory(
                                  homeScreenController
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
                    'Features',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE64D3D),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text('View all',
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
              height: Get.height * 0.17.h,
              margin: EdgeInsets.only(left: 11, right: 11).r,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                scrollDirection: Axis.horizontal,
                children: [
                  reusableStack1(
                      image: 'assets/translations.png',
                      title: 'Translations',
                      onTap: () {
                        if (homeScreenController.adsHelper.interstitialAd !=
                            null) {
                          homeScreenController.adsHelper.interstitialAd?.show();
                          print('interstitial ad load successfuly');
                        } else {
                          print('interstitial ad not loaded');
                        }
                        Get.to(() => TranslationScreen());
                      }),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  reusableStack1(
                    image: 'assets/favourite.png',
                    title: 'Save Words',
                    onTap: () {
                      Get.to(() => FavouriteScreen());
                      if (homeScreenController.adsHelper.interstitialAd !=
                          null) {
                        homeScreenController.adsHelper.interstitialAd?.show();
                        print('interstitial ad load successfuly');
                      } else {
                        print('interstitial ad not loaded');
                      }
                    },
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  reusableStack1(
                    image: 'assets/share.png',
                    title: 'Share',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 2.w),
        //   child: Column(
        //     //crossAxisAlignment: CrossAxisAlignment.stretch,
        //     children: [
        //       Container(
        //         height: Get.height * 0.075.h,
        //         width: Get.width.w,
        //         //color: Colors.green,
        //         margin: const EdgeInsets.only(
        //           top: 30,
        //           left: 15,
        //           right: 15,
        //         ).r,
        //         child: Row(
        //           //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             IconButton(
        //               onPressed: () {},
        //               icon: Image.asset(
        //                 'assets/drawer.png',
        //                 // height: Get.height * 0.014.h,
        //                 // width: Get.width * 0.07.w,
        //                 height: Get.height * 0.016,
        //                 width: Get.width * 0.08,
        //                 //fit: BoxFit.fill,
        //               ),
        //             ),
        //             // IconButton(
        //             //   onPressed: () {},
        //             //   icon: Image.asset(
        //             //     'assets/Asset 27.png',
        //             //     height: Get.height * 0.03.h,
        //             //     width: Get.width * 0.09.w,
        //             //   ),
        //             // ),
        //           ],
        //         ),
        //       ),
        //       Divider(
        //         height: 0.h,
        //       ),
        //       SizedBox(
        //         height: 18.h,
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: [
        //           Container(
        //             padding: EdgeInsets.only(
        //               left: 30.w,
        //               right: 30.w,
        //             ),
        //             margin: EdgeInsets
        //                 .only(left: 10)
        //                 .r,
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(10.r),
        //               color: Color(0xFFE64D3D),
        //             ),
        //             child: customDropDownButton(
        //               homeScreenController.dropDownValue1,
        //                   (String? newValue) {
        //                 if (newValue != null) {
        //                   homeScreenController.dropDownValue1.value =
        //                       newValue;
        //                   //dropDownButtonController.getLangCode(newValue);
        //                   //String? languageCode = getLanguageCode(newValue);
        //                   // if (languageCode != null) {
        //                   //   homeScreenController.searchContain(
        //                   //       homeScreenController.textEditingController
        //                   //           .text, languageCode);
        //                   // }
        //                 }
        //               },),
        //           ),
        //           customIconButton(() {
        //             String temp = homeScreenController.dropDownValue1.value;
        //             homeScreenController.dropDownValue1.value =
        //                 homeScreenController.dropDownValue2.value;
        //             homeScreenController.dropDownValue2.value = temp;
        //           }, 'assets/swap_arrows.png'),
        //           Container(
        //             padding: EdgeInsets
        //                 .only(
        //               left: 30,
        //               right: 30,
        //             )
        //                 .r,
        //             margin: EdgeInsets.only(right: 10.w),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(10.r),
        //               color: Color(0xFFE64D3D),
        //             ),
        //             child: customDropDownButton(
        //               homeScreenController.dropDownValue2,
        //                   (String? newValue) {
        //                 if (newValue != null) {
        //                   homeScreenController.dropDownValue2.value =
        //                       newValue;
        //                 }
        //               },),
        //           )
        //         ],
        //       ),
        //       SizedBox(
        //         height: 18.h,
        //       ),
        //
        //       Divider(
        //         height: 0.h,
        //       ),
        //       SizedBox(
        //         height: 45.h,
        //       ),
        //       Divider(
        //         height: 0.h,
        //       ),
        //
        //       // Container(
        //       //   height: Get.height * 0.35.h,
        //       //   margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
        //       //   padding: EdgeInsets.all(7),
        //       //   decoration: BoxDecoration(
        //       //     color: Colors.white.withOpacity(0.60),
        //       //     //color: Colors.lightGreenAccent,
        //       //     borderRadius: BorderRadius.circular(20.r),
        //       //     boxShadow: [
        //       //       BoxShadow(
        //       //         color: Colors.grey.withOpacity(0.4),
        //       //         spreadRadius: 5,
        //       //         blurRadius: 7,
        //       //         offset: Offset(1, 3), // changes position of shadow
        //       //       ),
        //       //     ],
        //       //   ),
        //       //   child: Card(
        //       //     elevation: 1,
        //       //     // color: Color(0xFFD3D3D3),
        //       //     color: Color(0xFFEFEFEF),
        //       //     shape: RoundedRectangleBorder(
        //       //       borderRadius: BorderRadius.circular(20.r),
        //       //     ),
        //       //     child: Column(
        //       //       mainAxisAlignment: MainAxisAlignment.start,
        //       //       crossAxisAlignment: CrossAxisAlignment.start,
        //       //       children: [
        //       //         Padding(
        //       //           padding: EdgeInsets.only(left: 25.0.w),
        //       //           child: TextField(
        //       //             decoration: InputDecoration(
        //       //               border: InputBorder.none,
        //       //               hintText: 'Write Something...',
        //       //               suffixIcon: Padding(
        //       //                 padding: EdgeInsets.only(bottom: 50.h),
        //       //                 child: Padding(
        //       //                   padding:
        //       //                       EdgeInsets.only(top: 8.0.h, right: 10.w),
        //       //                   child: IconButton(
        //       //                     onPressed: () {},
        //       //                     icon: const Icon(
        //       //                       Icons.favorite_border,
        //       //                       color: Color(0xFFE64D3D),
        //       //                     ),
        //       //                   ),
        //       //                 ),
        //       //               ),
        //       //             ),
        //       //             controller:
        //       //                 homeScreenController.textEditingController,
        //       //             onChanged: (text) {
        //       //               //homeScreenController.textEditingController;
        //       //               homeScreenController.updateTextField(text);
        //       //               //homeScreenController.searchContain(text, 'ur');
        //       //
        //       //               // if (languageCode != null) {
        //       //               //   homeScreenController.searchContain(
        //       //               //       homeScreenController.textEditingController
        //       //               //           .text, languageCode);
        //       //               // }
        //       //               //dropDownButtonController.getLangCode(dropDownValue2.value);
        //       //             },
        //       //             maxLines: 3,
        //       //           ),
        //       //         ),
        //       //         Row(
        //       //           mainAxisAlignment: MainAxisAlignment.start,
        //       //           children: [
        //       //             customTextButton(
        //       //                 voidcallbaack: () {
        //       //                   homeScreenController.updateTextField('Hope');
        //       //                 },
        //       //                 title: 'Hope',
        //       //                 padding: EdgeInsets.all(0),
        //       //                 margin: EdgeInsets.only(left: 25.w)),
        //       //             customTextButton(
        //       //                 voidcallbaack: () {
        //       //                   homeScreenController
        //       //                       .updateTextField('decision');
        //       //                 },
        //       //                 title: 'Decision',
        //       //                 padding: EdgeInsets.all(0),
        //       //                 margin: EdgeInsets.only(left: 8.w)),
        //       //             customTextButton(
        //       //                 voidcallbaack: () {
        //       //                   homeScreenController
        //       //                       .updateTextField('Satisfaction');
        //       //                 },
        //       //                 title: 'Satisfaction',
        //       //                 padding: EdgeInsets.all(0),
        //       //                 margin: EdgeInsets.only(left: 8.w)),
        //       //           ],
        //       //         ),
        //       //         Row(
        //       //           mainAxisAlignment: MainAxisAlignment.start,
        //       //           children: [
        //       //             customTextButton(
        //       //                 voidcallbaack: () {
        //       //                   homeScreenController.updateTextField('Brave');
        //       //                 },
        //       //                 title: 'Brave',
        //       //                 padding: EdgeInsets.all(0),
        //       //                 margin: EdgeInsets.only(left: 25.w)),
        //       //             customTextButton(
        //       //                 voidcallbaack: () {
        //       //                   homeScreenController.updateTextField('Enhance');
        //       //                 },
        //       //                 title: 'Enhance',
        //       //                 padding: EdgeInsets.all(0),
        //       //                 margin: EdgeInsets.only(left: 8.w)),
        //       //             Expanded(
        //       //               child: Container(
        //       //                 margin: EdgeInsets.only(left: 80.w),
        //       //                 //color: Colors.red,
        //       //                 child: IconButton(
        //       //                   onPressed: () {},
        //       //                   icon: Image.asset(
        //       //                     'assets/speaker.png',
        //       //                     height: Get.height * 0.05.h,
        //       //                     width: Get.width * 0.06.w,
        //       //                     //fit: BoxFit.fill,
        //       //                   ),
        //       //                 ),
        //       //               ),
        //       //             ),
        //       //           ],
        //       //         ),
        //       //       ],
        //       //     ),
        //       //   ),
        //       // ),
        //       Container(
        //         height: Get.height * 0.29.h,
        //         // margin: EdgeInsets.only(top: 40.h),
        //         padding: EdgeInsets
        //             .all(7)
        //             .w,
        //         decoration: BoxDecoration(
        //           //color: Colors.white.withOpacity(0.60),
        //           //color: Color(0xFFD3D3D3)
        //
        //           //color: Colors.red,
        //           //color: Colors.lightGreenAccent,
        //           //borderRadius: BorderRadius.circular(20.r),
        //           // boxShadow: [
        //           //   BoxShadow(
        //           //     color: Colors.grey.withOpacity(0.4),
        //           //     spreadRadius: 5,
        //           //     blurRadius: 7,
        //           //     offset: Offset(1, 3), // changes position of shadow
        //           //   ),
        //           // ],
        //         ),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //
        //   /// Used padding
        //             Padding(
        //               padding: EdgeInsets
        //                   .only(left: 25.0)
        //                   .r,
        //               child:
        //               Obx(() {
        //                 String currentText = homeScreenController
        //                     .currentText.value;
        //                 bool isFavourite = favouriteController
        //                     .favouritesList.contains(currentText);
        //                 bool isTextEmpty = currentText.isEmpty;
        //
        //                 return
        //                   Autocomplete<String>(
        //                     optionsBuilder: (TextEditingValue textEditingValue){
        //                       if(textEditingValue.text.isEmpty){
        //                         return const Iterable.empty();
        //                       }else{
        //                         return suggestions.where((String option){
        //                           return option.contains(textEditingValue.text.toLowerCase());
        //                         });
        //                       }
        //                     },
        //                   fieldViewBuilder: (
        //                       BuildContext context,
        //                       TextEditingController textEditingController,
        //                       FocusNode focusNode,
        //                       VoidCallback onFieldSubmitted,
        //                       ){
        //                       homeScreenController.textEditingController = textEditingController;
        //                       homeScreenController.focusNode = focusNode;
        //                       focusNode.addListener(() {
        //                         homeScreenController.update();  // Trigger rebuild on focus change
        //                       });
        //                       return TextField(
        //                       decoration: InputDecoration(
        //                         border: InputBorder.none,
        //                         hintText: focusNode.hasFocus ? '' : 'Write Something...',
        //                         suffixIcon: Padding(
        //                           padding: EdgeInsets
        //                               .only(bottom: 50)
        //                               .r,
        //                           child: Padding(
        //                             padding: EdgeInsets
        //                                 .only(top: 8.0, right: 10)
        //                                 .r,
        //                             child:
        //                                 ///favoritbutton
        //                             IconButton(
        //                               onPressed: () {
        //                                 if (currentText.isNotEmpty) {
        //                                   if (isFavourite) {
        //                                     favouriteController
        //                                         .deleteFromFavourite(
        //                                         currentText
        //                                     );
        //                                   } else {
        //                                     favouriteController.addToFavourites(
        //                                         currentText);
        //                                   }
        //                                 } else {
        //                                   return;
        //                                 }
        //                               },
        //                               icon: Icon(
        //                                 isFavourite ? Icons.favorite : Icons
        //                                     .favorite_border,
        //                                 color: isFavourite ? Colors.red : Color(
        //                                     0xFFE64D3D),
        //                               ),
        //                               color: isTextEmpty ? Colors.grey : null,
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                       controller:
        //                       //homeScreenController.speechToText.isListening ? '${homeScreenController.lastWords}':
        //                       //homeScreenController.textEditingController,
        //                       textEditingController,
        //                       focusNode: focusNode,
        //                       onChanged: (text) {
        //                         homeScreenController.updateTextField(text);
        //                       },
        //                       maxLines: 3,
        //                     );
        //                   },
        //                   onSelected: (String selection){
        //                       homeScreenController.updateTextField(selection);
        //                       homeScreenController.textEditingController.text= selection;
        //                   },
        //                     );
        //
        //
        //               }),
        //             ),
        //
        //             ///not used padding
        //             // Padding(
        //             //   padding: EdgeInsets.only(left: 25.0).r,
        //             //   child:
        //             //   TextField(
        //             //     decoration: InputDecoration(
        //             //       border: InputBorder.none,
        //             //       hintText: 'Write Something...',
        //             //       suffixIcon: Padding(
        //             //         padding: EdgeInsets.only(bottom: 50).r,
        //             //         child: Padding(
        //             //             padding: EdgeInsets.only(top: 8.0, right: 10).r,
        //             //             child:
        //             //             Obx(() {
        //             //               String currentText = homeScreenController
        //             //                   .textEditingController.text;
        //             //               bool isFavourite = favouriteController
        //             //                   .favouritesList
        //             //                   .contains(homeScreenController
        //             //                       .textEditingController.text);
        //             //               print('isFavourite: $isFavourite, currentText: $currentText');
        //             //               return IconButton(
        //             //                 onPressed: () {
        //             //                   if (currentText.isNotEmpty) {
        //             //                     if (isFavourite) {
        //             //                       favouriteController
        //             //                           .deleteFromFavourite(currentText);
        //             //                     } else {
        //             //                       favouriteController
        //             //                           .addToFavourites(currentText);
        //             //                     }
        //             //                   }
        //             //                 },
        //             //                 icon: Icon(
        //             //                   isFavourite
        //             //                       ? Icons.favorite
        //             //                       : Icons.favorite_border,
        //             //                   color: isFavourite
        //             //                       ? Colors.red
        //             //                       : Color(0xFFE64D3D),
        //             //                 ),
        //             //               );
        //             //             })),
        //             //       ),
        //             //     ),
        //             //     controller: homeScreenController.textEditingController,
        //             //     onChanged: (text) {
        //             //       //homeScreenController.textEditingController;
        //             //       homeScreenController.updateTextField(text);
        //             //       print('controller updated');
        //             //     },
        //             //     maxLines: 3,
        //             //   ),
        //             // ),
        //
        //             // Padding(
        //             //   padding: EdgeInsets.only(left: 25.0).r,
        //             //   child: Stack(
        //             //     alignment: Alignment.centerRight,
        //             //     children: [
        //             //       TextField(
        //             //         decoration: InputDecoration(
        //             //           border: InputBorder.none,
        //             //           hintText: 'Write Something...',
        //             //         ),
        //             //         controller: homeScreenController.textEditingController,
        //             //         onChanged: (text) {
        //             //           homeScreenController.updateTextField(text);
        //             //         },
        //             //         maxLines: 3,
        //             //       ),
        //             //       Padding(
        //             //         padding: EdgeInsets.only(right:30,bottom: 45,).r,
        //             //         child: Obx(() {
        //             //           String currentText = homeScreenController.textEditingController.text;
        //             //           bool isFavourite = favouriteController.favouritesList.contains(homeScreenController.textEditingController.text);
        //             //           print('isFavourite: $isFavourite, currentText: $currentText'); // Debug statement
        //             //
        //             //
        //             //           return IconButton(
        //             //             onPressed: () {
        //             //               if (currentText.isNotEmpty) {
        //             //                 if (isFavourite) {
        //             //                   favouriteController.deleteFromFavourite(currentText);
        //             //                 } else {
        //             //                   favouriteController.addToFavourites(currentText);
        //             //                 }
        //             //               }
        //             //             },
        //             //             icon: Icon(
        //             //               isFavourite ? Icons.favorite : Icons.favorite_border,
        //             //               color: isFavourite ? Colors.red : Color(0xFFE64D3D),
        //             //             ),
        //             //           );
        //             //         }),
        //             //       ),
        //             //     ],
        //             //   ),
        //             // ),
        //
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               children: [
        //                 customTextButton(
        //                   voidcallbaack: () {
        //                     homeScreenController.updateTextField('Hope');
        //                   },
        //                   title: 'Hope',
        //                   padding: EdgeInsets
        //                       .all(0)
        //                       .w,
        //                   margin: EdgeInsets
        //                       .only(left: 25)
        //                       .r,
        //                   color: Colors.white,
        //                 ),
        //                 customTextButton(
        //                   voidcallbaack: () {
        //                     homeScreenController.updateTextField(
        //                         'decision');
        //                   },
        //                   title: 'Decision',
        //                   padding: EdgeInsets
        //                       .all(0)
        //                       .w,
        //                   margin: EdgeInsets
        //                       .only(left: 8)
        //                       .r,
        //                   color: Colors.white,
        //                 ),
        //                 customTextButton(
        //                   voidcallbaack: () {
        //                     homeScreenController
        //                         .updateTextField('Satisfaction');
        //                   },
        //                   title: 'Satisfaction',
        //                   padding: EdgeInsets
        //                       .all(0)
        //                       .w,
        //                   margin: EdgeInsets
        //                       .only(left: 8)
        //                       .r,
        //                   color: Colors.white,
        //                 ),
        //               ],
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               children: [
        //                 customTextButton(
        //                   voidcallbaack: () {
        //                     homeScreenController.updateTextField('Brave');
        //                   },
        //                   title: 'Brave',
        //                   padding: EdgeInsets
        //                       .all(0)
        //                       .w,
        //                   margin: EdgeInsets
        //                       .only(left: 25)
        //                       .r,
        //                   color: Colors.white,
        //                 ),
        //                 customTextButton(
        //                   voidcallbaack: () {
        //                     homeScreenController.updateTextField('Enhance');
        //                   },
        //                   title: 'Enhance',
        //                   padding: EdgeInsets
        //                       .all(0)
        //                       .w,
        //                   margin: EdgeInsets
        //                       .only(left: 8.w)
        //                       .r,
        //                   color: Colors.white,
        //                 ),
        //                 Expanded(
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(left: 100.0).r,
        //                     child: IconButton(
        //                       onPressed: () {
        //                         if (homeScreenController.speechToText
        //                             .isNotListening) {
        //                           homeScreenController.startListening();
        //                           showListeningDialog(context);
        //                         } else {
        //                           homeScreenController.stopListening();
        //                         }
        //                       },
        //                       tooltip: 'Listen',
        //                       icon: Image.asset(
        //                         'assets/speaker.png',
        //                         height: Get.height * 0.05.h,
        //                         width: Get.width * 0.06.w,
        //                         fit: BoxFit.cover,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //       Divider(
        //         height: 0.h,
        //       ),
        //       SizedBox(
        //         height: 15.h,
        //       ),
        //       ElevatedButton(
        //         onPressed: () async {
        //           // final translatedText = await homeScreenController.translateText(
        //           //     homeScreenController.textEditingController.text,
        //           //     dropDownButtonController.languageCode(
        //           //         homeScreenController.dropDownValue2.value));
        //          await dropDownButtonController.languageCode(homeScreenController.dropDownValue2.value);
        //           dropDownButtonController.getLangCode(
        //               homeScreenController.dropDownValue2.value);
        //             historyScreenController.addToHistory(
        //                 homeScreenController.textEditingController.text
        //             );
        //             Get.to(()=>Meaning());
        //
        //         },
        //         style: ButtonStyle(
        //           backgroundColor: MaterialStateProperty.all(
        //             Color(0xFFE64D3D),
        //           ),
        //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //               RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(10.0.r),
        //                 // side: BorderSide(color: Colors.red)
        //               )),
        //         ),
        //         child: const Text(
        //           'Search',
        //           style: TextStyle(
        //               color: Colors.white, fontFamily: 'arial'),
        //         ),
        //       ),
        //   // ElevatedButton(
        //   //   onPressed: () async {
        //   //     dropDownButtonController.languageCode(homeScreenController.dropDownValue2.value);
        //   //     String translatedText = await dropDownButtonController.languageCode(homeScreenController.dropDownValue2.value);
        //   //     dropDownButtonController.getLangCode(
        //   //                homeScreenController.dropDownValue2.value);
        //   //     historyScreenController.addToHistory(homeScreenController.textEditingController.text);
        //   //     Get.to(() => Meaning(translatedText: translatedText));
        //   //   },
        //   //   style: ButtonStyle(
        //   //     backgroundColor: MaterialStateProperty.all(Color(0xFFE64D3D)),
        //   //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //   //       RoundedRectangleBorder(
        //   //         borderRadius: BorderRadius.circular(10.0.r),
        //   //       ),
        //   //     ),
        //   //   ),
        //   //   child: const Text(
        //   //     'Search',
        //   //     style: TextStyle(color: Colors.white, fontFamily: 'arial'),
        //   //   ),
        //   // ),
        //
        //   SizedBox(
        //         height: 15.h,
        //       ),
        //       Container(
        //         height: Get.height * 0.15.h,
        //         //color: Colors.green,
        //         margin: EdgeInsets
        //             .only(left: 20, right: 10)
        //             .r,
        //         child: ListView(
        //           padding: EdgeInsets.symmetric(horizontal: 12.w),
        //           scrollDirection: Axis.horizontal,
        //           children: [
        //             reusableStack(
        //                 title: 'translation',
        //                 image1: 'assets/asset.png',
        //                 image2: 'assets/translation.png',
        //                 padding: EdgeInsets
        //                     .only(top: 8)
        //                     .r,
        //                 padding1: EdgeInsets
        //                     .only(left: 52, bottom: 20)
        //                     .r,
        //                 padding2: EdgeInsets
        //                     .only(
        //                   top: 60.0,
        //                   left: 18,
        //                 )
        //                     .r,
        //                 height: Get.height * 0.1.h,
        //                 width: Get.width * 0.1.w,
        //                 onTap: () {
        //                   if (homeScreenController.adsHelper
        //                       .interstitialAd != null) {
        //                     homeScreenController.adsHelper.interstitialAd
        //                         ?.show();
        //                     print('interstitial ad load successfuly');
        //                   } else {
        //                     print('interstitial ad not loaded');
        //                   }
        //                   Get.to(()=>TranslationScreen());
        //                 }),
        //             reusableStack(
        //                 title: 'History',
        //                 image1: 'assets/asset.png',
        //                 image2: 'assets/history.png',
        //                 padding: EdgeInsets
        //                     .only(left: 10, top: 8, right: 0)
        //                     .r,
        //                 padding1:
        //                 EdgeInsets
        //                     .only(left: 50, bottom: 25, top: 20)
        //                     .r,
        //                 padding2:
        //                 EdgeInsets
        //                     .only(top: 60.0, left: 25, right: 25)
        //                     .r,
        //                 height: Get.height * 0.04.h,
        //                 width: Get.width * 0.1.w,
        //                 onTap: () {
        //                   Get.to(()=>HistoryScreen());
        //                 }),
        //             reusableStack(
        //                 title: 'Collection',
        //                 image1: 'assets/asset.png',
        //                 image2: 'assets/collection.png',
        //                 padding: EdgeInsets
        //                     .only(left: 0, top: 10, right: 10)
        //                     .r,
        //                 padding1:
        //                 EdgeInsets
        //                     .only(left: 50, bottom: 20, top: 20)
        //                     .r,
        //                 padding2:
        //                 EdgeInsets
        //                     .only(top: 60.0, left: 20, right: 20)
        //                     .r,
        //                 height: Get.height * 0.04.h,
        //                 width: Get.width * 0.1.w,
        //                 onTap: () {
        //                   if (homeScreenController.adsHelper
        //                       .interstitialAd != null) {
        //                     homeScreenController.adsHelper.interstitialAd
        //                         ?.show();
        //                     print('interstitial ad load successfuly');
        //                   } else {
        //                     print('interstitial ad not loaded');
        //                   }
        //                 }),
        //             reusableStack(
        //                 title: 'Favorite',
        //                 image1: 'assets/asset.png',
        //                 image2: 'assets/collection.png',
        //                 padding: EdgeInsets
        //                     .only(left: 0, top: 10, right: 10)
        //                     .r,
        //                 padding1:
        //                 EdgeInsets
        //                     .only(left: 50, bottom: 20, top: 20)
        //                     .r,
        //                 padding2:
        //                 EdgeInsets
        //                     .only(top: 60.0, left: 20, right: 20)
        //                     .r,
        //                 height: Get.height * 0.04.h,
        //                 width: Get.width * 0.1.w,
        //                 onTap: () {
        //                   Get.to(()=>FavouriteScreen());
        //                   if (homeScreenController.adsHelper
        //                       .interstitialAd != null) {
        //                     homeScreenController.adsHelper.interstitialAd
        //                         ?.show();
        //                     print('interstitial ad load successfuly');
        //                   } else {
        //                     print('interstitial ad not loaded');
        //                   }
        //                 })
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    ));
  }

  // void showListeningDialog(BuildContext context) {
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
