import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/model/change_password_model.dart';
import 'package:eventright_pro_user/model/forgot_password_model.dart';
import 'package:eventright_pro_user/model/login_model.dart';
import 'package:eventright_pro_user/model/register_model.dart';
import 'package:eventright_pro_user/retrofit/api_client.dart';
import 'package:eventright_pro_user/retrofit/api_header.dart';
import 'package:eventright_pro_user/retrofit/base_model.dart';
import 'package:eventright_pro_user/retrofit/server_error.dart';
import 'package:eventright_pro_user/screens/auth/otp_verification_screen.dart';
import 'package:eventright_pro_user/screens/auth/signin_screen.dart';
import 'package:eventright_pro_user/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  /// call api for login ///

  bool _loginLoader = false;

  bool get loginLoader => _loginLoader;

  Future<BaseModel<LoginModel>> callApiForLogin(body, context) async {
    LoginModel response;
    _loginLoader = true;
    notifyListeners();

    try {
      response = await RestClient(RetroApi().dioData()).login(body);
      if (response.success == true) {
        if (response.data!.isVerify == 1 || response.data!.isVerify == null) {
          SharedPreferenceHelper.setString(
              Preferences.authToken, response.data!.token!);
          SharedPreferenceHelper.setString(
              Preferences.email, response.data!.email!);
          SharedPreferenceHelper.setString(
              Preferences.fName, response.data!.name!);
          SharedPreferenceHelper.setString(
              Preferences.lName, response.data!.lastName!);
          SharedPreferenceHelper.setString(Preferences.image,
              response.data!.imagePath! + response.data!.image!);
          SharedPreferenceHelper.setString(
              Preferences.phoneNo, response.data!.phone!);

          SharedPreferenceHelper.setBoolean(Preferences.isLoggedIn, true);
          if (response.msg != null) CommonFunction.toastMessage(response.msg!);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
          notifyListeners();
        } else if (response.data!.isVerify == 0) {
          if (response.msg != null) CommonFunction.toastMessage(response.msg!);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpVerificationScreen(
                  email: response.data!.email ?? "",
                  id: response.data!.id.toString(),
                  otp: response.data!.otp ?? ""),
            ),
          );
        }
      } else {
        _loginLoader = false;
        notifyListeners();
        if (response.msg != null) CommonFunction.toastMessage(response.msg!);
      }
      _loginLoader = false;
      notifyListeners();
    } catch (error) {
      _loginLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for register ///

  bool _registerLoader = false;

  bool get registerLoader => _registerLoader;

  Future<BaseModel<RegisterModel>> callApiForRegister(
      body, BuildContext context) async {
    RegisterModel response;

    try {
      _registerLoader = true;
      notifyListeners();
      response = await RestClient(RetroApi().dioData()).register(body);
      if (response.success == true) {
        _registerLoader = false;
        if (response.data!.isVerify == 1 || response.data!.isVerify == null) {
          if (response.msg != null) CommonFunction.toastMessage(response.msg!);
          if (context.mounted) Navigator.pop(context);
        } else if (response.data!.isVerify == 0) {
          if (response.msg != null) CommonFunction.toastMessage(response.msg!);
          if (context.mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OtpVerificationScreen(
                    email: response.data!.email ?? "",
                    id: response.data!.id.toString(),
                    otp: response.data!.otp ?? ""),
              ),
            );
          }
        }

        notifyListeners();
      } else if (response.success == false) {
        if (response.msg != null) CommonFunction.toastMessage(response.msg!);
      }
      _registerLoader = false;
      notifyListeners();
    } catch (error) {
      _registerLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for change password ///

  bool _changePasswordLoader = false;

  bool get changePasswordLoader => _changePasswordLoader;

  Future<BaseModel<ChangePasswordModel>> callApiForChangePassword(body) async {
    ChangePasswordModel response;
    _changePasswordLoader = true;
    notifyListeners();

    try {
      response = await RestClient(RetroApi().dioData()).changePassword(body);
      if (response.success == true) {
        _changePasswordLoader = false;
        notifyListeners();
        if (response.msg != null) {
          CommonFunction.toastMessage(response.msg!);
        }
        notifyListeners();
      }
    } catch (error) {
      _changePasswordLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  ///call api for forgotPassword
  Future<BaseModel<ForgotPasswordModel>> callForgotPassword(
      Map<String, String> body) async {
    ForgotPasswordModel response;
    _loginLoader = true;
    notifyListeners();

    try {
      response = await RestClient(RetroApi().dioData()).forgotPassword(body);
      if (response.success == true) {
        _loginLoader = false;
        if (response.msg != null) {
          CommonFunction.toastMessage(response.msg!);
        }
        notifyListeners();
      } else {
        _loginLoader = false;
        notifyListeners();
        if (response.msg != null) {
          CommonFunction.toastMessage(response.msg!);
        }
      }
    } catch (error) {
      _loginLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  Future<BaseModel<LoginModel>> callApiVerify(body, context) async {
    LoginModel response;
    _loginLoader = true;
    notifyListeners();

    try {
      response = await RestClient(RetroApi().dioData()).callVerifyOtp(body);
      if (response.success == true) {
        if (response.msg != null) CommonFunction.toastMessage(response.msg!);
        _loginLoader = false;
        notifyListeners();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        notifyListeners();
      } else if (response.success == false) {
        _loginLoader = false;
        notifyListeners();
        if (response.msg != null) CommonFunction.toastMessage(response.msg!);
      }
    } catch (error) {
      _loginLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }
}
