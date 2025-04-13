import 'dart:io';
import 'package:eventright_pro_user/model/setting_model.dart';
import 'package:eventright_pro_user/retrofit/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eventright_pro_user/retrofit/apis.dart';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';


void main() {
  test(
    'Check pattern of baseUrl in Apis',
    () {
      // Define the regex pattern for the URL
      var pattern1 = RegExp(r'^https:\/\/.*\/api\/user\/$');
      var pattern2 = RegExp(r'^http:\/\/.*\/api\/user\/$');

      if (kDebugMode) {
        print("Base URL: ${Apis.baseUrl}");
      }
      
      // Check if the baseUrl matches the pattern
      expect(
        ((pattern1.hasMatch(Apis.baseUrl) || pattern2.hasMatch(Apis.baseUrl)) &&
            Apis.baseUrl != "https://_enter_your_base_url_here_/api/user/"),
        isTrue,
        reason: 'The baseUrl does not match the required pattern',
      );
    },
  );

  test(
    'api_client.g.dart file exists',
    () {
      var filePath = 'lib/retrofit/api_client.g.dart';

      // Check if the file exists
      expect(File(filePath).existsSync(), isTrue,
          reason: 'api_client.g.dart file does not exist/\n'
              'Please run the command: flutter pub run build_runner build --delete-conflicting-outputs');
    },
  );

  test(
    'Check if [Apis.setting] endpoint is giving response',
    () async {
      SettingModel response;

      final dio = Dio();
      dio.options.headers["Accept"] = "application/json"; // config your dio headers globally
      dio.options.headers["Content-Type"] = "application/json";
      dio.options.followRedirects = false;
      dio.options.connectTimeout = const Duration(seconds: 30); // 30 seconds
      dio.options.receiveTimeout = const Duration(seconds: 25); // 25 seconds

      if (kDebugMode) {
        print("Calling API: ${Apis.baseUrl}setting");
      }
      response = await RestClient(dio).setting();
      expect(response.success, true, reason: 'The response from ${Apis.setting} is not successful');
    },
  );
}
