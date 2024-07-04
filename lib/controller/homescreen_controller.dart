
import 'package:all_languages_voice_dictionary/model/dictionary_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../services/api_services.dart';

class HomeScreenController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  var textFieldText = ''.obs;
  DictionaryModel? dictionaryModel;
  bool isloading = false;

  void updateTextField(String newText) {
    textFieldText.value = newText;
  }

  searchContain(String word) async {
    try {
      dictionaryModel = await ApiServices.getData(word);
    } catch (e) {
      dictionaryModel = null;
    }
  }


  showMeaning(Meaning meaning) {
    String wordDefination = "";
    // for (var element in meaning.definitions) {
    //   int index = meaning.definitions.indexOf(element);
    //   wordDefination += "\n${index + 1}.${element.definition}\n";
    // }

    for (int index = 0; index < meaning.definitions.length; index++) {
      var element = meaning.definitions[index];
      wordDefination += "\n${index + 1}.${element.definition}\n";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meaning.partOfSpeech,
                style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.blue,
                ),
              ),
               SizedBox(height: 10),
              Text(
                "Definations : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Text(
                wordDefination,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1,
                ),
              ),
              wordRelation("Synonyms", meaning.synonyms),
              wordRelation("Antonyms", meaning.antonyms),

            ],
          ),
        ),
      ),
    );
  }

  wordRelation(String title, List<String>? setList) {
    if (setList?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            setList!.toSet().toString().replaceAll("{", "").replaceAll("}", ""),
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

}