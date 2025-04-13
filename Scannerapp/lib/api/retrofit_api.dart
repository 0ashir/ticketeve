import 'package:dio/dio.dart';
import 'package:event_right_scanner/DeviceUtil/const_strings.dart';
import 'package:event_right_scanner/DeviceUtil/preference.dart';

class RetroApi {
  Dio dioData() {
    final dio = Dio();
    dio.options.headers["Accept"] = "application/json"; // Config your dio headers globally

    dio.options.headers["Authorization"] = "Bearer " "${SharedPreferenceHelper.getString(ConstString.authToken)}";

    dio.options.followRedirects = false;
    dio.options.connectTimeout = const Duration(milliseconds: 75000); //75 seconds
    dio.options.receiveTimeout = const Duration(milliseconds: 75000);
    return dio;
  }
}
