import 'dart:convert';

import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/book_order_provider.dart';
import 'package:eventright_pro_user/screens/components/button.dart';
import 'package:eventright_pro_user/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class Stripe extends StatefulWidget {
  final int? payment;
  final int? eventId;
  final int? quantity;
  final double? couponDiscount;
  final int? ticketId;
  final double? tax;
  final List? seatDetails;
  final List? bookSeats;
  final String? ticketDate;
  final int couponId;
  const Stripe(
      {super.key,
      this.payment,
      this.eventId,
      this.quantity,
      this.couponDiscount,
      this.ticketId,
      this.tax,
      this.seatDetails,
      this.bookSeats,
      this.ticketDate,
      required this.couponId});

  @override
  State<Stripe> createState() => _StripeState();
}

class _StripeState extends State<Stripe> {
  late BookOrderProvider bookOrderProvider;

  stripe.CardFieldInputDetails? _card;

  stripe.TokenData? tokenData;
  List catId = [];
  String convertedJson = "";

  @override
  void initState() {
    bookOrderProvider = Provider.of<BookOrderProvider>(context, listen: false);
    super.initState();
    setKey();
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

  Future setKey() async {
    stripe.Stripe.publishableKey =
        SharedPreferenceHelper.getString(Preferences.stripPublicKey);
    await stripe.Stripe.instance.applySettings();
  }

  @override
  Widget build(BuildContext context) {
    bookOrderProvider = Provider.of<BookOrderProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
        ),
        title: Text(
          getTranslated(context, AppConstant.stripe).toString(),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: bookOrderProvider.bookOrderLoader,
        progressIndicator: const SpinKitCircle(
          color: AppColors.primaryColor,
        ),
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: stripe.CardField(
                        cursorColor: AppColors.blackColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: AppColors.primaryColor)),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'Card Info',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.blackColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        autofocus: true,
                        onCardChanged: (card) {
                          setState(() {
                            _card = card;
                          });
                        },
                      ),
                    ),
                  ),
                ),
               
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: InkWell(
                    onTap: _card?.complete == true
                        ? _handleCreateTokenPress
                        : null,
                    child: Button(text: getTranslated(context, AppConstant.payment).toString())
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCreateTokenPress() async {
    if (_card == null) {
      return;
    }

    try {
      final tokenData = await stripe.Stripe.instance.createToken(
        const CreateTokenParams.card(
          params: CardTokenParams(type: TokenType.Card),
        ),
      );
      setState(() {
        this.tokenData = tokenData;
        Map<String, dynamic> body = {
          "event_id": widget.eventId,
          "ticket_id": widget.ticketId,
          "quantity": widget.quantity,
          "coupon_discount": widget.couponDiscount,
          "payment": widget.payment,
          "tax": widget.tax,
          "payment_type": "STRIPE",
          "payment_token": tokenData.id
        };
        if (widget.seatDetails != null) {
          if (widget.seatDetails!.isNotEmpty) {
            body['seat_details'] = convertedJson;
          }
          if (widget.bookSeats!.isNotEmpty) {
            body['book_seats'] = widget.bookSeats!.join(',').toString();
          }
        }
        if (widget.ticketDate != null) {
          body['ticket_date'] = widget.ticketDate;
        }
        if (widget.couponId != 0) {
          body['coupon_id'] = widget.couponId;
        }
        if (kDebugMode) {
          print(body);
        }
        if (tokenData.id != '') {
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
      });

      return;
    } catch (e) {
      rethrow;
    }
  }
}
