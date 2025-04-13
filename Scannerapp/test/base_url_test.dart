import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:event_right_scanner/api/apis.dart';

void main() {
  test(
    'Check pattern of baseUrl in Apis',
    () {
      // Define the regex pattern for the URL
      var pattern1 = RegExp(r'^https:\/\/.*\/api\/scanner\/$');
      var pattern2 = RegExp(r'^http:\/\/.*\/api\/scanner\/$');

      // Check if the baseUrl matches the pattern
      expect(
        ((pattern1.hasMatch(Apis.baseUrl) || pattern2.hasMatch(Apis.baseUrl)) &&
            Apis.baseUrl != "https://your_base_url_here/api/scanner/"),
        isTrue,
        reason: 'The baseUrl does not match the required pattern or not set yet',
      );
    },
  );

  test(
    'network_api.g.dart file exists',
    () {
      var filePath = 'lib/api/network_api.g.dart';

      // Check if the file exists
      expect(File(filePath).existsSync(), isTrue,
          reason: 'network_api.g.dart file does not exist/\n'
              'Please run the command: flutter pub run build_runner build --delete-conflicting-outputs');
    },
  );
}
