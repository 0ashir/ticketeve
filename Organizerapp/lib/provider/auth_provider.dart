import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:eventright_organizer/constant/common_function.dart';
import 'package:eventright_organizer/constant/pref_constant.dart';
import 'package:eventright_organizer/constant/preferences.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/model/edit_profile_image_model.dart';
import 'package:eventright_organizer/model/edit_profile_model.dart';
import 'package:eventright_organizer/model/forgot_password_model.dart';
import 'package:eventright_organizer/model/login_model.dart';
import 'package:eventright_organizer/model/register_model.dart';
import 'package:eventright_organizer/retrofit/api_client.dart';
import 'package:eventright_organizer/retrofit/api_header.dart';
import 'package:eventright_organizer/retrofit/base_model.dart';
import 'package:eventright_organizer/retrofit/error_handler.dart';
import 'package:eventright_organizer/screens/auth/otp_verification_screen.dart';
import 'package:eventright_organizer/screens/auth/sign_in_screen.dart';
import 'package:eventright_organizer/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  /// call api for login ///

  bool _loginLoader = false;

  bool get loginLoader => _loginLoader;

  Future<BaseModel<LoginModel>> callApiForLogin(body, context) async {
    LoginModel response;
    _loginLoader = true;
    notifyListeners();

    try {
      print('calling api');
      response = await RestClient(RetroApi().dioData()).login(body);
      print('got response as  $response');
      if (response.success = true) {
        if (response.data!.isVerify == 1 || response.data!.isVerify == null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
          SharedPreferenceHelper.setBoolean(Preferences.isLoggedIn, true);
          SharedPreferenceHelper.setString(
              Preferences.authToken, response.data!.token!);
          SharedPreferenceHelper.setString(
              Preferences.email, response.data!.email!);
          SharedPreferenceHelper.setString(
              Preferences.firstName, response.data!.firstName!);
          SharedPreferenceHelper.setString(
              Preferences.lastName, response.data!.lastName!);
          SharedPreferenceHelper.setString(
              Preferences.phoneNo, response.data!.phone!);
          SharedPreferenceHelper.setString(
              Preferences.bio, response.data!.bio ?? "");
          SharedPreferenceHelper.setString(
              Preferences.image, response.data!.imagePath!);
        } else if (response.data!.isVerify == 0) {
          debugPrint('OTP ${response.data!.otp}');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpVerificationScreen(
                  email: response.data!.email ?? "",
                  id: response.data!.id.toString(),
                  otp: response.data!.otp ?? ""),
            ),
          );
        }

        if (response.msg != null) CommonFunction.toastMessage(response.msg!);
        notifyListeners();
      } else if (response.success == false) {
        if (response.msg != null) CommonFunction.toastMessage(response.msg!);
      }
      _loginLoader = false;
      notifyListeners();
    } catch (error) {
      _loginLoader = false;
      notifyListeners();
      return BaseModel()..setException(ErrorClass.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for register ///

  bool _registerLoader = false;

  bool get registerLoader => _registerLoader;

  Future<BaseModel<RegisterModel>> callApiForRegister(body, context) async {
    RegisterModel response;
    _registerLoader = true;
    notifyListeners();
    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).register(body);
      if (response.success == true) {
        if (response.data!.isVerify == 1 || response.data!.isVerify == null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ));
          if (response.msg != null) CommonFunction.toastMessage(response.msg!);
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
        log('GOT RESPONSE $response');
      }
      _registerLoader = false;
      notifyListeners();
    } catch (error) {
      _registerLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for forgot password ///

  bool _forgotLoader = false;

  bool get forgotLoader => _forgotLoader;

  Future<BaseModel<ForgotPasswordModel>> callApiForForgotPassword(
      body, context) async {
    ForgotPasswordModel response;
    _forgotLoader = true;
    notifyListeners();

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).forgotPassword(body);

      if (response.success == true) {
        _forgotLoader = false;
        notifyListeners();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInScreen(),
            ));
        CommonFunction.toastMessage(response.msg!);
        notifyListeners();
      } else {
        CommonFunction.toastMessage(response.msg!);
      }
    } catch (error) {
      _forgotLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for edit profile ///

  bool _profileLoader = false;

  bool get profileLoader => _profileLoader;

  Future<BaseModel<EditProfileModel>> callApiForEditProfile(
      body, context) async {
    EditProfileModel response;
    _profileLoader = true;
    notifyListeners();

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).editProfile(body);
      if (response.success == true) {
        _profileLoader = false;
        notifyListeners();

        SharedPreferenceHelper.setString(
            Preferences.firstName, response.data!.firstName!);
        SharedPreferenceHelper.setString(
            Preferences.lastName, response.data!.lastName!);
        SharedPreferenceHelper.setString(
            Preferences.phoneNo, response.data!.phone!);
        SharedPreferenceHelper.setString(
            Preferences.email, response.data!.email!);
        SharedPreferenceHelper.setString(
            Preferences.image, response.data!.imagePath!);
        SharedPreferenceHelper.setString(Preferences.bio, response.data!.bio!);

        CommonFunction.toastMessage(response.msg!);
        Navigator.pop(context);
        notifyListeners();
      }
    } catch (error) {
      _profileLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for update profile image ///

  Future<BaseModel<EditProfileImageModel>> callApiForUpdateImage(body) async {
    EditProfileImageModel response;

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).editProfileImage(body);
      if (response.success == true) {
        SharedPreferenceHelper.setString(Preferences.image, response.data!);
        CommonFunction.toastMessage(response.msg!);
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

  /// select profile image ///

  File? proImage;
  final picker = ImagePicker();
  String image = "";

  chooseProfileImage(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(
                    getTranslated(context, 'gallery').toString(),
                  ),
                  onTap: () {
                    _proImgFromGallery(context);
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(
                  getTranslated(context, 'camera').toString(),
                ),
                onTap: () {
                  _proImgFromCamera(context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _proImgFromGallery(context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      proImage = File(pickedFile.path);
      List<int> imageBytes = proImage!.readAsBytesSync();
      image = base64Encode(imageBytes);
      Map<String, dynamic> body = {
        "image": image,
      };
      callApiForUpdateImage(body);
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
    notifyListeners();
  }

  void _proImgFromCamera(context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      proImage = File(pickedFile.path);
      List<int> imageBytes = proImage!.readAsBytesSync();
      image = base64Encode(imageBytes);
      if (kDebugMode) {
        print("image is $image");
      }
      Map<String, dynamic> body = {
        "image": image,
      };
      callApiForUpdateImage(body);
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
    notifyListeners();
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
            MaterialPageRoute(builder: (context) => const SignInScreen()));
        notifyListeners();
      } else if (response.success == false) {
        _loginLoader = false;
        notifyListeners();
        if (response.msg != null) CommonFunction.toastMessage(response.msg!);
      }
    } catch (error) {
      _loginLoader = false;
      notifyListeners();
      return BaseModel()..setException(ErrorClass.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }
}
