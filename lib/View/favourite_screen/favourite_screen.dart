import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_controller.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/home_screen.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/translation_screen/translation.dart';
import 'package:all_languages_voice_dictionary/View/translation_screen/translationscreen_controller.dart';
import 'package:all_languages_voice_dictionary/controller/dropdownbutton_controller.dart';
import 'package:all_languages_voice_dictionary/View/meaning_screen/meaning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});

  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  FavouriteController favouriteController = Get.put(FavouriteController());
  TranslationScreenController translationScreenController =
      Get.put(TranslationScreenController());
  DropDownButtonController dropDownButtonController =
      Get.put(DropDownButtonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Get.to(HomeScreen());
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xFFE64D3D),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 90.0).r,
                  child: const Text('Favourites',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Color(0xFFE64D3D),
                          fontFamily: 'arial')),
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Obx(() {
              return Expanded(
                child: ListView.builder(
                  itemCount: favouriteController.favouritesList.length,
                  itemBuilder: (context, index) {
                    final favoriteTable =
                        favouriteController.favouritesList[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            List<String> words =
                                favoriteTable.text.split(RegExp(r'\s+'));

                            if (words.length == 1) {
                              homeScreenController.searchContain(
                                  //favouriteController.favouritesList[index],
                                  favoriteTable.text,
                                  'en');
                              Get.to(() => Meaning());
                            } else {
                              String translatedText =
                                  await translationScreenController
                                      .translateText(favoriteTable.text);
                              translationScreenController.translatedText.value =
                                  translatedText;
                              Get.to(TranslationScreen());
                            }
                          },
                          child: SizedBox(
                            height: Get.height * 0.1,
                            child: Card(
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Color(0xFFE64D3D),
                                  width: 0.5,
                                ),
                              ),
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                    //favouriteController.favouritesList[index],
                                    favoriteTable.text,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.grey,
                                        fontFamily: 'arial'),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        favouriteController.deleteFromFavourite(
                                            //favouriteController.favouritesList[index]
                                            favoriteTable.text);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Color(0xFFE64D3D),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
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
    );
  }
}
