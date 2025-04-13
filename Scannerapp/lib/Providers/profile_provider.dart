import 'package:event_right_scanner/Models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:event_right_scanner/api/retrofit_api.dart';
import 'package:event_right_scanner/api/base_model.dart';
import 'package:event_right_scanner/api/network_api.dart';
import 'package:event_right_scanner/api/server_error.dart';

class ProfileProvider extends ChangeNotifier {
  bool profileLoader = false;

  String image = "";
  String name = "";
  String email = "";
  String phone = "";

  Future<BaseModel<ProfileModel>> callApiProfile() async {
    ProfileModel response;
    profileLoader = true;
    notifyListeners();
    try {
      response = await RestClient(RetroApi().dioData()).profileRequest();
      if (response.success == true) {
        profileLoader = false;
        image = response.data!.imagePath!;
        name = "${response.data!.firstName!} ${response.data!.lastName!}";
        email = response.data!.email!;
        phone = response.data!.phone!;
        notifyListeners();
      } else {
        profileLoader = false;
        notifyListeners();
      }
    } catch (error) {
      profileLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
