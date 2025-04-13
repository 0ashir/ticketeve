import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/model/wallet_deposit_response_model.dart';
import 'package:eventright_pro_user/model/wallet_model.dart';
import 'package:eventright_pro_user/retrofit/api_client.dart';
import 'package:eventright_pro_user/retrofit/api_header.dart';
import 'package:eventright_pro_user/retrofit/base_model.dart';
import 'package:eventright_pro_user/retrofit/server_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';

// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';

class WalletProvider extends ChangeNotifier {
  /// call api for wallet details ///

  bool _walletLoader = true;

  bool get walletLoader => _walletLoader;
  WalletModel? walletData;

  Future<BaseModel<WalletModel>> callApiForWallet() async {
    WalletModel response;
    try {
      _walletLoader = true;
      notifyListeners();
      response = await RestClient(RetroApi().dioData()).wallet();

      if (response.success == true) {
        walletData = response;
        notifyListeners();
      }
      _walletLoader = false;
      notifyListeners();
    } catch (error) {
      _walletLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for book order ///

  bool _bookOrderLoader = false;

  bool get bookOrderLoader => _bookOrderLoader;

  Future<BaseModel<WalletDepositResponseModel>> callApiForWalletDeposit(body) async {
    WalletDepositResponseModel response;
    _bookOrderLoader = true;
    notifyListeners();

    try {
      response = await RestClient(RetroApi().dioData()).walletDeposit(body);
      if (response.success == true) {
        if (kDebugMode) {
          print("New Balance : ${response.balance}");
          print("Old Balance : ${walletData!.data!.balance}");
        }
        walletData!.data!.balance = response.balance!;
        walletData!.data!.transactions!.insert(0, response.data!);
        CommonFunction.toastMessage("Deposited Successfully");
        notifyListeners();
      } else if (response.success == false) {
        CommonFunction.toastMessage("Error occurred while adding money to wallet");
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

  handlePaymentInitialization(BuildContext context, String payment, int debugMode) async {
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
        "amount": payment,
        "payment_type": "FLUTTERWAVE",
        "token": response.txRef,
        "currency": SharedPreferenceHelper.getString(Preferences.currencyCode),
      };
      response.txRef != ""
          ? callApiForWalletDeposit(body).then((value) {
              Navigator.of(context).pop();
            })
          : Fluttertoast.showToast(gravity: ToastGravity.BOTTOM, msg: "Payment Not Complete");
    } else {}
  }
}
