import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:eventright_organizer/retrofit/apis.dart';

void main() {
  test(
    'Check pattern of baseUrl in Apis',
    () {
      // Define the regex pattern for the URL
      var pattern1 = RegExp(r'^https:\/\/.*\/api\/organization\/$');
      var pattern2 = RegExp(r'^http:\/\/.*\/api\/organization\/$');

      // Check if the baseUrl matches the pattern
      expect(
        ((pattern1.hasMatch(Apis.baseUrl) || pattern2.hasMatch(Apis.baseUrl)) &&
            Apis.baseUrl != "https://Enter_your_base_url_here/api/organization/"),
        isTrue,
        reason: 'The baseUrl does not match the required pattern or not set yet',
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
}
