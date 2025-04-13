import 'package:eventright_organizer/constant/common_function.dart';
import 'package:eventright_organizer/model/add_coupon_model.dart';
import 'package:eventright_organizer/model/coupon_details_model.dart';
import 'package:eventright_organizer/model/coupon_events_model.dart';
import 'package:eventright_organizer/model/coupons_model.dart';
import 'package:eventright_organizer/model/delete_coupon_model.dart';
import 'package:eventright_organizer/model/edit_coupon_model.dart';
import 'package:eventright_organizer/retrofit/api_client.dart';
import 'package:eventright_organizer/retrofit/api_header.dart';
import 'package:eventright_organizer/retrofit/base_model.dart';
import 'package:eventright_organizer/retrofit/error_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CouponProvider extends ChangeNotifier {
  /// call api for coupons ///

  bool _couponLoader = false;

  bool get couponLoader => _couponLoader;

  List<CouponData> couponData = [];

  Future<BaseModel<CouponsModel>> callApiForCoupons() async {
    CouponsModel response;
    _couponLoader = true;
    notifyListeners();

    try {
      couponData.clear();
      response = await RestClient(
        RetroApi().dioData(),
      ).coupons();
      if (response.success == true) {
        _couponLoader = false;
        notifyListeners();

        if (response.data != null) {
          couponData.addAll(response.data!);
        }

        notifyListeners();
      }
    } catch (error) {
      _couponLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    return BaseModel()..data = response;
  }

  /// call api for add coupon ///

  Future<BaseModel<AddCouponModel>> callApiForAddCoupon(body) async {
    AddCouponModel response;

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).addCoupon(body);

      if (response.success == true) {
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

  /// call api for delete coupon ///

  Future<BaseModel<DeleteCouponModel>> callApiForDeleteCoupon(id) async {
    DeleteCouponModel response;

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).deleteCoupon(id);

      if (response.success == true) {
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

  /// call api for coupon event ///

  List<CouponEventsData> couponEventsData = [];

  Future<BaseModel<CouponEventsModel>> callApiForCouponEvent() async {
    CouponEventsModel response;

    try {
      couponEventsData.clear();
      response = await RestClient(
        RetroApi().dioData(),
      ).couponEvent();
      if (response.success == true) {
        couponEventsData.addAll(response.data!);
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

  /// call api for coupon details ///

  bool _couponDetails = false;

  bool get couponDetails => _couponDetails;

  String couponName = '';
  String startDate = '';
  String endDate = '';
  int eventId = 0;
  String description = '';
  int discount = 0;
  int maxUse = 0;
  String couponEventName = '';
  int minimumAmount = 0;
  int maximumDiscount = 0;
  int discountType = 0;

  Future<BaseModel<CouponDetailsModel>> callApiForCouponDetails(id) async {
    CouponDetailsModel response;
    _couponDetails = true;
    notifyListeners();

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).couponDetails(id);

      if (response.success == true) {
        _couponDetails = false;
        notifyListeners();

        if (response.data!.name != null) {
          couponName = response.data!.name!;
        }
        if (response.data!.startDate != null) {
          startDate = response.data!.startDate!;
        }
        if (response.data!.eventName != null) {
          couponEventName = response.data!.eventName!;
        }
        if (response.data!.endDate != null) {
          endDate = response.data!.endDate!;
        }
        if (response.data!.minimumAmount != null) {
          minimumAmount = response.data!.minimumAmount!.toInt();
        }
        if (response.data!.maximumDiscount != null) {
          maximumDiscount = response.data!.maximumDiscount!.toInt();
        }
        if (response.data!.discountType != null) {
          discountType = response.data!.discountType!.toInt();
        }
        if (response.data!.eventId != null) {
          eventId = response.data!.eventId!.toInt();
        }
        if (response.data!.description != null) {
          description = response.data!.description!;
        }
        if (response.data!.discount != null) {
          discount = response.data!.discount!.toInt();
        }
        if (response.data!.maxUse != null) {
          maxUse = response.data!.maxUse!.toInt();
        }
        notifyListeners();
      }
    } catch (error) {
      _couponDetails = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for edit coupon ///

  Future<BaseModel<EditCouponModel>> callApiForEditCoupon(body) async {
    EditCouponModel response;

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).editCoupon(body);

      if (response.success == true) {
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
}
