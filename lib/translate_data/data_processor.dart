import 'package:flutter_translate/flutter_translate.dart';

class DataProcessor {
  Future<String> translateData(String data, String targetLocale) async {
    try {
      var translation = await Translator.translate(
        data,
        from: 'auto',  // Detect source language automatically
        to: targetLocale,
      );
      return translation.text;
    } catch (e) {
      print('Translation error: $e');
      return data;  // Return original data if translation fails
    }
  }
}
