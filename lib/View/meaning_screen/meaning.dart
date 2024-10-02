import 'dart:ui';

import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_controller.dart';
import 'package:all_languages_voice_dictionary/View/history_screen/historyscreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/meaning_screen/meaningscreen_controller.dart';
import 'package:all_languages_voice_dictionary/controller/dropdownbutton_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../global/global_variables.dart';
import '../../model/dictionary_model.dart';
import '../../widgets/dropdown_button.dart';
import '../../widgets/iconbutton.dart';
import '../../widgets/speaker_animation.dart';

class Meaning extends StatefulWidget {
  Meaning({super.key});

  @override
  State<Meaning> createState() => _MeaningState();
}

class _MeaningState extends State<Meaning> {
  HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  DropDownButtonController dropDownButtonController =
      Get.find<DropDownButtonController>();

  HistoryScreenController historyScreenController = Get.find();
  MeaningScreenController meaningScreenController =
      Get.put(MeaningScreenController());
  FavouriteController favouriteController = Get.find<FavouriteController>();


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

  // RxString dropDownValue1 = 'English'.obs;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        homeScreenController.textEditingController.clear();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          //backgroundColor: Color(0xFFEFEFEF),
          backgroundColor: Colors.grey.shade200,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.342,
                  child: Stack(
                    children: [
                      Container(
                        height: Get.height * 0.34,
                        width: Get.width,
                        // color: Color(0xFFE64D3D),
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
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.09,
                            horizontal: Get.width * 0.2),
                        child: Text('ALL LANGUAGES DICTIONARY'.tr,
                            style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.14),
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
                                homeScreenController.dropDownValue2.value =
                                    temp;
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
                                  dropDownButtonController
                                      .languageCode(newValue);
                                  dropDownButtonController
                                      .getLangCode(newValue);
                                }
                              }, Color(0xFFFFFFFF), Color(0xFFE64D3D)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: Get.height * 0.23,
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
                                                    .speechToText.isNotListening) {
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
                                              height: Get.height * 0.055.h,
                                              width: Get.width * 0.055.w,
                                              fit: BoxFit.contain,
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
                                                        .dropDownValue2.value);
                                                dropDownButtonController
                                                    .getLangCode(
                                                    homeScreenController
                                                        .dropDownValue2.value);
                                                if (homeScreenController
                                                    .textEditingController
                                                    .text
                                                    .isNotEmpty) {
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
                                                    ? Get.offNamed('/meaning')
                                                    : null;
                                              },
                                              icon: Image.asset(
                                                'assets/search.png',
                                                height: Get.height * 0.055.h,
                                                width: Get.width * 0.055.w,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    controller: textEditingController,
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
                                  Get.find<HistoryScreenController>().addToHistory(
                                      homeScreenController
                                          .textEditingController.text);
                                  Get.offNamed('/meaning');
                                },
                              );
                            }),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.54,
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(() {
                          if (homeScreenController.isLoading.value) {
                            return Container(
                              height: Get.height * 0.35,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.07,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Word:  ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontFamily: 'arial',
                                          ),
                                        ),
                                        TextSpan(
                                          text: Get.find<HomeScreenController>()
                                              .currentText
                                              .value,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.grey,
                                            fontFamily: 'arial',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(
                                    () => RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Meaning:  ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontFamily: 'arial',
                                            ),
                                          ),
                                          TextSpan(
                                            text: dropDownButtonController
                                                .translatedText.value,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontFamily: 'arial',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            );
                          }
                          else if (homeScreenController.dictionaryModel ==
                              null) {
                            return Center(
                              child: Container(
                                height: Get.height * 0.4,
                                //color: Colors.blue,
                                margin: EdgeInsets.only(
                                    top: Get.width * 0.1,
                                    bottom: Get.width * 0.2),
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.1),
                                width: Get.width,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: Get.width * 0.03,
                                      bottom: Get.width * 0.03),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Word:  ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: 'arial',
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: Get.find<
                                                          HomeScreenController>()
                                                      .currentText
                                                      .value,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    color: Colors.grey,
                                                    fontFamily: 'arial',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Obx(
                                            () => RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Meaning:  ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontFamily: 'arial',
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        dropDownButtonController
                                                            .translatedText
                                                            .value,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontFamily: 'arial',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: Get.height * 0.5,
                              child: Column(
                                children: [
                                  // Divider(height: 0.h,),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 20,
                                        top: 10,
                                        bottom: 0,
                                        left: 40),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Word:  ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontFamily: 'arial',
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: Get.find<
                                                            HomeScreenController>()
                                                        .currentText
                                                        .value,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontFamily: 'arial',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (homeScreenController
                                                    .dictionaryModel!
                                                    .phonetics !=
                                                null)
                                              ...homeScreenController
                                                  .dictionaryModel!.phonetics!
                                                  .map((phonetic) {
                                                return Text(
                                                  phonetic.text ?? '',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                      fontFamily: 'arial'),
                                                );
                                              }).toList(),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  const TextSpan(
                                                    text: ' Meaning:  ',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontFamily: 'arial',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: homeScreenController.dictionaryModel !=
                                                        null ?homeScreenController
                                                        .dictionaryModel!.word : dropDownButtonController
                                                        .translatedText.value,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                      fontFamily: 'arial',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        // Obx((){
                                        //   String currentText = homeScreenController
                                        //       .currentText.value;
                                        //   bool isFavourite = Get.find<FavouriteController>()
                                        //       .favouritesList.contains(currentText);
                                        //   bool isTextEmpty = currentText.isEmpty;
                                        //   return IconButton(
                                        //     onPressed: () async {
                                        //       if (currentText.isNotEmpty) {
                                        //         if (isFavourite) {
                                        //           await Get.find<FavouriteController>()
                                        //               .deleteFromFavourite(
                                        //               currentText
                                        //           );
                                        //           // setState(() {
                                        //           //
                                        //           // });
                                        //           //Get.find<FavouriteController>().update();
                                        //         } else {
                                        //          await Get.find<FavouriteController>().addToFavourites(
                                        //               currentText);
                                        //          // setState(() {
                                        //          //
                                        //          // });
                                        //          //Get.find<FavouriteController>().update();
                                        //         }
                                        //       }
                                        //     },
                                        //     icon: Icon(
                                        //       isFavourite ? Icons.favorite : Icons
                                        //           .favorite_border,
                                        //       color: isFavourite ? Colors.red : Color(
                                        //           0xFFE64D3D),
                                        //     ),
                                        //     color: isTextEmpty ? Colors.grey : null,
                                        //   );
                                        //
                                        // }),
                                      ],
                                    ),
                                  ),
                                  // Divider(height: 0.h,),

                                  ///Expanded
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: homeScreenController
                                          .dictionaryModel!.meanings.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            homeScreenController.showMeaning(
                                              homeScreenController
                                                  .dictionaryModel!
                                                  .meanings[index],
                                            ),
                                            if (homeScreenController
                                                    .dictionaryModel!
                                                    .meanings![index]
                                                    .definitions![0]
                                                    .example !=
                                                null)
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Get.width * 0.1),
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontFamily: 'arial',
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: 'Example:   ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize:
                                                                14 // Custom style for the label
                                                            ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            homeScreenController
                                                                .dictionaryModel!
                                                                .meanings![
                                                                    index]
                                                                .definitions![0]
                                                                .example!,
                                                        style: TextStyle(
                                                          fontFamily: 'Arial',
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Obx(
            () => (meaningScreenController.adsHelper.isBannerAdLoaded.value &&
                    meaningScreenController.adsHelper.bannerAd != null &&
                    !GlobalVariable.isAppOpenAdShowing.value &&
                    !GlobalVariable.isInterstitialAdShowing.value)
                ? Container(
                    child: SizedBox(
                      width: Get.width,
                      height: meaningScreenController
                          .adsHelper.bannerAd!.size.height
                          .toDouble(),
                      child: AdWidget(
                          ad: meaningScreenController.adsHelper.bannerAd!),
                    ),
                  )
                : const SizedBox(
                    height: 55,
                  ),
          ),
        ),
      ),
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

///new
// import 'dart:ui';
// import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_controller.dart';
// import 'package:all_languages_voice_dictionary/View/history_screen/historyscreen_controller.dart';
// import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
// import 'package:all_languages_voice_dictionary/controller/dropdownbutton_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../model/dictionary_model.dart';
// import '../../widgets/dropdown_button.dart';
// import '../../widgets/iconbutton.dart';
// import '../../widgets/speaker_animation.dart';
//
// class Meaning extends StatelessWidget {
//   Meaning({super.key});
//
//   HomeScreenController homeScreenController = Get.put(HomeScreenController());
//   DropDownButtonController dropDownButtonController = Get.put(DropDownButtonController());
//   HistoryScreenController historyScreenController = Get.find();
//
//   List<String> suggestions = [
//     'apple', 'banana', 'cherry', 'date', 'elderberry', 'fig', 'grape', 'honeydew', 'orange', 'queen', 'kingdom', 'viking',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         homeScreenController.textEditingController.clear();
//         return true;
//       },
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.grey.shade200,
//           body: Column(
//             children: [
//               SizedBox(
//                 height: Get.height * 0.34,
//                 child: Stack(
//                   children: [
//                     Container(
//                       height: Get.height * 0.34,
//                       width: Get.width,
//                       decoration: BoxDecoration(
//                         color: Color(0xFFE64D3D),
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(15),
//                           bottomRight: Radius.circular(15.0),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 12.0, top: Get.height * 0.03),
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: Image.asset(
//                           'assets/drawer.png',
//                           height: Get.height * 0.016,
//                           width: Get.width * 0.08,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: Get.height * 0.09, horizontal: Get.width * 0.2),
//                       child: Text('ALL LANGUAGES DICTIONARY',
//                           style: TextStyle(
//                               fontFamily: 'Arial',
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white)),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: Get.height * 0.14),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.only(left: 30.w, right: 30.w),
//                             margin: EdgeInsets.only(left: 10).r,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.r),
//                               color: Color(0xFFEFEFEF),
//                             ),
//                             child: customDropDownButton(
//                               homeScreenController.dropDownValue1,
//                                   (String? newValue) {
//                                 if (newValue != null) {
//                                   homeScreenController.dropDownValue1.value = newValue;
//                                 }
//                               },
//                               Color(0xFFEFEFEF),
//                             ),
//                           ),
//                           customIconButton(
//                                 () {
//                               String temp = homeScreenController.dropDownValue1.value;
//                               homeScreenController.dropDownValue1.value = homeScreenController.dropDownValue2.value;
//                               homeScreenController.dropDownValue2.value = temp;
//                             },
//                             'assets/swap_arrows.png',
//                           ),
//                           Container(
//                             padding: EdgeInsets.only(left: 30, right: 30).r,
//                             margin: EdgeInsets.only(right: 10.w),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.r),
//                               color: Color(0xFFEFEFEF),
//                             ),
//                             child: customDropDownButton(
//                               homeScreenController.dropDownValue2,
//                                   (String? newValue) {
//                                 if (newValue != null) {
//                                   homeScreenController.dropDownValue2.value = newValue;
//                                   dropDownButtonController.languageCode(newValue);
//                                   dropDownButtonController.getLangCode(newValue);
//                                 }
//                               },
//                               Color(0xFFFFFFFF),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Obx(() {
//                 if (homeScreenController.isLoading.value) {
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(height: Get.height * 0.08),
//                       Obx(() => Text(
//                         dropDownButtonController.translatedText.value,
//                         style: const TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontFamily: 'arial'
//                         ),
//                       )),
//                       SizedBox(height: 30.h),
//                       Center(child: CircularProgressIndicator()),
//                     ],
//                   );
//                 } else if (homeScreenController.dictionaryModel == null) {
//                   return Center(
//                     child: Container(
//                       color: Colors.white,
//                       margin: EdgeInsets.symmetric(vertical: Get.width * 0.05),
//                       padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
//                       width: Get.width,
//                       child: Padding(
//                         padding: EdgeInsets.only(top: Get.width * 0.03, bottom: Get.width * 0.03),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   Get.find<HomeScreenController>().textEditingController.text,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 22,
//                                       color: Colors.grey,
//                                       fontFamily: 'arial'
//                                   ),
//                                 ),
//                                 Obx(() => Text(
//                                   dropDownButtonController.translatedText.value,
//                                   style: const TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.black,
//                                       fontFamily: 'arial'
//                                   ),
//                                 )),
//                               ],
//                             ),
//                             Obx(() {
//                               String currentText = homeScreenController.currentText.value;
//                               bool isFavourite = Get.find<FavouriteController>().favouritesList.contains(currentText);
//                               bool isTextEmpty = currentText.isEmpty;
//                               return IconButton(
//                                 onPressed: () {
//                                   if (currentText.isNotEmpty) {
//                                     if (isFavourite) {
//                                       Get.find<FavouriteController>().deleteFromFavourite(currentText);
//                                     } else {
//                                       Get.find<FavouriteController>().addToFavourites(currentText);
//                                     }
//                                   } else {
//                                     return;
//                                   }
//                                 },
//                                 icon: Icon(
//                                   isFavourite ? Icons.favorite : Icons.favorite_border,
//                                   color: isFavourite ? Colors.red : Color(0xFFE64D3D),
//                                 ),
//                                 color: isTextEmpty ? Colors.grey : null,
//                               );
//                             }),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 } else {
//                   return SizedBox(
//                     height: Get.height * 0.66.h,
//                     child: Column(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(right: 20, top: 10, bottom: 10, left: 40),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     Get.find<HomeScreenController>().textEditingController.text,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 22,
//                                         color: Colors.grey,
//                                         fontFamily: 'arial'
//                                     ),
//                                   ),
//                                   Obx(() => Text(
//                                     dropDownButtonController.translatedText.value,
//                                     style: const TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.black,
//                                         fontFamily: 'arial'
//                                     ),
//                                   )),
//                                   // Display phonetics here
//                                   if (homeScreenController.dictionaryModel!.phonetics != null)
//                                     ...homeScreenController.dictionaryModel!.phonetics!.map((phonetic) {
//                                       return Text(
//                                         phonetic.text ?? '',
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             color: Colors.blueGrey,
//                                             fontFamily: 'arial'
//                                         ),
//                                       );
//                                     }).toList(),
//                                 ],
//                               ),
//                               Obx(() {
//                                 String currentText = homeScreenController.currentText.value;
//                                 bool isFavourite = Get.find<FavouriteController>().favouritesList.contains(currentText);
//                                 bool isTextEmpty = currentText.isEmpty;
//                                 return IconButton(
//                                   onPressed: () {
//                                     if (currentText.isNotEmpty) {
//                                       if (isFavourite) {
//                                         Get.find<FavouriteController>().deleteFromFavourite(currentText);
//                                       } else {
//                                         Get.find<FavouriteController>().addToFavourites(currentText);
//                                       }
//                                     } else {
//                                       return;
//                                     }
//                                   },
//                                   icon: Icon(
//                                     isFavourite ? Icons.favorite : Icons.favorite_border,
//                                     color: isFavourite ? Colors.red : Color(0xFFE64D3D),
//                                   ),
//                                   color: isTextEmpty ? Colors.grey : null,
//                                 );
//                               }),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.53.h,
//                           child: ListView.builder(
//                             itemCount: homeScreenController.dictionaryModel!.meanings!.length,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 margin: EdgeInsets.only(right: 20, top: 10, bottom: 10, left: 40),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             homeScreenController.dictionaryModel!.meanings![index].partOfSpeech!,
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18,
//                                                 color: Colors.grey,
//                                                 fontFamily: 'arial'
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: Get.height * 0.01,
//                                           ),
//                                           Text(
//                                             homeScreenController.dictionaryModel!.meanings![index].definitions![0].definition!,
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.black,
//                                                 fontFamily: 'arial'
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: Get.height * 0.01,
//                                           ),
//                                           if (homeScreenController.dictionaryModel!.meanings![index].definitions![0].example != null)
//                                             Text(
//                                               'Example: ${homeScreenController.dictionaryModel!.meanings![index].definitions![0].example!}',
//                                               style: TextStyle(
//                                                   fontSize: 14,
//                                                   color: Colors.grey,
//                                                   fontFamily: 'arial'
//                                               ),
//                                             ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
