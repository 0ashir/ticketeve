import 'package:event_right_scanner/Models/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:event_right_scanner/DeviceUtil/const_strings.dart';
import 'package:event_right_scanner/DeviceUtil/preference.dart';
import 'package:event_right_scanner/Screen/Auth/login_screen.dart';
import 'package:event_right_scanner/Screen/Home/home_screen.dart';
import 'package:event_right_scanner/api/retrofit_api.dart';
import 'package:event_right_scanner/api/base_model.dart';
import 'package:event_right_scanner/api/network_api.dart';
import 'package:event_right_scanner/api/server_error.dart';

class AuthProvider extends ChangeNotifier {
  bool authLoader = false;

  Future<BaseModel<AuthModel>> callLogin(body, context) async {
    AuthModel response;
    authLoader = true;
    notifyListeners();
    try {
      response = await RestClient(RetroApi().dioData()).loginRequest(body);
      
      if (response.success == true) {
        authLoader = false;
        SharedPreferenceHelper.setBoolean(ConstString.isLoggedIn, true);
        if (response.data?.token != null) {
          SharedPreferenceHelper.setString(ConstString.authToken, response.data!.token!);
        } else {
          SharedPreferenceHelper.setString(ConstString.authToken, "");
        }
        if (response.data?.name != null) {
          SharedPreferenceHelper.setString(ConstString.name, response.data!.name!);
        } else {
          SharedPreferenceHelper.setString(ConstString.name, "");
        }
        if (response.data?.email != null) {
          SharedPreferenceHelper.setString(ConstString.email, response.data!.email!);
        } else {
          SharedPreferenceHelper.setString(ConstString.email, "");
        }
        if (response.data?.phone != null) {
          SharedPreferenceHelper.setString(ConstString.phone, response.data!.phone!);
        } else {
          SharedPreferenceHelper.setString(ConstString.phone, "");
        }
        if (response.data?.imagePath != null) {
          SharedPreferenceHelper.setString(ConstString.image, response.data!.imagePath!);
        } else {
          SharedPreferenceHelper.setString(ConstString.image, "");
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
        Fluttertoast.showToast(msg: response.msg!);
        notifyListeners();
      } else {
        authLoader = false;
        Fluttertoast.showToast(msg: response.msg!);
        notifyListeners();
      }
    } catch (error) {
      authLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future logoutUser(context) async {
    SharedPreferenceHelper.clearPref();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginScreen(),
      ),
      ModalRoute.withName('SplashScreen'),
    );
  }

  @override
  notifyListeners();
}
