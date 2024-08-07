
import 'dart:convert';

import 'package:all_languages_voice_dictionary/model/dictionary_model.dart';
import 'package:http/http.dart' as http;

import '../model/dictionary_model.dart';

class ApiServices{

  static String baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en/';
  //late DictionaryModel dictionaryModel;

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

  // static Future<List<String>> getSuggestions(String query)async{
  //   Uri url = Uri.parse('$baseUrl$query');
  //   final response = await http.get(url);
  //   try{
  //     if(response.statusCode == 200){
  //       final data= json.decode(response.body);
  //       //List<String> suggestions = data.map((entry) => entry['word'] as String).toList();
  //       return data.map((json)=>DictionaryModel.fromJson(json)).where((data){
  //         final wordlower = data.word.toLowerCase();
  //         final querylower = query.toLowerCase();
  //
  //         return wordlower.contains(querylower);
  //       }).toList();
  //         //suggestions;
  //     }else{
  //       throw Exception('Not Found');
  //     }
  //   }catch(e){
  //     print(e.toString());
  //     return[];
  //   }
  // }


}