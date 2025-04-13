import 'package:eventright_pro_user/constant/lang_pref.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/localization/language_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String? getTranslated(BuildContext context, String key) {
  return LanguageLocalization.of(context)!.getTranslateValue(key);
}

const String english = "en";
const String spanish = "es";
const String arabic = "ar";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferenceHelperUtils.setString(Preferences.currentLanguageCode, languageCode);
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
    case arabic:
      temp = Locale(languageCode, 'AE');
      break;
    default:
      temp = const Locale(english, 'US');
  }
  return temp;
}

Future<Locale> getLocale() async {
  String languageCode = SharedPreferenceHelperUtils.getString(Preferences.currentLanguageCode)!;
  return _locale(languageCode);
}
