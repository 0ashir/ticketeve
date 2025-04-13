import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/book_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CouponScreen extends StatefulWidget {
  final int? finalAmount;
  final int? eventId;

  const CouponScreen({super.key, this.finalAmount, this.eventId});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  late BookOrderProvider bookOrderProvider;

  @override
  void initState() {
    bookOrderProvider = Provider.of<BookOrderProvider>(context, listen: false);

    Future.delayed(
      const Duration(seconds: 0),
      () {
        bookOrderProvider.callApiForCoupon();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bookOrderProvider = Provider.of<BookOrderProvider>(context);

    return Scaffold(
      backgroundColor:AppColors. whiteColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            size: 18,
            color: AppColors.whiteColor,
          ),
        ),
        title: Text(
          getTranslated(context, AppConstant.coupons).toString(),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: bookOrderProvider.couponLoader,
        progressIndicator: const SpinKitCircle(
          color: AppColors.primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: bookOrderProvider.couponData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return CouponCard(
                height: 180,
                curveRadius: 15,
                borderRadius: 10,
                backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                firstChild: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${bookOrderProvider.couponData[index].discount} % ",
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          getTranslated(context, AppConstant.offerCodeIsValid).toString(),
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 12,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 12,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                            text: "${getTranslated(context, AppConstant.upto)} ",
                            children: [
                              TextSpan(
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFontFamily.poppinsMedium,
                                ),
                                text: bookOrderProvider.couponData[index].endDate!,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                secondChild: Container(
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Map<String, dynamic> body = {"coupon_code": bookOrderProvider.couponData[index].couponCode!, "event_id": widget.eventId, "amount": widget.finalAmount};

                      bookOrderProvider.callApiForCheckCoupon(body, widget.finalAmount, context);
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 0.5,
                        color: AppColors.whiteColor,
                        child: Container(
                          
                          alignment: Alignment.center,
                          child: Text(
                            bookOrderProvider.couponData[index].couponCode!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
