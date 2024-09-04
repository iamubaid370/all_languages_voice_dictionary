import 'dart:io';

import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_controller.dart';
import 'package:all_languages_voice_dictionary/View/history_screen/historyscreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/meaning_screen/meaning.dart';
import 'package:all_languages_voice_dictionary/widgets/bottom_navigation_bar.dart';
import 'package:all_languages_voice_dictionary/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/dropdownbutton_controller.dart';
import '../../global/global_variables.dart';
import '../home_screen/home_screen.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryScreenController historyScreenController =
      Get.put(HistoryScreenController());

  //HomeScreenController homeScreenController = Get.put(HomeScreenController());

  FavouriteController favouriteController = Get.find<FavouriteController>();

  DropDownButtonController dropDownButtonController =
      Get.find<DropDownButtonController>();

  RxInt currentIndex = 0.obs;

//   @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(currentIndex),
      backgroundColor: Colors.white,
      //Color(0xFFEFEFEF),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              //color: Colors.red,
              height: Get.height * 0.75,
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Color(0xFFE64D3D),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 90.0).r,
                        child:  Text('History'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Color(0xFFE64D3D),
                                fontFamily: 'arial')),
                      )
                    ],
                  ),
                  Obx(() {
                    if (Get.find<HistoryScreenController>()
                        .historyList
                        .isEmpty) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/nodata.gif'),
                            Center(
                                child: Text(
                              "No history available".tr,
                              style: TextStyle(
                                  fontFamily: 'Arial',
                                  color: Colors.grey.shade700,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            )),
                          ],
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: Get.find<HistoryScreenController>()
                            .historyList
                            .length,
                        itemBuilder: (context, index) {
                          final historyTable =
                              Get.find<HistoryScreenController>()
                                  .historyList[index];
                          final bool isFavourite = favouriteController
                              .isFavourite(historyTable.text);

                          print(
                              "MY ID IS THIS: ${historyTable.id} & and Name Is THIS: ${historyTable.text}");
                          print(
                              "_____________________________________________________");

                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.find<HomeScreenController>()
                                      .searchContain(historyTable.text, 'en');
                                  Get.to(() => Meaning());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Card(
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Color(0xFFE64D3D),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        "${historyTable.text}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.grey,
                                            fontFamily: 'arial'),
                                      ),
                                      trailing: Wrap(spacing: -12, children: [
                                        IconButton(
                                          onPressed: () async {
                                            customDialogBox(
                                                title: 'delete'.tr,
                                                content:
                                                    'Are you sure you want to delete?'.tr,
                                                context: context,
                                                voidCallBack: () async {
                                                  if (historyTable.id != null) {
                                                    await Get.find<
                                                            HistoryScreenController>()
                                                        .deleteFromHistory(
                                                            historyTable.id
                                                                as int);
                                                    Get.find<
                                                            HistoryScreenController>()
                                                        .historyList
                                                        .removeWhere((item) =>
                                                            item.id ==
                                                            historyTable.id);
                                                    Get.find<
                                                            HistoryScreenController>()
                                                        .update();
                                                    Get.back();
                                                  }
                                                  //Get.back;
                                                },
                                                voidCallBack2: () {
                                                  Get.back();
                                                });
                                            // if (historyTable.id != null) {
                                            //   await Get.find<HistoryScreenController>()
                                            //       .deleteFromHistory(
                                            //           historyTable.id as int);
                                            //   Get.find<HistoryScreenController>()
                                            //       .historyList
                                            //       .removeWhere((item) =>
                                            //           item.id == historyTable.id);
                                            //   Get.find<HistoryScreenController>()
                                            //       .update();
                                            // }
                                            throw ArgumentError(
                                                'Id Cant be null');
                                          },
                                          icon: const Icon(
                                            Icons.delete_outlined,
                                            color: Color(0xFFE64D3D),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            if (historyTable.text.isNotEmpty) {
                                              if (isFavourite) {
                                                await favouriteController
                                                    .deleteFromFavourite(
                                                        historyTable.text);
                                                setState(() {});
                                                favouriteController.update();
                                              } else {
                                                await favouriteController
                                                    .addToFavourites(
                                                        historyTable.text);
                                                setState(() {});
                                                favouriteController.update();
                                              }
                                            }
                                            ;
                                            setState(() {});
                                          },
                                          icon: Icon(
                                            isFavourite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isFavourite
                                                ? Colors.red
                                                : Color(0xFFE64D3D),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Obx(
                  () {
                bool isAdLoaded = historyScreenController.adsHelper.isBannerAdLoaded.value &&
                    historyScreenController.adsHelper.bannerAd != null &&
                    !GlobalVariable.isAppOpenAdShowing.value &&
                    !GlobalVariable.isInterstitialAdShowing.value;

                return isAdLoaded
                    ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 1.5, // Border width
                    ),
                  ),
                  child: SizedBox(
                    width: Get.width,
                    height: historyScreenController.adsHelper.bannerAd!.size.height
                        .toDouble(),
                    child: AdWidget(ad: historyScreenController.adsHelper.bannerAd!),
                  ),
                )
                    : Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: Get.width,
                    height: 55,
                    color: Colors.grey.shade300,
                    child: Center(
                      child: Text(
                        'Loading ad...', // Optional placeholder text
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
