import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_right_scanner/DeviceUtil/const_strings.dart';
import 'package:event_right_scanner/DeviceUtil/preference.dart';
import 'package:event_right_scanner/Models/setting_model.dart';
import 'package:event_right_scanner/api/retrofit_api.dart';
import 'package:event_right_scanner/api/base_model.dart';
import 'package:event_right_scanner/api/network_api.dart';
import 'package:event_right_scanner/api/server_error.dart';

class SettingProvider extends ChangeNotifier {
  bool settingLoader = false;

  Future<BaseModel<SettingModel>> callSetting() async {
    SettingModel response;
    settingLoader = true;
    notifyListeners();
    try {
      response = await RestClient(RetroApi().dioData()).settingRequest();
      if (response.success == true) {
        settingLoader = false;
        SharedPreferenceHelper.setString(ConstString.currencySymbol, response.data!.currency!);
        notifyListeners();
      } else {
        settingLoader = false;
        notifyListeners();
      }
    } catch (error) {
      settingLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  /// Language ///

  Future<String>? get appLocale {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getString(ConstString.currentLanguageCode) ?? 'en';
    });
  }

  Future<void> changeLanguage(String value) {
    // ignore: void_checks
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.setString(ConstString.currentLanguageCode, value);
    });
  }

  Locale _appLocale = const Locale('en');

  Locale get appLocaleChange {
    appLocale?.then((localeValue) {
      _appLocale = Locale(localeValue);
      SharedPreferenceHelper.setString(ConstString.currentLanguageCode, localeValue);
    });

    return _appLocale;
  }

  void updateLanguage(String languageCode) {
    if (languageCode == "es") {
      _appLocale = const Locale("es");
      Fluttertoast.showToast(msg: "Language Changed");
    } else {
      _appLocale = const Locale("en");
      Fluttertoast.showToast(msg: "Language Changed");
    }
    changeLanguage(languageCode);
    notifyListeners();
  }

  @override
  notifyListeners();
}
