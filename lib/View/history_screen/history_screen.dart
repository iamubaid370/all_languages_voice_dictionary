import 'dart:io';

import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_controller.dart';
import 'package:all_languages_voice_dictionary/View/history_screen/historyscreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/meaning_screen/meaning.dart';
import 'package:all_languages_voice_dictionary/model/history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../controller/dropdownbutton_controller.dart';
import '../home_screen/home_screen.dart';

class HistoryScreen extends StatelessWidget {



  HistoryScreen({super.key});

//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }
//
// class _HistoryScreenState extends State<HistoryScreen> {
//
//
//   @override
//   void initState() {
//     super.initState();
//     loadAd();
//   }
//
//   NativeAd? nativeAd;
//   bool _nativeAdIsLoaded = false;
//
//   // TODO: replace this test ad unit with your own ad unit.
//   final String _adUnitId = Platform.isAndroid
//       ? 'ca-app-pub-3940256099942544/2247696110'
//       : 'ca-app-pub-3940256099942544/3986624511';
//
//   /// Loads a native ad.
//   void loadAd() {
//     nativeAd = NativeAd(
//         adUnitId: _adUnitId,
//         listener: NativeAdListener(
//           onAdLoaded: (ad) {
//             debugPrint('$NativeAd loaded.');
//             setState(() {
//               _nativeAdIsLoaded = true;
//             });
//           },
//           onAdFailedToLoad: (ad, error) {
//             // Dispose the ad here to free resources.
//             debugPrint('$NativeAd failed to load: $error');
//             ad.dispose();
//           },
//         ),
//         request: const AdRequest(),
//         // Styling
//         nativeTemplateStyle: NativeTemplateStyle(
//           // Required: Choose a template.
//             templateType: TemplateType.medium,
//             // Optional: Customize the ad's style.
//             mainBackgroundColor: Colors.purple,
//             cornerRadius: 10.0,
//             callToActionTextStyle: NativeTemplateTextStyle(
//                 textColor: Colors.cyan,
//                 backgroundColor: Colors.red,
//                 style: NativeTemplateFontStyle.monospace,
//                 size: 16.0),
//             primaryTextStyle: NativeTemplateTextStyle(
//                 textColor: Colors.red,
//                 backgroundColor: Colors.cyan,
//                 style: NativeTemplateFontStyle.italic,
//                 size: 16.0),
//             secondaryTextStyle: NativeTemplateTextStyle(
//                 textColor: Colors.green,
//                 backgroundColor: Colors.black,
//                 style: NativeTemplateFontStyle.bold,
//                 size: 16.0),
//             tertiaryTextStyle: NativeTemplateTextStyle(
//                 textColor: Colors.brown,
//                 backgroundColor: Colors.amber,
//                 style: NativeTemplateFontStyle.normal,
//                 size: 16.0)))
//       ..load();
//   }

  @override
  Widget build(BuildContext context) {

    //HistoryScreenController historyScreenController = Get.put(HistoryScreenController());
    HistoryScreenController historyScreenController = Get.put(HistoryScreenController());
    HomeScreenController homeScreenController = Get.put(HomeScreenController());
    FavouriteController favouriteController = Get.put(FavouriteController());
    DropDownButtonController dropDownButtonController = Get.put(DropDownButtonController());


    return Scaffold(
      bottomNavigationBar: Obx(() {
        return historyScreenController.adsHelper.isNativeAdLoaded.value
            ? ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 320,
            minHeight: 120,
            maxWidth: 400,
            maxHeight: 350,
          ),
          child: AdWidget(ad: historyScreenController.adsHelper.nativeAd!),
        )
            : SizedBox(
          height: 60,
        );

      }),
      backgroundColor: Color(0xFFEFEFEF),
      body:
      // SafeArea(
      //   child: ListView.separated(
      //     padding: EdgeInsets.fromLTRB(12, 0, 12, 30),
      //     itemCount: historyScreenController.historyList.length,
      //     itemBuilder: (context, index) {
      //       final historyTable = historyScreenController.historyList[index];
      //       return  Padding(
      //         padding: const EdgeInsets.all(2.0),
      //         child: Card(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text("${historyTable.id} + ${historyTable.text}"),
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //     separatorBuilder: (context, index) {
      //       return SizedBox(height: 10);
      //     },
      //   ),
      // ),
      SafeArea(
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
                  Get.to(()=>HomeScreen());
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFFE64D3D),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90.0).r,
                child: const Text('History',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Color(0xFFE64D3D),
                        fontFamily: 'arial')),
              )
            ],
          ),
          Obx(() {
            if (historyScreenController.historyList.isEmpty) {
              return Center(child: Text("No history available"));
            }
            return Expanded(
              child: ListView.builder(
              itemCount: historyScreenController.historyList.length,
                itemBuilder: (context, index) {
                  final historyTable = historyScreenController.historyList[index];

                  //final favoriteTable = favouriteController.favouritesList[index];
                  final RxBool isFavourite =favouriteController.favouritesList.
                  any((item) => item.text == historyTable.text).obs;

                  print("MY ID IS THIS: ${historyTable.id} & and Name Is THIS: ${historyTable.text}");
                  print("_____________________________________________________");



                  return Column(
                    children: [

                      GestureDetector(
                        onTap: () {
                          homeScreenController.searchContain(
                              historyTable.text, 'en');
                          Get.to(()=>Meaning());
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
                              title:

                              Text(
                               "${historyTable.text} --- ${historyTable.id} ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontFamily: 'arial'),
                              ),
                              trailing:
                              Wrap(spacing: -12, children: [
                                IconButton(
                                  onPressed: () async {
                                    if( historyTable.id != null){
                                      await historyScreenController.deleteFromHistory(historyTable.id as int);
                                      historyScreenController.historyList.removeWhere(
                                              (item) => item.id == historyTable.id
                                      );
                                      historyScreenController.update();
                                    }throw ArgumentError('Id Cant be null');
                                  },
                                  icon: const Icon(
                                    Icons.delete_outlined,
                                    color: Color(0xFFE64D3D),
                                  ),
                                ),
                                   IconButton(
                                    onPressed: () {
                                      if (historyTable.text.isNotEmpty) {
                                        if (isFavourite.value) {
                                          favouriteController
                                              .deleteFromFavourite(historyTable.text);
                                        } else {
                                          favouriteController
                                              .addToFavourites(historyTable.text);
                                        }
                                        favouriteController.update();
                                      }return null;
                                    },
                                    icon: Icon(
                                      isFavourite.value
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavourite.value
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
      )),
    );
  }


}
