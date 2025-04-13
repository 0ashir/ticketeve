import 'dart:convert';
import 'dart:io';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/model/add_following_model.dart';
import 'package:eventright_pro_user/model/delete_notification_model.dart';
import 'package:eventright_pro_user/model/edit_user_profile_model.dart';
import 'package:eventright_pro_user/model/following_model.dart';
import 'package:eventright_pro_user/model/notification_model.dart';
import 'package:eventright_pro_user/model/organization_model.dart';
import 'package:eventright_pro_user/model/setting_model.dart';
import 'package:eventright_pro_user/model/update_profile_image_model.dart';
import 'package:eventright_pro_user/retrofit/api_client.dart';
import 'package:eventright_pro_user/retrofit/api_header.dart';
import 'package:eventright_pro_user/retrofit/base_model.dart';
import 'package:eventright_pro_user/retrofit/server_error.dart';
import 'package:eventright_pro_user/routes/route_names.dart';
import 'package:eventright_pro_user/screens/auth/signin_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingProvider extends ChangeNotifier {
  /// call api for setting ///

  int flutterWave = 0;
  int wallet = 0;
  int flutterDebugMode = 0;
  int stripe = 0;
  int cod = 0;
  int razorpay = 0;
  int paypal = 0;
  String terms = '';
  String cookie = '';
  String acknowledgement = '';
  String help = '';
  String version = '';
  String privacy = '';

  Future<BaseModel<SettingModel>> callApiForSetting() async {
    SettingModel response;
    notifyListeners();

    try {
      response = await RestClient(RetroApi().dioData()).setting();

      if (response.success == true) {
        if (response.data!.privacyPolicy != null) {
          privacy = response.data!.privacyPolicy!;
        }
        if (response.data!.termsServices != null) {
          terms = response.data!.termsServices!;
        }
        if (response.data!.appVersion != null) {
          version = response.data!.appVersion!;
        }
        if (response.data!.cookiePolicy != null) {
          cookie = response.data!.cookiePolicy!;
        }
        if (response.data!.acknowledgement != null) {
          acknowledgement = response.data!.acknowledgement!;
        }
        if (response.data!.helpCenter != null) {
          help = response.data!.helpCenter!;
        }
        if (response.data!.currencySymbol != null) {
          SharedPreferenceHelper.setString(
              Preferences.currencySymbol, response.data!.currencySymbol!);
        }
        if (response.data!.currency != null) {
          SharedPreferenceHelper.setString(
              Preferences.currencyCode, response.data!.currency!);
        }
        if (response.data!.paypal != 0 &&
            response.data!.paypalClientId != null &&
            response.data!.paypalSecret != null) {
          paypal = response.data!.paypal!.toInt();
          SharedPreferenceHelper.setString(
              Preferences.paypalClientId, response.data!.paypalClientId!);
          SharedPreferenceHelper.setString(
              Preferences.paypalSecret, response.data!.paypalSecret!);
        }
        if (response.data!.stripe != 0) {
          if (response.data!.stripePublicKey != null) {
            stripe = response.data!.stripe!.toInt();
            SharedPreferenceHelper.setString(
                Preferences.stripPublicKey, response.data!.stripePublicKey!);
          }
        }
        if (response.data!.flutterwave != 0) {
          if (response.data!.flutterWavePublicKey != null &&
              response.data!.flutterWaveSecretKey != null) {
            flutterWave = response.data!.flutterwave!.toInt();
            flutterDebugMode = response.data!.flutterDebugMode!.toInt();
            SharedPreferenceHelper.setString(Preferences.flutterWavePublicKey,
                response.data!.flutterWavePublicKey!);
            SharedPreferenceHelper.setString(Preferences.flutterWaveSecretKey,
                response.data!.flutterWaveSecretKey!);
          }
        }
        if (response.data!.wallet != 0 && response.data!.wallet != null) {
          wallet = response.data!.wallet!.toInt();
          SharedPreferenceHelper.setString(
              Preferences.wallet, response.data!.wallet!.toString());
        }
        if (response.data!.razor != 0) {
          if (response.data!.razorPublishKey != null) {
            razorpay = response.data!.razor!.toInt();
            SharedPreferenceHelper.setString(
                Preferences.razorpayKey, response.data!.razorPublishKey!);
          }
        }
        if (response.data!.cod != null && response.data!.cod != 0) {
          cod = response.data!.cod!.toInt();
        }
        notifyListeners();
      }
    } catch (error) {
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for notification ///

  bool _notificationLoader = false;

  bool get notificationLoader => _notificationLoader;
  List<NotificationData> notificationData = [];

  Future<BaseModel<NotificationModel>> callApiForNotification() async {
    NotificationModel response;
    _notificationLoader = true;
    notifyListeners();

    try {
      notificationData.clear();
      response = await RestClient(RetroApi().dioData()).notification();

      if (response.success == true) {
        _notificationLoader = false;
        notifyListeners();

        notificationData.addAll(response.data!);
        notifyListeners();
      }
    } catch (error) {
      _notificationLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for following ///

  bool _followingLoader = false;

  bool get followingLoader => _followingLoader;
  List<FollowingData> followingData = [];

  Future<BaseModel<FollowingModel>> callApiForFollowing() async {
    FollowingModel response;
    _followingLoader = true;
    notifyListeners();

    try {
      followingData.clear();
      response = await RestClient(RetroApi().dioData()).following();

      if (response.success == true) {
        _followingLoader = false;
        notifyListeners();

        followingData.addAll(response.data!);
        notifyListeners();
      }
    } catch (error) {
      _followingLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for organization ///

  bool _organizationLoader = false;

  bool get organizationLoader => _organizationLoader;
  List<OrganizationData> organizationData = [];

  Future<BaseModel<OrganizationModel>> callApiForOrganization() async {
    OrganizationModel response;
    _organizationLoader = true;
    notifyListeners();

    try {
      response = await RestClient(RetroApi().dioData()).organization();
      if (response.success == true) {
        organizationData.clear();
        _organizationLoader = false;
        notifyListeners();
        organizationData.addAll(response.data!);
        notifyListeners();
      }
    } catch (error) {
      _organizationLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for addFollowing ///

  bool _addfollowingLoader = false;

  bool get addfollowingLoader => _addfollowingLoader;

  Future<BaseModel<AddFollowingModel>> callApiForAddFollowing(body) async {
    AddFollowingModel response;
    _addfollowingLoader = true;
    notifyListeners();

    try {
      response = await RestClient(RetroApi().dioData()).addFollowing(body);

      if (response.success == true) {
        _addfollowingLoader = false;
        notifyListeners();
        callApiForFollowing();
        callApiForOrganization();
        CommonFunction.toastMessage(response.msg!);
      } else if (response.success == false) {
        if (response.msg != null) CommonFunction.toastMessage(response.msg!);
      }
    } catch (error) {
      _addfollowingLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for delete notification ///
  bool _deleteNotificationLoader = false;

  bool get deleteNotificationLoader => _deleteNotificationLoader;

  Future<BaseModel<DeleteNotificationModel>>
      callApiForDeleteNotification() async {
    DeleteNotificationModel response;
    _deleteNotificationLoader = true;
    notifyListeners();

    try {
      organizationData.clear();
      response = await RestClient(RetroApi().dioData()).deleteNotification();

      if (response.success == true) {
        _deleteNotificationLoader = false;
        notifyListeners();
      }
    } catch (error) {
      _deleteNotificationLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for update image ///

  Future<BaseModel<UpdateProfileImageModel>> callApiForUpdateImage(body) async {
    UpdateProfileImageModel response;
    notifyListeners();

    try {
      response = await RestClient(RetroApi().dioData()).updateImage(body);

      if (response.success == true) {
        notifyListeners();
      }
    } catch (error) {
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for update profile ///
  bool _updateProfile = false;

  bool get updateProfile => _updateProfile;

  Future<BaseModel<EditUserProfileModel>> callApiForUpdateProfile(body) async {
    EditUserProfileModel response;
    _updateProfile = true;
    notifyListeners();

    try {
      response = await RestClient(RetroApi().dioData()).updateProfile(body);

      if (response.success == true) {
        _updateProfile = false;
        notifyListeners();

        SharedPreferenceHelper.setString(
            Preferences.fName, response.data!.name!);
        SharedPreferenceHelper.setString(
            Preferences.lName, response.data!.lastName!);
        SharedPreferenceHelper.setString(
            Preferences.phoneNo, response.data!.phone!);

        notifyListeners();
      }
    } catch (error) {
      _updateProfile = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  Future<void> logoutUser(context) async {
    SharedPreferenceHelper.remove(Preferences.isLoggedIn);
    SharedPreferenceHelper.remove(Preferences.image);
    SharedPreferenceHelper.remove(Preferences.phoneNo);
    SharedPreferenceHelper.remove(Preferences.email);
    SharedPreferenceHelper.remove(Preferences.fName);
    SharedPreferenceHelper.remove(Preferences.lName);
    SharedPreferenceHelper.remove(Preferences.authToken);
    SharedPreferenceHelper.remove(Preferences.deviceToken);
    SharedPreferenceHelper.remove(Preferences.currencySymbol);
    SharedPreferenceHelper.remove(Preferences.currencyCode);
    SharedPreferenceHelper.remove(Preferences.flutterWaveKey);
    SharedPreferenceHelper.remove(Preferences.razorpayKey);
    SharedPreferenceHelper.remove(Preferences.stripPublicKey);
    SharedPreferenceHelper.remove(Preferences.selectedLat);
    SharedPreferenceHelper.remove(Preferences.selectedLang);
    SharedPreferenceHelper.remove(Preferences.isSearch);
    SharedPreferenceHelper.remove(Preferences.selectedSearch);
    SharedPreferenceHelper.remove(Preferences.location);
    SharedPreferenceHelper.remove(Preferences.appId);
    SharedPreferenceHelper.remove(Preferences.version);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()),
      ModalRoute.withName(loginRoute),
    );
  }

  /// UserUpdate Image ///
  File? proImage;
  final picker = ImagePicker();
  String image = "";

  chooseProfileImage(context) {
    showModalBottomSheet(
      context: context,
      elevation: 0.5,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(
                    Icons.photo_library_rounded,
                    color: AppColors.blackColor,
                  ),
                  title: Text(
                    getTranslated(context, AppConstant.gallery).toString(),
                    style: const TextStyle(
                        fontFamily: AppFontFamily.poppinsMedium),
                  ),
                  onTap: () {
                    _proImgFromGallery(context);
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(
                  Icons.photo_camera_rounded,
                  color: AppColors.blackColor,
                ),
                title: Text(
                  getTranslated(context, AppConstant.camera).toString(),
                  style:
                      const TextStyle(fontFamily: AppFontFamily.poppinsMedium),
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
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
    notifyListeners();
  }
}
