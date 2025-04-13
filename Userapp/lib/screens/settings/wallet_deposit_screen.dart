import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_const_image.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/main.dart';
import 'package:eventright_pro_user/paypal/paypal_payment_screen.dart';
import 'package:eventright_pro_user/provider/setting_provider.dart';
import 'package:eventright_pro_user/provider/wallet_provider.dart';
import 'package:eventright_pro_user/screens/components/field.dart';
import 'package:eventright_pro_user/screens/payment_gateway_screen.dart';
import 'package:eventright_pro_user/screens/settings/wallet_stripe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class WalletDepositScreen extends StatefulWidget {
  const WalletDepositScreen({super.key});

  @override
  State<WalletDepositScreen> createState() => _WalletDepositScreenState();
}

class _WalletDepositScreenState extends State<WalletDepositScreen> {
  final TextEditingController _amountController = TextEditingController();
  late SettingProvider settingProvider;
  late WalletProvider walletProvider;

  @override
  void initState() {
    super.initState();
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    walletProvider = Provider.of<WalletProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      settingProvider.callApiForSetting();
    });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  late Razorpay _razorpay;
  PaymentGateways? _character;

  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of<SettingProvider>(context);
    walletProvider = Provider.of<WalletProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
            size: 16,
          ),
        ),
        centerTitle: true,
        title: Text(
          getTranslated(context, AppConstant.add).toString().toUpperCase(),
          style: const TextStyle(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Field(
              inputFormatter: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              controller: _amountController, label: "Amount", icon:const  Icon(Icons.currency_exchange), isPassword: false, inputType: TextInputType.number),
            
            settingProvider.stripe == 1
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor.withOpacity(0.5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.whiteColor,
                      ),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(05, 0, 0, 0),
                        child: Center(
                          child: RadioListTile<PaymentGateways>(
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Row(
                              children: [
                                Image.asset(
                                  AppConstantImage.stripeImage,
                                  height: 40,
                                  width: 40,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                Text(
                                  "Stripe".toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.blackColor,
                                    fontFamily: AppFontFamily.poppinsMedium,
                                  ),
                                ),
                              ],
                            ),
                            value: PaymentGateways.stripe,
                            activeColor: AppColors.primaryColor,
                            groupValue: _character,
                            onChanged: (PaymentGateways? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            settingProvider.flutterWave == 1
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.whiteColor,
                      ),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(05, 0, 0, 0),
                        child: Center(
                          child: RadioListTile<PaymentGateways>(
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Row(
                              children: [
                                Image.asset(
                                  AppConstantImage.flutterWaveImage,
                                  height: 40,
                                  width: 40,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                const Text(
                                  "FlutterWave",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.blackColor,
                                    fontFamily: AppFontFamily.poppinsMedium,
                                  ),
                                ),
                              ],
                            ),
                            value: PaymentGateways.flutterWave,
                            activeColor: AppColors.blackColor,
                            groupValue: _character,
                            onChanged: (PaymentGateways? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            settingProvider.razorpay == 1
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.whiteColor,
                      ),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(05, 0, 0, 0),
                        child: Center(
                          child: RadioListTile<PaymentGateways>(
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Row(
                              children: [
                                Image.asset(
                                  AppConstantImage.razorpayImage,
                                  height: 40,
                                  width: 40,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                const Text(
                                  "Razorpay",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.blackColor,
                                    fontFamily: AppFontFamily.poppinsMedium,
                                  ),
                                ),
                              ],
                            ),
                            value: PaymentGateways.razorpay,
                            activeColor: AppColors.blackColor,
                            groupValue: _character,
                            onChanged: (PaymentGateways? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            settingProvider.paypal == 1
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                         border: Border.all(color: AppColors.primaryColor.withOpacity(0.5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.whiteColor,
                      ),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(05, 0, 0, 0),
                        child: Center(
                          child: RadioListTile<PaymentGateways>(
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Row(
                              children: [
                                const Icon(
                                  Icons.paypal_rounded,
                                  color: Color(0XFF003087),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                const Text(
                                  "Paypal",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.blackColor,
                                    fontFamily: AppFontFamily.poppinsMedium,
                                  ),
                                ),
                              ],
                            ),
                            value: PaymentGateways.paypal,
                            activeColor: AppColors.primaryColor,
                            groupValue: _character,
                            onChanged: (PaymentGateways? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          if (_amountController.text.isEmpty) {
            CommonFunction.toastMessage("Please enter amount");
          } else {
            if (_character == null) {
              CommonFunction.toastMessage("Please Select Payment Method");
            } else {
              if (_character == PaymentGateways.stripe) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WalletStripe(
                      amount: _amountController.text,
                    ),
                  ),
                );
              } else if (_character == PaymentGateways.flutterWave) {
                walletProvider.handlePaymentInitialization(
                  context,
                  _amountController.text,
                  settingProvider.flutterDebugMode,
                );
              } else if (_character == PaymentGateways.razorpay) {
                openCheckout();
              } else if (_character == PaymentGateways.paypal) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UsePaypal(
                      sandboxMode: true,
                      clientId: SharedPreferenceHelper.getString(Preferences.paypalClientId),
                      secretKey: SharedPreferenceHelper.getString(Preferences.paypalSecret),
                      returnURL: "https://samplesite.com/return",
                      cancelURL: "https://samplesite.com/cancel",
                      transactions: [
                        {
                          "amount": {
                            "total": int.parse(_amountController.text),
                            "currency": SharedPreferenceHelper.getString(Preferences.currencyCode),
                            "details": {"subtotal": '${int.parse(_amountController.text)}', "shipping": '0', "shipping_discount": 0}
                          },
                          "description": "The payment transaction description.",
                          "item_list": {
                            "items": [
                              {"name": "A demo product", "quantity": 1, "price": '${int.parse(_amountController.text)}', "currency": SharedPreferenceHelper.getString(Preferences.currencyCode)}
                            ],
                          }
                        }
                      ],
                      note: "Contact us for any questions on your order.",
                      onSuccess: (params) {
                        if (kDebugMode) {
                          print("Paypal Payment ID : ${params['paymentId']}");
                        }
                        Map<String, dynamic> body = {
                          "amount": int.parse(_amountController.text),
                          "payment_type": "PAYPAL",
                          "token": params['paymentId'],
                          "currency": SharedPreferenceHelper.getString(Preferences.currencyCode),
                        };

                        walletProvider.callApiForWalletDeposit(body).then((value) {
                          if (value.data!.success == true) {
                            Navigator.of(navigatorKey.currentState!.context).pop();
                          }
                        });
                      },
                      onError: (error) {
                        Fluttertoast.showToast(msg: error.toString());
                        debugPrint("onError: $error");
                      },
                      onCancel: (params) {
                        debugPrint('cancelled: $params');
                      },
                    ),
                  ),
                );
              }
            }
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 05),
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            getTranslated(context, AppConstant.proceedToPay).toString(),
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.whiteColor,
              fontFamily: AppFontFamily.poppinsMedium,
            ),
          ),
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final token = response.paymentId!;
    // ignore: avoid_print
    print("RazorPayToken : $token");
    if (token.isNotEmpty) {
      Map<String, dynamic> body = {
        "amount": _amountController.text,
        "payment_type": "Razorpay",
        "token": token,
        "currency": SharedPreferenceHelper.getString(Preferences.currencyCode),
      };
      walletProvider.callApiForWalletDeposit(body).then((value) {
        Navigator.of(context).pop();
      });
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    CommonFunction.toastMessage("ERROR: ${response.code} - ${response.message!}");
    // ignore: avoid_print
    print("Payment Error:${response.code} - ${response.message!}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    CommonFunction.toastMessage("EXTERNAL_WALLET: ${response.walletName!}");
  }

  void openCheckout() async {
    int payAmount = int.parse(_amountController.text) * 100;
    var options = {
      'key': SharedPreferenceHelper.getString(Preferences.razorpayKey),
      'amount': payAmount,
      'name': 'EventRight',
      'prefill': {'contact': SharedPreferenceHelper.getString(Preferences.phoneNo), 'email': SharedPreferenceHelper.getString(Preferences.email)},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
