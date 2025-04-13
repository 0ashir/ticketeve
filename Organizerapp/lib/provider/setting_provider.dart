
import 'package:eventright_organizer/constant/common_function.dart';
import 'package:eventright_organizer/model/add_feed_back_model.dart';
import 'package:eventright_organizer/model/change_password_model.dart';
import 'package:eventright_organizer/model/faq_model.dart';
import 'package:eventright_organizer/model/followers_model.dart';
import 'package:eventright_organizer/model/setting_model.dart';
import 'package:eventright_organizer/retrofit/api_client.dart';
import 'package:eventright_organizer/retrofit/api_header.dart';
import 'package:eventright_organizer/retrofit/base_model.dart';
import 'package:eventright_organizer/retrofit/error_handler.dart';
import 'package:flutter/cupertino.dart';

class SettingProvider extends ChangeNotifier {
  /// call api for setting ///

  bool _settingLoader = false;

  bool get settingLoader => _settingLoader;

  String privacy = '';
  String terms = '';

  Future<BaseModel<SettingModel>> callApiForSettings() async {
    SettingModel response;
    _settingLoader = true;
    // notifyListeners();

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).settings();
      if (response.success == true) {
        _settingLoader = false;
        notifyListeners();
        if (response.data!.privacyPolicyOrganizer != null) {
          privacy = response.data!.privacyPolicyOrganizer!;
        }
        if (response.data!.termsUseOrganizer != null) {
          terms = response.data!.termsUseOrganizer!;
        }
      }
    } catch (error) {
      _settingLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for change password ///
  bool _passwordLoader = false;

  bool get passwordLoader => _passwordLoader;

  Future<BaseModel<ChangePasswordModel>> callApiForChangePassword(body) async {
    ChangePasswordModel response;
    _passwordLoader = true;
    notifyListeners();

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).changePassword(body);

      if (response.success == true) {
        CommonFunction.toastMessage(response.msg!);
        notifyListeners();
      }
    } catch (error) {
      _passwordLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for faq ///

  bool _faqLoader = false;

  bool get faqLoader => _faqLoader;
  List<FaqData> faqs = [];

  Future<BaseModel<FaqModel>> callApiForFaq() async {
    FaqModel response;
    _faqLoader = true;
    notifyListeners();

    try {
      faqs.clear();
      response = await RestClient(
        RetroApi().dioData(),
      ).faqs();

      if (response.success == true) {
        _faqLoader = false;
        notifyListeners();

        if (response.data != null) {
          faqs.addAll(response.data!);
          notifyListeners();
        }
      }
    } catch (error) {
      _faqLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for add feedBack ///

  bool _feedBackLoader = false;

  bool get feedBackLoader => _feedBackLoader;

  Future<BaseModel<AddFeedBackModel>> callApiForAddFeedBack(body) async {
    AddFeedBackModel response;
    _feedBackLoader = true;
    notifyListeners();

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).feedBack(body);
      if (response.success == true) {
        _feedBackLoader = false;
        notifyListeners();
      }
    } catch (error) {
      _feedBackLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for followers ///

  bool _followersLoader = false;

  bool get followersLoader => _followersLoader;
  List<FollowersData> followers = [];

  Future<BaseModel<FollowersModel>> callApiForFollowers() async {
    FollowersModel response;
    _followersLoader = true;
    notifyListeners();

    try {
      followers.clear();

      response = await RestClient(
        RetroApi().dioData(),
      ).followers();

      if (response.success == true) {
        _followersLoader = false;
        notifyListeners();

        if (response.data != null) {
          followers.addAll(response.data!);
        }

        notifyListeners();
      }
    } catch (error) {
      _followersLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }
}
