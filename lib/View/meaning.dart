
import 'package:all_languages_voice_dictionary/controller/homescreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/dictionary_model.dart';

class Meaning extends StatelessWidget {
   Meaning({super.key});
  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Expanded(child:  ListView.builder(
    itemCount: homeScreenController.dictionaryModel!.meanings.length,
        itemBuilder: (context, index) {
      return homeScreenController.showMeaning(
          homeScreenController.dictionaryModel!.meanings[index]);
    },),);
  }

}
