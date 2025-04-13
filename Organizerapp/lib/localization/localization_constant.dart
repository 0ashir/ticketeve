import 'package:eventright_organizer/constant/pref_constant.dart';
import 'package:eventright_organizer/constant/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'language_localization.dart';

String? getTranslated(BuildContext context, String key) {
  return LanguageLocalization.of(context)!.getTranslateValue(key);
}

const String english = "en";
const String spanish = "es";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferenceHelper.setString(Preferences.currentLanguageCode, languageCode);
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale temp;
  switch (languageCode) {
    case english:
      temp = Locale(languageCode, 'US');
      break;
    case spanish:
      temp = Locale(languageCode, 'ES');
      break;
    default:
      temp = const Locale(english, 'US');
  }
  return temp;
}

Future<Locale> getLocale() async {
  String languageCode = SharedPreferenceHelper.getString(Preferences.currentLanguageCode);
  return _locale(languageCode);
}
