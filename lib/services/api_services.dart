
import 'dart:convert';

import 'package:all_languages_voice_dictionary/model/dictionary_model.dart';
import 'package:http/http.dart' as http;

class ApiServices{

  static String baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en/';

  static Future<DictionaryModel?> getData(String word)async{
    Uri url = Uri.parse('$baseUrl$word');
    final response = await http.get(url);
    try{
      if(response.statusCode == 200){
        final data= json.decode(response.body);
        return DictionaryModel.fromJson(data[0]);
      }else{
        throw Exception('Not Found');
      }
    }catch(e){
      print(e.toString());
    }
  }

}