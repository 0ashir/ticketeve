import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_const_image.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/order_provider.dart';
import 'package:eventright_pro_user/screens/order_ticket_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'components/button.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late OrderProvider orderProvider;

  final TextEditingController _reviewController = TextEditingController();

  late TabController _tabController;
  int _activeIndex = 0;
  double rating = 0;

  Future<void> refresh() async {
    setState(() {
      Future.delayed(
        const Duration(seconds: 0),
        () {
          orderProvider.callApiForOrders();
        },
      );
    });
  }

  @override
  void initState() {
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 0), () {
      orderProvider.callApiForOrders();
    });
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    orderProvider = Provider.of<OrderProvider>(context);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _activeIndex = _tabController.index;
        });
      }
    });

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          getTranslated(context, AppConstant.orderDetails).toString(),
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: orderProvider.orderLoader,
        progressIndicator: const SpinKitCircle(color: AppColors.primaryColor),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor, width: 1),
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: _activeIndex == 0
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          )
                        : const BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                    color: AppColors.primaryColor,
                  ),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: AppFontFamily.poppinsMedium,
                  ),
                  splashBorderRadius: _activeIndex == 0
                      ? const BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          topRight: Radius.circular(15),
                        )
                      : const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                  tabs: [
                    Tab(
                      text: getTranslated(context, AppConstant.upcomingTitle)
                          .toString(),
                    ),
                    Tab(
                      text: getTranslated(context, AppConstant.pastTicketsTitle)
                          .toString(),
                    ),
                  ],
                ),
              ),
              // tab bar view here
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    RefreshIndicator(
                      color: AppColors.primaryColor,
                      onRefresh: refresh,
                      child: orderProvider.upcomingData.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Text(
                                  getTranslated(
                                          context, AppConstant.noDataFound)
                                      .toString(),
                                  style: const TextStyle(
                                    fontFamily: AppFontFamily.poppinsMedium,
                                  ),
                                ),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: orderProvider.upcomingData.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 65,
                                            height: 65,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(6),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: orderProvider
                                                        .upcomingData[index]
                                                        .event!
                                                        .imagePath! +
                                                    orderProvider
                                                        .upcomingData[index]
                                                        .event!
                                                        .image!,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const SpinKitCircle(
                                                  color: AppColors.primaryColor,
                                                ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(AppConstantImage
                                                        .noImage),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  orderProvider
                                                      .upcomingData[index]
                                                      .event!
                                                      .name!,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                  ),
                                                ),
                                                Text(
                                                  CommonFunction.shortMonthName(
                                                      orderProvider
                                                          .upcomingData[index]
                                                          .event!
                                                          .startTime!),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors
                                                        .inputTextColor,
                                                    fontFamily: AppFontFamily
                                                        .poppinsRegular,
                                                  ),
                                                ),
                                                Text(
                                                  "OrderId :  ${orderProvider.upcomingData[index].orderId!}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors
                                                        .inputTextColor,
                                                    fontFamily: AppFontFamily
                                                        .poppinsRegular,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      orderProvider
                                                          .callApiForSingleOrderDetails(
                                                              orderProvider
                                                                  .upcomingData[
                                                                      index]
                                                                  .id)
                                                          .then((value) {
                                                        _modalBottomSheetMenu();
                                                      });
                                                    });
                                                  },
                                                  child: Text(
                                                    getTranslated(
                                                            context,
                                                            AppConstant
                                                                .viewDetailsTitle)
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          AppColors.blueColor,
                                                      fontFamily: AppFontFamily
                                                          .poppinsMedium,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox();
                              },
                            ),
                    ),
                    RefreshIndicator(
                      color: AppColors.primaryColor,
                      onRefresh: refresh,
                      child: orderProvider.pastData.isEmpty
                          ? Center(
                              child: Text(
                                getTranslated(context, AppConstant.noDataFound)
                                    .toString(),
                                style: const TextStyle(
                                  fontFamily: AppFontFamily.poppinsMedium,
                                ),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: orderProvider.pastData.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 65,
                                        height: 65,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(6),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: orderProvider
                                                    .pastData[index]
                                                    .event!
                                                    .imagePath! +
                                                orderProvider.pastData[index]
                                                    .event!.image!,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const SpinKitCircle(
                                              color: AppColors.primaryColor,
                                            ),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    AppConstantImage.noImage),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              orderProvider
                                                  .pastData[index].event!.name!,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                fontFamily:
                                                    AppFontFamily.poppinsMedium,
                                              ),
                                            ),
                                            Text(
                                              CommonFunction.shortMonthName(
                                                  orderProvider.pastData[index]
                                                      .event!.startTime!),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.inputTextColor,
                                                fontFamily: AppFontFamily
                                                    .poppinsRegular,
                                              ),
                                            ),
                                            Text(
                                              "OrderId : ${orderProvider.pastData[index].orderId}",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.inputTextColor,
                                                fontFamily: AppFontFamily
                                                    .poppinsRegular,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    orderProvider
                                                        .callApiForSingleOrderDetails(
                                                            orderProvider
                                                                .pastData[index]
                                                                .id)
                                                        .then((value) {
                                                      _modalBottomSheetMenu();
                                                    });
                                                  },
                                                  child: Text(
                                                    getTranslated(
                                                            context,
                                                            AppConstant
                                                                .viewDetailsTitle)
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          AppColors.blueColor,
                                                      fontFamily: AppFontFamily
                                                          .poppinsMedium,
                                                    ),
                                                  ),
                                                ),
                                                orderProvider.pastData[index]
                                                            .review ==
                                                        null
                                                    ? InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _modalBottomAddReview(
                                                                orderProvider
                                                                    .pastData[
                                                                        index]
                                                                    .event!
                                                                    .id!,
                                                                orderProvider
                                                                    .pastData[
                                                                        index]
                                                                    .id!);
                                                            setState(() {});
                                                          });
                                                        },
                                                        child: Text(
                                                          getTranslated(
                                                                  context,
                                                                  AppConstant
                                                                      .addYourReviewTitle)
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            color: AppColors
                                                                .blueColor,
                                                            fontFamily:
                                                                AppFontFamily
                                                                    .poppinsMedium,
                                                          ),
                                                        ),
                                                      )
                                                    : RatingBar.builder(
                                                        initialRating:
                                                            orderProvider
                                                                .pastData[index]
                                                                .review!
                                                                .rate!
                                                                .toDouble(),
                                                        minRating: 1,
                                                        itemSize: 16,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        ignoreGestures: true,
                                                        itemPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    4.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {},
                                                      ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        backgroundColor: AppColors.whiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, myState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 45.0,
                  color: Colors.transparent,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      child: Text(
                        getTranslated(context, AppConstant.details).toString(),
                        style: const TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 18,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 65,
                              height: 65,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: orderProvider.eventImage,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const SpinKitCircle(
                                    color: AppColors.primaryColor,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(AppConstantImage.noImage),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderProvider.eventName,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.blackColor,
                                        fontFamily: AppFontFamily.poppinsMedium,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Text(
                                    orderProvider.eventDate,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.inputTextColor,
                                      fontFamily: AppFontFamily.poppinsRegular,
                                    ),
                                  ),
                                  _activeIndex == 1
                                      ? Container(
                                          child: orderProvider.eventReview != 0
                                              ? RatingBar.builder(
                                                  initialRating:
                                                      orderProvider.eventReview,
                                                  minRating: 1,
                                                  itemSize: 16,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  ignoreGestures: true,
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {},
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    myState(() {
                                                      Navigator.pop(context);
                                                      _modalBottomAddReview(
                                                          orderProvider.eventId,
                                                          orderProvider
                                                              .orderId);
                                                    });
                                                  },
                                                  child: Text(
                                                    getTranslated(
                                                            context,
                                                            AppConstant
                                                                .addYourReviewTitle)
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          AppColors.blueColor,
                                                      fontFamily: AppFontFamily
                                                          .poppinsMedium,
                                                    ),
                                                  ),
                                                ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, AppConstant.ticketNo)
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.blackColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                            Text(
                              orderProvider.eventTicketNo,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.inputTextColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, AppConstant.quantity)
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.blackColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                            Text(
                              orderProvider.qty.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.inputTextColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, AppConstant.bookingStatus)
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.blackColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                            Text(
                              orderProvider.bookingStatus,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.inputTextColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, AppConstant.couponDiscount)
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.blackColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                            Text(
                              orderProvider.couponDiscount.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.inputTextColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, AppConstant.payment)
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.blackColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                            Text(
                              orderProvider.eventPayment.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.inputTextColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, AppConstant.paymentStatus)
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.blackColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                            Text(
                              orderProvider.paymentStatus,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.inputTextColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, AppConstant.paymentGateway)
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.blackColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                            Text(
                              orderProvider.paymentGateWay,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.inputTextColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OrderTicketDetailsScreen(),
                                  ),
                                );
                              });
                            },
                            child: Button(
                                text: getTranslated(
                                        context, AppConstant.qrCodeTitle)
                                    .toString())),
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }

  void _modalBottomAddReview(eventId, orderId) {
    showModalBottomSheet(
        backgroundColor: AppColors.whiteColor,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (builder) {
          return Padding(
            padding: MediaQuery.of(builder).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(builder).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated(context, AppConstant.addReview)
                                .toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: AppColors.blackColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: SharedPreferenceHelper.getString(
                                    Preferences.image),
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const SpinKitCircle(
                                  color: AppColors.primaryColor,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(AppConstantImage.noImage),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextFormField(
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                              controller: _reviewController,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                hintText: getTranslated(context,
                                        AppConstant.shareYourExperience)
                                    .toString(),
                                hintStyle: const TextStyle(
                                  color: AppColors.inputTextColor,
                                  fontSize: 14,
                                  fontFamily: AppFontFamily.poppinsMedium,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        getTranslated(
                                context, AppConstant.howManyStarsYouWillGive)
                            .toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.blackColor,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
                      const SizedBox(height: 10),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        itemSize: 25,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (ratings) {
                          setState(() {
                            rating = ratings;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          if (_reviewController.text.isEmpty) {
                            CommonFunction.toastMessage(
                                "Please Share Experience");
                          } else if (rating == 0) {
                            CommonFunction.toastMessage("Please Apply Rating");
                          } else {
                            Map<String, dynamic> body = {
                              "event_id": eventId,
                              "order_id": orderId,
                              "message": _reviewController.text,
                              "rate": rating
                            };
                            orderProvider
                                .callApiForAddReview(body)
                                .then((value) {
                              if (value.data!.success == true) {
                                refresh();
                              }
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(08),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            getTranslated(context, AppConstant.shareReview)
                                .toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryColor,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
