import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/main.dart';
import 'package:eventright_pro_user/model/book_order_model.dart';
import 'package:eventright_pro_user/model/check_coupon_code_model.dart';
import 'package:eventright_pro_user/model/coupon_model.dart';
import 'package:eventright_pro_user/retrofit/api_client.dart';
import 'package:eventright_pro_user/retrofit/base_model.dart';
import 'package:eventright_pro_user/retrofit/server_error.dart';
import 'package:eventright_pro_user/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/retrofit/api_header.dart';

// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';

class BookOrderProvider extends ChangeNotifier {
  /// call api for all coupon ///

  bool _couponLoader = false;

  bool get couponLoader => _couponLoader;
  List<CouponData> couponData = [];

  Future<BaseModel<CouponModel>> callApiForCoupon() async {
    CouponModel response;
    _couponLoader = true;
    notifyListeners();

    try {
      couponData.clear();
      response = await RestClient(RetroApi().dioData()).coupon();

      if (response.success == true) {
        _couponLoader = false;
        notifyListeners();

        couponData.addAll(response.data!);
        notifyListeners();
      }
    } catch (error) {
      _couponLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for all coupon ///

  final bool _couponCheckLoader = false;

  bool get couponCheckLoader => _couponCheckLoader;

  Future<BaseModel<CheckCouponCodeModel>> callApiForCheckCoupon(body, finalAmount, BuildContext context) async {
    CheckCouponCodeModel response;

    try {
      _couponLoader = true;
      notifyListeners();
      if (kDebugMode) {
        print(body);
      }
      response = await RestClient(RetroApi().dioData()).checkCouponCode(body);
      if (response.success == true) {
        double discountAmount = 0;
        discountAmount = double.parse(response.data!.appliedDiscount.toString());
        if (response.msg != null) CommonFunction.toastMessage(response.msg!);
        Map<String, dynamic> data = {
          "discountAmount": discountAmount,
          "promoCode": body['coupon_code'],
          "coupon_id":response.data!.id,
        };
        navigatorKey.currentState!.pop(data);
        notifyListeners();
      } else {
        CommonFunction.toastMessage("Amount Not Valid");
      }
      _couponLoader = false;
      notifyListeners();
    } catch (error) {
      _couponLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for book order ///

  bool _bookOrderLoader = false;

  bool get bookOrderLoader => _bookOrderLoader;

  Future<BaseModel<BookOrderModel>> callApiForBookOrder(body) async {
    BookOrderModel response;
    _bookOrderLoader = true;
    notifyListeners();

    try {
      if (kDebugMode) {
        print(body);
      }
      response = await RestClient(RetroApi().dioData()).bookOrder(body);
      if (response.success == true) {
        if (kDebugMode) {
          print(response.data!.orderId);
        }
        CommonFunction.toastMessage("Order Create Successfully");
        notifyListeners();
      } else if (response.success == false) {
        if (response.msg != null) CommonFunction.toastMessage(response.msg!);
        if (response.message != null) CommonFunction.toastMessage(response.message!);
      }
      _bookOrderLoader = false;
      notifyListeners();
    } catch (error) {
      if (body['payment_type'] == "STRIPE") {
        CommonFunction.toastMessage(error.toString());
      }
      _bookOrderLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  ///FlutterWave Payment ///
  final String currencyFlutterWave = "RWF";

  handlePaymentInitialization(context, payment, eventid, ticketId, quantity, couponDiscount, tax, debugMode, String? seatDetails, String? bookSeats,String? ticketDate,int couponId) async {
    final Customer customer = Customer(name: SharedPreferenceHelper.getString(Preferences.fName), phoneNumber: SharedPreferenceHelper.getString(Preferences.phoneNo), email: SharedPreferenceHelper.getString(Preferences.email));
    final Flutterwave flutterwave = Flutterwave(
      context: context,
      publicKey: SharedPreferenceHelper.getString(Preferences.flutterWavePublicKey),
      currency: currencyFlutterWave,
      txRef: const Uuid().v1(),
      amount: payment.toString(),
      customer: customer,
      paymentOptions: "card",
      customization: Customization(title: "EventRight"),
      redirectUrl: "https://www.google.com",
      isTestMode: debugMode == 1 ? true : false,
    );
    final ChargeResponse response = await flutterwave.charge();
    if (response.txRef != null) {
      Map<String, dynamic> body = {
        "event_id": eventid,
        "ticket_id": ticketId,
        "quantity": quantity,
        "coupon_discount": couponDiscount,
        "payment": payment,
        "tax": tax,
        "payment_type": "FLUTTERWAVE",
        "payment_token": response.txRef,
      };
      if (bookSeats!.isNotEmpty) {
        body['book_seats'] = bookSeats;
      }
      if (seatDetails!.isNotEmpty) {
        body['seat_details'] = seatDetails;
      }
      if(ticketDate!=null){
        body['ticket_date']=ticketDate;
      }
      if(couponId!=0){
        body['coupon_id'] = couponId;
      }
      response.txRef != ""
          ? callApiForBookOrder(body).then((value) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(index: 1)));
            })
          : Fluttertoast.showToast(gravity: ToastGravity.BOTTOM, msg: "Payment Not Complete");
    } else {}
  }
}
