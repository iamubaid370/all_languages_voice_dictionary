String? getLanguageCode(String? language) {
  if (language == null) return null;
  switch (language) {
    case 'English(US)':
      return 'en_US';
    case 'English':
      return 'en_GB';
    case 'French':
      return 'fr';
    case 'German':
      return 'de';
    case 'Italian':
      return 'it';
    case 'Hindi':
      return 'hi';
    case 'Russian':
      return 'ru';
    case 'Spanish':
      return 'es';
    case 'Korean':
      return 'ko';
    case 'Arabic':
      return 'ar';
    case 'Japanese':
      return 'ja';
    case 'Urdu':
      return 'ur';
    case 'Pashto':
      return 'ps';
    case 'Portuguese':
      return 'pt';
    case 'Portuguese (BR)':
      return 'pt_BR';
    case 'Chinese (Simplified)':
      return 'zh_CN';
    case 'Chinese (Traditional)':
      return 'zh_TW';
    case 'Turkish':
      return 'tr';
    case 'Vietnamese':
      return 'vi';
    case 'Thai':
      return 'th';
    case 'Polish':
      return 'pl';
    case 'Dutch':
      return 'nl';
    case 'Swedish':
      return 'sv';
    case 'Danish':
      return 'da';
    case 'Norwegian':
      return 'no';
    case 'Finnish':
      return 'fi';
    case 'Hungarian':
      return 'hu';
    case 'Czech':
      return 'cs';
    case 'Slovak':
      return 'sk';
    case 'Romanian':
      return 'ro';
    case 'Bulgarian':
      return 'bg';
    case 'Greek':
      return 'el';
    case 'Hebrew':
      return 'he';
    case 'Swahili':
      return 'sw';
    case 'Malay':
      return 'ms';
    case 'Indonesian':
      return 'id';
    case 'Serbo-Croatian':
      return 'sh';
    case 'Lithuanian':
      return 'lt';
    case 'Latvian':
      return 'lv';
    case 'Estonian':
      return 'et';
    case 'Icelandic':
      return 'is';
    case 'Irish':
      return 'ga';
    case 'Catalan':
      return 'ca';
    case 'Basque':
      return 'eu';
    case 'Galician':
      return 'gl';
  }
  return null;
}




