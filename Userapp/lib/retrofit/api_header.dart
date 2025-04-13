// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';

/// This class is used to set the header for the api call
class RetroApi {
  Dio dioData() {
    final dio = Dio();
    dio.options.headers["Accept"] = "application/json"; // config your dio headers globally
    dio.options.headers["Authorization"] = "Bearer ${SharedPreferenceHelper.getString(Preferences.authToken)}"; // config your dio headers globally
    dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    dio.options.followRedirects = false;
    dio.options.connectTimeout = const Duration(seconds: 30); // 30 seconds
    dio.options.receiveTimeout = const Duration(seconds: 25); // 25 seconds
    return dio;
  }
}
