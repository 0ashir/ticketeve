import 'package:eventright_organizer/model/scanner_model.dart';
import 'package:eventright_organizer/retrofit/api_client.dart';
import 'package:eventright_organizer/retrofit/api_header.dart';
import 'package:eventright_organizer/retrofit/base_model.dart';
import 'package:eventright_organizer/retrofit/error_handler.dart';
import 'package:flutter/cupertino.dart';

class ScannerProvider extends ChangeNotifier {
  /// call api for scanners ///

  List<ScannerData> scanners = [];

  Future<BaseModel<ScannerModel>> callApiForScanner() async {
    ScannerModel response;

    try {
      scanners.clear();
      response = await RestClient(
        RetroApi().dioData(),
      ).scanners();
      if (response.success == true) {
        scanners.addAll(response.data!);
        notifyListeners();
      }
    } catch (error) {
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }
}
