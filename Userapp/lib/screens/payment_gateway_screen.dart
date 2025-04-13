import 'dart:async';
import 'dart:convert';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_const_image.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/paypal/paypal_payment_screen.dart';
import 'package:eventright_pro_user/provider/book_order_provider.dart';
import 'package:eventright_pro_user/provider/setting_provider.dart';
import 'package:eventright_pro_user/screens/home_screen.dart';
import 'package:eventright_pro_user/screens/stripe_payment.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:eventright_pro_user/main.dart';

enum PaymentGateways { stripe, flutterWave, cod, razorpay, paypal, wallet,free}

class PaymentGateway extends StatefulWidget {
  final int? payment;
  final int? eventId;
  final int? quantity;
  final double? couponDiscount;
  final int? ticketId;
  final double? tax;
  final List? seatDetails;
  final List? bookSeats;
  final String ticketType;
  final String? ticketDate;
  final int couponId;
  const PaymentGateway({super.key, this.payment, this.eventId, this.quantity, this.couponDiscount, this.ticketId, this.tax, this.seatDetails, this.bookSeats, required this.ticketType, this.ticketDate, required this.couponId});

  @override
  State<PaymentGateway> createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  late SettingProvider settingProvider;
  late BookOrderProvider bookOrderProvider;

  PaymentGateways? _character;
  late Razorpay _razorpay;
  List catId = [];
  String convertedJson = "";

  @override
  void initState() {
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    bookOrderProvider = Provider.of<BookOrderProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 0), () {
      settingProvider.callApiForSetting();
    });
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Map<String, dynamic> map;
    if (widget.seatDetails != null) {
      for (int i = 0; i < widget.seatDetails!.length; i++) {
        map = {
          "row": widget.seatDetails![i].toString().split("-")[0],
          "seat": widget.seatDetails![i].toString().split("-")[1],
        };
        catId.add(map);
      }
      convertedJson = jsonEncode(catId);
      if (kDebugMode) {
        print("converted:$convertedJson");
      }
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final token = response.paymentId!;
    if (kDebugMode) {
      print("RazorPayToken : $token");
    }
    if (token.isNotEmpty) {
      Map<String, dynamic> body = {
        "event_id": widget.eventId,
        "ticket_id": widget.ticketId,
        "quantity": widget.quantity,
        "coupon_discount": widget.couponDiscount,
        "payment": widget.payment,
        "tax": widget.tax,
        "payment_type": "Razorpay",
        "payment_token": token,
      };
      if (widget.seatDetails != null) {
        if (widget.seatDetails!.isNotEmpty) {
          body['seat_details'] = convertedJson;
        }
        if (widget.bookSeats!.isNotEmpty) {
          body['book_seats'] = widget.bookSeats!.join(',').toString();
        }
      }
      if(widget.couponId!=0){
        body['coupon_id'] = widget.couponId;
      }
      if(widget.ticketDate!=null){
        body['ticket_date']=widget.ticketDate;
      }
      if (kDebugMode) {
        print(body);
      }
      bookOrderProvider.callApiForBookOrder(body).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(index: 1)));
      });
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    CommonFunction.toastMessage("ERROR: ${response.code} - ${response.message!}");
    if (kDebugMode) {
      print("Payment Error:${response.code} - ${response.message!}");
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    CommonFunction.toastMessage("EXTERNAL_WALLET: ${response.walletName!}");
  }

  void openCheckout() async {
    int payAmount = widget.payment! * 100;
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

  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of<SettingProvider>(context);
    bookOrderProvider = Provider.of<BookOrderProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          getTranslated(context, AppConstant.payment).toString(),
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: bookOrderProvider.bookOrderLoader,
        progressIndicator: const SpinKitCircle(
          color: AppColors.primaryColor,
        ),
        child: Column(
          children: [
              settingProvider.cod == 1 && widget.ticketType.toString()=="paid"
                ? Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(05, 0, 0, 0),
                          child: Center(
                            child: RadioListTile<PaymentGateways>(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.02,
                                  ),
                                  const Text(
                                    "Cod",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.blackColor,
                                      fontFamily: AppFontFamily.poppinsMedium,
                                    ),
                                  ),
                                ],
                              ),
                              value: PaymentGateways.cod,
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
            settingProvider.stripe == 1 && widget.ticketType.toString()=="paid"
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.whiteColor,
                      ),
                      height: 70,
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
            settingProvider.flutterWave == 1 && widget.ticketType.toString()=="paid"
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                      height: 70,
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
          
            settingProvider.razorpay == 1&& widget.ticketType.toString()=="paid"
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                      height: 70,
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
            settingProvider.paypal == 1&& widget.ticketType.toString()=="paid"
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                      height: 70,
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
            settingProvider.wallet == 1&& widget.ticketType.toString()=="paid"
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(05, 0, 0, 0),
                        child: Center(
                          child: RadioListTile<PaymentGateways>(
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Row(
                              children: [
                                const Icon(
                                  Icons.wallet,
                                  color: Color(0XFF003087),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                const Text(
                                  "Wallet",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.blackColor,
                                    fontFamily: AppFontFamily.poppinsMedium,
                                  ),
                                ),
                              ],
                            ),
                            value: PaymentGateways.wallet,
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
            widget.ticketType.toString()=="free"
                ? Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(05, 0, 0, 0),
                  child: Center(
                    child: RadioListTile<PaymentGateways>(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: const Text(
                        "Free",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.blackColor,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
                      value: PaymentGateways.free,
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
          if (_character == null) {
            CommonFunction.toastMessage("Please Select Payment Method");
          } else {
            if (_character == PaymentGateways.stripe) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Stripe(
                    payment: widget.payment,
                    eventId: widget.eventId,
                    ticketId: widget.ticketId,
                    quantity: widget.quantity,
                    couponDiscount: widget.couponDiscount,
                    tax: widget.tax,
                    bookSeats: widget.bookSeats,
                    seatDetails: widget.seatDetails,
                    ticketDate: widget.ticketDate,
                    couponId: widget.couponId,
                  ),
                ),
              );
            } else if (_character == PaymentGateways.flutterWave) {
              bookOrderProvider.handlePaymentInitialization(
                  context, widget.payment, widget.eventId, widget.ticketId, widget.quantity, widget.couponDiscount, widget.tax, settingProvider.flutterDebugMode, convertedJson, widget.bookSeats != null ? widget.bookSeats!.join(',').toString() : "",widget.ticketDate,widget.couponId);
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
                          "total": '${widget.payment}',
                          "currency": SharedPreferenceHelper.getString(Preferences.currencyCode),
                          "details": {"subtotal": '${widget.payment}', "shipping": '0', "shipping_discount": 0}
                        },
                        "description": "The payment transaction description.",
                        "item_list": {
                          "items": [
                            {"name": "A demo product", "quantity": 1, "price": '${widget.payment}', "currency": SharedPreferenceHelper.getString(Preferences.currencyCode)}
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
                        "event_id": widget.eventId,
                        "ticket_id": widget.ticketId,
                        "quantity": widget.quantity,
                        "coupon_discount": widget.couponDiscount,
                        "payment": widget.payment,
                        "tax": widget.tax,
                        "payment_type": "PAYPAL",
                        'payment_token': params['paymentId'],
                      };
                      if (widget.seatDetails != null) {
                        if (widget.seatDetails!.isNotEmpty) {
                          body['seat_details'] = convertedJson;
                        }
                        if (widget.bookSeats!.isNotEmpty) {
                          body['book_seats'] = widget.bookSeats!.join(',').toString();
                        }
                      }
                      if(widget.ticketDate!=null){
                        body['ticket_date']=widget.ticketDate;
                      }
                      if(widget.couponId!=0){
                        body['coupon_id'] = widget.couponId;
                      }
                      if (kDebugMode) {
                        print(body);
                      }
                      bookOrderProvider.callApiForBookOrder(body).then((value) {
                        if (value.data!.success == true) {
                          Navigator.pushReplacement(
                            navigatorKey.currentState!.context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(index: 1),
                            ),
                          );
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
            } else if (_character == PaymentGateways.wallet) {
              Map<String, dynamic> body = {
                "event_id": widget.eventId,
                "ticket_id": widget.ticketId,
                "quantity": widget.quantity,
                "coupon_discount": widget.couponDiscount,
                "payment": widget.payment,
                "tax": widget.tax,
                "payment_type": "WALLET",
              };
              if (widget.seatDetails != null) {
                if (widget.seatDetails!.isNotEmpty) {
                  body['seat_details'] = convertedJson;
                }
                if (widget.bookSeats!.isNotEmpty) {
                  body['book_seats'] = widget.bookSeats!.join(',').toString();
                }
              }
              if(widget.ticketDate!=null){
                body['ticket_date']=widget.ticketDate;
              }
              if(widget.couponId!=0){
                body['coupon_id'] = widget.couponId;
              }
              if (kDebugMode) {
                print(body);
              }
              bookOrderProvider.callApiForBookOrder(body).then((value) {
                if (value.data!.success == true) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(index: 1),
                    ),
                  );
                }
              });
            }
            else if(_character==PaymentGateways.free){
              Map<String, dynamic> body = {
                "event_id": widget.eventId,
                "ticket_id": widget.ticketId,
                "quantity": widget.quantity,
                "coupon_discount": widget.couponDiscount,
                "payment": widget.payment,
                "tax": widget.tax,
                "payment_type": "FREE",
              };
              if (widget.seatDetails != null) {
                if (widget.seatDetails!.isNotEmpty) {
                  body['seat_details'] = convertedJson;
                }
                if (widget.bookSeats!.isNotEmpty) {
                  body['book_seats'] = widget.bookSeats!.join(',').toString();
                }
              }
              if(widget.ticketDate!=null){
                body['ticket_date']=widget.ticketDate;
              }
              if (kDebugMode) {
                print(body);
              }
              bookOrderProvider.callApiForBookOrder(body).then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(index: 1),
                  ),
                );
              });
            }
            else {
              Map<String, dynamic> body = {
                "event_id": widget.eventId,
                "ticket_id": widget.ticketId,
                "quantity": widget.quantity,
                "coupon_discount": widget.couponDiscount,
                "payment": widget.payment,
                "tax": widget.tax,
                "payment_type": "LOCAL",
              };
              if (widget.seatDetails != null) {
                if (widget.seatDetails!.isNotEmpty) {
                  body['seat_details'] = convertedJson;
                }
                if (widget.bookSeats!.isNotEmpty) {
                  body['book_seats'] = widget.bookSeats!.join(',').toString();
                }
              }
              if(widget.ticketDate!=null){
                body['ticket_date']=widget.ticketDate;
              }
              if(widget.couponId!=0){
                body['coupon_id'] = widget.couponId;
              }
              if (kDebugMode) {
                print(body);
              }
              bookOrderProvider.callApiForBookOrder(body).then((value) {
                if(value.data!.success==true){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(index: 1),
                    ),
                  );
                }
              });
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
}
