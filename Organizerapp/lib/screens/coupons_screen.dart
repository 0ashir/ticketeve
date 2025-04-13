import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/coupon_provider.dart';
import 'package:eventright_organizer/screens/add_new_coupon_screen.dart';
import 'package:eventright_organizer/screens/edit_coupon_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:ticket_widget/ticket_widget.dart';

class Coupons extends StatefulWidget {
  const Coupons({super.key});

  @override
  State<Coupons> createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  late CouponProvider couponProvider;

  Future<void> refresh() async {
    Future.delayed(
      const Duration(seconds: 0),
      () {
        couponProvider.callApiForCoupons();
      },
    );
  }

  @override
  void initState() {
    couponProvider = Provider.of<CouponProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      couponProvider.callApiForCoupons();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    couponProvider = Provider.of<CouponProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(getTranslated(context, 'coupons').toString(),
            style: const TextStyle(
                fontSize: 16,
                color: whiteColor,
                fontFamily: AppFontFamily.poppinsMedium)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddNewCoupon(),
                  ));
            },
            icon: const Icon(Icons.add, size: 25, color: whiteColor),
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: couponProvider.couponLoader,
        progressIndicator: const SpinKitCircle(color: primaryColor),
        offset: Offset(MediaQuery.of(context).size.width * 0.43,
            MediaQuery.of(context).size.height * 0.35),
        child: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: couponProvider.couponData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: TicketWidget(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 240,
                    padding:const  EdgeInsets.all(16),
                    color: primaryColor.withOpacity(0.2),
                    isCornerRounded: true,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.ticket_fill,
                                size: 20,
                                color: primaryColor.withOpacity(0.5),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  couponProvider.couponData[index].name!,
                                  style: const TextStyle(
                                      fontSize: 16, color: inputTextColor),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(
                                                "${getTranslated(context, 'delete_coupon')}?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(getTranslated(
                                                        context, 'cancel')
                                                    .toString()),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  couponProvider
                                                      .callApiForDeleteCoupon(
                                                          couponProvider
                                                              .couponData[index]
                                                              .id);
                                                  Navigator.pop(context);
                                                  refresh();
                                                },
                                                child: Text(
                                                    getTranslated(
                                                            context, 'delete')
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.red)),
                                              ),
                                            ],
                                          ));
                                },
                                child: const Icon(CupertinoIcons.delete,
                                    size: 20, color: Colors.red),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  couponProvider
                                      .callApiForCouponDetails(
                                          couponProvider.couponData[index].id!)
                                      .then(
                                    (value) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditCoupon(
                                            couponId: couponProvider
                                                .couponData[index].id!
                                                .toInt(),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Icon(Icons.edit,
                                    size: 20, color: blueColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 05),
                          Text(
                            couponProvider.couponData[index].event!.name!,
                            style: const TextStyle(
                                fontSize: 18, color: blackColor),
                          ),
                          Text(
                            "${couponProvider.couponData[index].startDate!} To ${couponProvider.couponData[index].endDate!}",
                            style: const TextStyle(
                                fontSize: 16, color: primaryColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Remaining : 1 Times",
                                style:
                                    TextStyle(fontSize: 16, color: blackColor),
                              ),
                              Text(
                                "${couponProvider.couponData[index].discount!}%",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: blackColor,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          const SizedBox(height: 05),
                          Divider(
                            thickness: 1,
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          Text(
                            couponProvider.couponData[index].description!,
                            style: const TextStyle(
                                fontSize: 16, color: inputTextColor),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
