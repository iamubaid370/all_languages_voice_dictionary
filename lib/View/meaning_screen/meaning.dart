import 'dart:ui';

import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_controller.dart';
import 'package:all_languages_voice_dictionary/View/history_screen/historyscreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/controller/dropdownbutton_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../model/dictionary_model.dart';
import '../../widgets/dropdown_button.dart';
import '../../widgets/iconbutton.dart';
import '../../widgets/speaker_animation.dart';

class Meaning extends StatelessWidget {
  Meaning({super.key});

  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  DropDownButtonController dropDownButtonController = Get.put(DropDownButtonController());
  HistoryScreenController historyScreenController = Get.find();

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
  // RxString dropDownValue2 = 'Urdu'.obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        homeScreenController.textEditingController.clear();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            //backgroundColor: Color(0xFFEFEFEF),
          backgroundColor: Colors.grey.shade200,
            body: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.34,
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
                        padding: EdgeInsets.symmetric(vertical: Get.height * 0.09,horizontal: Get.width * 0.2),
                        child: Text('ALL LANGUAGES DICTIONARY',
                            style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: Get.height * 0.14),
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
                                      homeScreenController.dropDownValue1.value = newValue;
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
                                      homeScreenController.dropDownValue2.value = newValue;
                                      dropDownButtonController.languageCode(newValue);
                                      dropDownButtonController.getLangCode(newValue);
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
                      //         String currentText = homeScreenController
                      //             .currentText.value;
                      //         // bool isFavourite = favouriteController
                      //         //     .favouritesList.contains(currentText);
                      //         bool isTextEmpty = currentText.isEmpty;
                      //
                      //         return
                      //           Autocomplete<String>(
                      //             optionsBuilder: (TextEditingValue textEditingValue){
                      //               if(textEditingValue.text.isEmpty){
                      //                 return const Iterable.empty();
                      //               }else{
                      //                 return suggestions.where((String option){
                      //                   return option.contains(textEditingValue.text.toLowerCase());
                      //                 });
                      //               }
                      //             },
                      //             fieldViewBuilder: (
                      //                 BuildContext context,
                      //                 TextEditingController textEditingController,
                      //                 FocusNode focusNode,
                      //                 VoidCallback onFieldSubmitted,
                      //                 ){
                      //               homeScreenController.textEditingController = textEditingController;
                      //               homeScreenController.focusNode = focusNode;
                      //               focusNode.addListener(() {
                      //                 homeScreenController.update();  // Trigger rebuild on focus change
                      //               });
                      //               return TextField(
                      //                 decoration: InputDecoration(
                      //                   border: InputBorder.none,
                      //                   hintText: focusNode.hasFocus ? '' : 'Write Something...',
                      //                   suffixIcon:
                      //                   Wrap(
                      //                     children: [
                      //                       // Padding(
                      //                       //   padding: EdgeInsets
                      //                       //       .only(bottom: 50)
                      //                       //       .r,
                      //                       //   child: Padding(
                      //                       //     padding: EdgeInsets
                      //                       //         .only(top: 8.0, right: 10)
                      //                       //         .r,
                      //                       //     child:
                      //                       //     ///favourite-button
                      //                       //     IconButton(
                      //                       //       onPressed: () {
                      //                       //         if (currentText.isNotEmpty) {
                      //                       //           if (isFavourite) {
                      //                       //             favouriteController
                      //                       //                 .deleteFromFavourite(
                      //                       //                 currentText
                      //                       //             );
                      //                       //           } else {
                      //                       //             favouriteController.addToFavourites(
                      //                       //                 currentText);
                      //                       //           }
                      //                       //         } else {
                      //                       //           return;
                      //                       //         }
                      //                       //       },
                      //                       //       icon: Icon(
                      //                       //         isFavourite ? Icons.favorite : Icons
                      //                       //             .favorite_border,
                      //                       //         color: isFavourite ? Colors.red : Color(
                      //                       //             0xFFE64D3D),
                      //                       //       ),
                      //                       //       color: isTextEmpty ? Colors.grey : null,
                      //                       //     ),
                      //                       //   ),
                      //                       // ),
                      //                       IconButton(
                      //                         onPressed: () {
                      //                           if (homeScreenController.speechToText
                      //                               .isNotListening) {
                      //                             homeScreenController.startListening();
                      //                             showListeningDialog(context);
                      //                           } else {
                      //                             homeScreenController.stopListening();
                      //                           }
                      //                         },
                      //                         tooltip: 'Listen',
                      //                         icon: Image.asset(
                      //                           'assets/speaker.png',
                      //                           height: Get.height * 0.035.h,
                      //                           width: Get.width * 0.04.w,
                      //                           fit: BoxFit.cover,
                      //                         ),
                      //                       ),
                      //                       Padding(
                      //                         padding: const EdgeInsets.only(right: 10.0,top: 4),
                      //                         child: IconButton(onPressed: () async {
                      //                           await dropDownButtonController.languageCode(homeScreenController.dropDownValue2.value);
                      //                           dropDownButtonController.getLangCode(
                      //                               homeScreenController.dropDownValue2.value);
                      //                           historyScreenController.addToHistory(
                      //                               homeScreenController.textEditingController.text
                      //                           );
                      //                           homeScreenController.textEditingController.text.isNotEmpty ?
                      //                           Get.to(()=>Meaning()):null;
                      //                         },
                      //                           icon: Image.asset('assets/search.png',
                      //                             height: Get.height * 0.035.h,
                      //                             width: Get.width * 0.07.w,
                      //                             fit: BoxFit.fill,
                      //                           ),),
                      //                       ),
                      //                     ],),
                      //
                      //                 ),
                      //                 controller:
                      //                 //homeScreenController.speechToText.isListening ? '${homeScreenController.lastWords}':
                      //                 //homeScreenController.textEditingController,
                      //                 textEditingController,
                      //                 focusNode: focusNode,
                      //                 onChanged: (text)  {
                      //                   homeScreenController.updateTextField(text);
                      //
                      //                 },
                      //                 maxLines: 3,
                      //               );
                      //             },
                      //             onSelected: (String selection)  async {
                      //               homeScreenController.updateTextField(selection);
                      //               homeScreenController.textEditingController.text= selection;
                      //               await dropDownButtonController.languageCode(homeScreenController.dropDownValue2.value);
                      //               dropDownButtonController.getLangCode(
                      //                   homeScreenController.dropDownValue2.value);
                      //               historyScreenController.addToHistory(
                      //                   homeScreenController.textEditingController.text
                      //               );
                      //               Get.to(()=>Meaning());
                      //             },
                      //           );
                      //
                      //       }),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),),

                ///Row
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Container(
                //       padding: EdgeInsets.only(
                //         left: 30.w,
                //         right: 30.w,
                //       ),
                //       margin: EdgeInsets.only(left: 10).r,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10.r),
                //         color: Color(0xFFE64D3D),
                //       ),
                //       child: customDropDownButton(homeScreenController.dropDownValue1,
                //               (String? newValue) {
                //             if (newValue != null) {
                //               homeScreenController.dropDownValue1.value = newValue;
                //               //dropDownButtonController.getLangCode(newValue);
                //               //String? languageCode = getLanguageCode(newValue);
                //               // if (languageCode != null) {
                //               //   homeScreenController.searchContain(
                //               //       homeScreenController.textEditingController
                //               //           .text, languageCode);
                //               // }
                //             }
                //           },Color(0xFFEFEFEF),),
                //     ),
                //     customIconButton(() {
                //       String temp = homeScreenController.dropDownValue1.value;
                //       homeScreenController.dropDownValue1.value = homeScreenController.dropDownValue2.value;
                //       homeScreenController.dropDownValue2.value = temp;
                //     }, 'assets/swap_arrows.png'),
                //     Container(
                //       padding: EdgeInsets.only(
                //         left: 30,
                //         right: 30,
                //       ).r,
                //       margin: EdgeInsets.only(right: 10.w),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10.r),
                //         color: Color(0xFFE64D3D),
                //       ),
                //       child: customDropDownButton(homeScreenController.dropDownValue2,
                //               (String? newValue) {
                //             if (newValue != null) {
                //               homeScreenController.dropDownValue2.value = newValue;
                //               dropDownButtonController.languageCode(newValue);
                //                dropDownButtonController.getLangCode(newValue);
                //             }
                //           },Color(0xFFEFEFEF)),
                //     )
                //   ],
                // ),

                Obx(() {
                  if (homeScreenController.isLoading.value) {
                    return
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: Get.height * 0.08,),
                          Obx(()=>Text(
                            dropDownButtonController.translatedText.value,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'arial'
                            ),
                          ),),
                            SizedBox(height:30.h),
                            Center(
                            child: CircularProgressIndicator(),
                          )
                        ],
                      );
                  }
                  else if (homeScreenController.dictionaryModel == null) {
                    return Center(
                      child: Container(
                        color: Colors.white,
                        margin:  EdgeInsets.symmetric(vertical:Get.width*0.05 ),
                        padding:  EdgeInsets.symmetric(horizontal:Get.width*0.1),
                        width: Get.width,
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.width*0.03,bottom: Get.width*0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(Get.find<HomeScreenController>()
                                      .textEditingController
                                      .text,style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.grey,
                                      fontFamily: 'arial'
                                  ),),
                                  Obx(()=>Text(
                                    dropDownButtonController.translatedText.value,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'arial'
                                    ),
                                  ),),
                                ],
                              ),
                              Obx((){
                                String currentText = homeScreenController
                                    .currentText.value;
                                bool isFavourite = Get.find<FavouriteController>()
                                    .favouritesList.contains(currentText);
                                bool isTextEmpty = currentText.isEmpty;
                                return IconButton(
                                  onPressed: () {
                                    if (currentText.isNotEmpty) {
                                      if (isFavourite) {
                                        Get.find<FavouriteController>()
                                            .deleteFromFavourite(
                                            currentText
                                        );
                                      } else {
                                        Get.find<FavouriteController>().addToFavourites(
                                            currentText);
                                      }
                                    } else {
                                      return;
                                    }
                                  },
                                  icon: Icon(
                                    isFavourite ? Icons.favorite : Icons
                                        .favorite_border,
                                    color: isFavourite ? Colors.red : Color(
                                        0xFFE64D3D),
                                  ),
                                  color: isTextEmpty ? Colors.grey : null,
                                );

                              }),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  else {
                    return SizedBox(
                      height: Get.height * 0.66.h,
                      child: Column(
                        children: [
                          // Divider(height: 0.h,),
                          Container(
                            margin: EdgeInsets.only(right: 20,top: 10,bottom: 10,left: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(Get.find<HomeScreenController>()
                                        .textEditingController
                                        .text,style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.grey,
                                        fontFamily: 'arial'
                                    ),),
                                    Obx(()=>Text(
                                      dropDownButtonController.translatedText.value,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: 'arial'
                                      ),
                                    ),),
                                  ],
                                ),
                                Obx((){
                                  String currentText = homeScreenController
                                      .currentText.value;
                                  bool isFavourite = Get.find<FavouriteController>()
                                      .favouritesList.contains(currentText);
                                  bool isTextEmpty = currentText.isEmpty;
                                  return IconButton(
                                    onPressed: () {
                                      if (currentText.isNotEmpty) {
                                        if (isFavourite) {
                                          Get.find<FavouriteController>()
                                              .deleteFromFavourite(
                                              currentText
                                          );
                                        } else {
                                          Get.find<FavouriteController>().addToFavourites(
                                              currentText);
                                        }
                                      } else {
                                        return;
                                      }
                                    },
                                    icon: Icon(
                                      isFavourite ? Icons.favorite : Icons
                                          .favorite_border,
                                      color: isFavourite ? Colors.red : Color(
                                          0xFFE64D3D),
                                    ),
                                    color: isTextEmpty ? Colors.grey : null,
                                  );

                                }),
                              ],
                            ),
                          ),
                          // Divider(height: 0.h,),
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                              homeScreenController.dictionaryModel!.meanings.length,
                              itemBuilder: (context, index) {
                                return homeScreenController.showMeaning(
                                    homeScreenController
                                        .dictionaryModel!.meanings[index],);
                              },
                            ),
                          ),


                        ],
                      ),
                    );
                  }
                }),
              ],
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
