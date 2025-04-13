// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:eventright_organizer/constant/pref_constant.dart';
import 'package:eventright_organizer/constant/preferences.dart';

class RetroApi {
  Dio dioData() {
    final dio = Dio();
    dio.options.headers["Accept"] = "application/json"; // config your dio headers globally
    dio.options.headers["Authorization"] = "Bearer ${SharedPreferenceHelper.getString(Preferences.authToken)}"; // config your dio headers globally
    dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    dio.options.followRedirects = false;
    dio.options.connectTimeout = const Duration(milliseconds: 75000); //5s
    dio.options.receiveTimeout = const Duration(milliseconds: 30000);
    return dio;
  }
}
