// TODO: Seat Mapping Module: Step 5: Uncomment Following if you want to add this module
// import 'package:eventright_pro_user/SeatMap/seating_screen.dart';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/ticket_provider.dart';
import 'package:eventright_pro_user/screens/components/button.dart';
import 'package:eventright_pro_user/screens/coupon_screen.dart';
import 'package:eventright_pro_user/screens/payment_gateway_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ticket_widget/ticket_widget.dart';

class TicketSubDetails extends StatefulWidget {
  final String? ticketType;
  final int isSeatMapModuleInstalled;
  final int? seatMapId;
  final String eventStartDate;
  final String eventEndDate;
  const TicketSubDetails(
      {super.key,
      this.ticketType,
      required this.isSeatMapModuleInstalled,
      this.seatMapId,
      required this.eventStartDate,
      required this.eventEndDate});

  @override
  State<TicketSubDetails> createState() => _TicketSubDetailsState();
}

class _TicketSubDetailsState extends State<TicketSubDetails> {
  int quantity = 1;
  late TicketProvider ticketProvider;
  int totalAmount = 0;
  double discountAmount = 0;
  int couponID = 0;
  String couponCode = '';

  // ignore: prefer_typing_uninitialized_variables
  var result;

  @override
  void initState() {
    ticketProvider = Provider.of<TicketProvider>(context, listen: false);
    setAmount();

    super.initState();
  }

  void setAmount() async {
    setState(() {
      totalAmount = ticketProvider.totalTax + quantity * ticketProvider.price;
    });
  }

  void increment() {
    if (ticketProvider.soldOut != true) {
      if (quantity < ticketProvider.tickerPerOrder) {
        quantity++;
        totalAmount = totalAmount + ticketProvider.price;
      } else {
        CommonFunction.toastMessage(
            "You can not buy more than ${ticketProvider.tickerPerOrder}");
      }
    } else {
      CommonFunction.toastMessage("Ticket Not Available");
    }
  }

  void decrement() {
    if (quantity > 1) {
      quantity--;
      totalAmount = totalAmount - ticketProvider.price - discountAmount.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    ticketProvider = Provider.of<TicketProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: AppColors.whiteColor,
          ),
        ),
        title: Text(
          getTranslated(context, AppConstant.ticketDetails).toString(),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ModalProgressHUD(
          inAsyncCall: ticketProvider.ticketDetailsLoader,
          progressIndicator: const SpinKitCircle(
            color: AppColors.primaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text(
                ticketProvider.eventName,
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.blackColor,
                  fontFamily: AppFontFamily.poppinsMedium,
                ),
              ),
              Text(
                widget.ticketType!,
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.blackColor,
                  fontFamily: AppFontFamily.poppinsMedium,
                ),
              ),
              Text(
                "${getTranslated(context, AppConstant.by)} ${ticketProvider.organizerName}",
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.blueColor,
                  fontFamily: AppFontFamily.poppinsMedium,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "${ticketProvider.startDate} - ",
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.inputTextColor,
                  fontFamily: AppFontFamily.poppinsRegular,
                ),
              ),
              Text(
                ticketProvider.endDate,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.inputTextColor,
                  fontFamily: AppFontFamily.poppinsRegular,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TicketWidget(
                  width: 350,
                  height: 200,
                  isCornerRounded: true,
                  color: AppColors.primaryColor.withOpacity(0.7),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getTranslated(
                                          context, AppConstant.ticketType)!
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: 14,
                                    fontFamily: AppFontFamily.poppinsMedium,
                                  ),
                                ),
                                Text(
                                  widget.ticketType!.toUpperCase(),
                                  style: const TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 14,
                                    fontFamily: AppFontFamily.poppinsMedium,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${getTranslated(context, AppConstant.quantity)!.toUpperCase()} : ",
                                  style: const TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: 14,
                                    fontFamily: AppFontFamily.poppinsMedium,
                                  ),
                                ),
                                ticketProvider.soldOut != true
                                    ? Text(
                                        ticketProvider.qty.toString(),
                                        style: const TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 14,
                                          fontFamily:
                                              AppFontFamily.poppinsMedium,
                                        ),
                                      )
                                    : Text(
                                        getTranslated(
                                                context, AppConstant.soldOut)
                                            .toString(),
                                        style: const TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 16,
                                          fontFamily:
                                              AppFontFamily.poppinsMedium,
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 120,
                              child: Text(
                                getTranslated(
                                        context, AppConstant.howMuchDoYouWant)
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.blackColor,
                                  fontFamily: AppFontFamily.poppinsLight,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${getTranslated(context, AppConstant.price)!.toUpperCase()} : ",
                                    style: const TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 14,
                                      fontFamily: AppFontFamily.poppinsMedium,
                                    ),
                                  ),
                                  Text(
                                    SharedPreferenceHelper.getString(
                                            Preferences.currencySymbol) +
                                        ticketProvider.price
                                            .toString()
                                            .toUpperCase(),
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 14,
                                      fontFamily: AppFontFamily.poppinsMedium,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${getTranslated(context, AppConstant.time)!.toUpperCase()} : ",
                                    style: const TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 14,
                                      fontFamily: AppFontFamily.poppinsMedium,
                                    ),
                                  ),
                                  Text(
                                    ticketProvider.time,
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 14,
                                      fontFamily: AppFontFamily.poppinsMedium,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        decrement();
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryColor,
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    '$quantity',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.whiteColor,
                                      fontFamily: AppFontFamily.poppinsMedium,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        increment();
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryColor,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              couponCode == '' &&
                      ticketProvider.ticketType.toLowerCase() == "paid"
                  ? InkWell(
                      onTap: () async {
                        result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CouponScreen(
                                finalAmount: totalAmount,
                                eventId: ticketProvider.ticketEventId),
                          ),
                        );

                        if (result != null &&
                            result['discountAmount'] != null &&
                            result['coupon_id'] != null) {
                          discountAmount = result['discountAmount'].toDouble();
                          couponCode = result['promoCode'];
                          couponID = result['coupon_id'];
                        }
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(
                                      context, AppConstant.youHaveCouponToApply)
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.inputTextColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                            Text(
                              getTranslated(context, AppConstant.applyNow)
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.blueColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ticketProvider.ticketType.toLowerCase() == "paid"
                      ? Container(
                          padding: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: AppColors.inputTextColor, width: 0.2),
                          ),
                          child: Text(
                            couponCode,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.inputTextColor,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                          ),
                        )
                      : const SizedBox(),
              const SizedBox(height: 10),
              couponCode != ''
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getTranslated(context, AppConstant.discount)
                              .toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        ),
                        Text(
                          SharedPreferenceHelper.getString(
                                  Preferences.currencySymbol) +
                              discountAmount.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.inputTextColor,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 10),
              ticketProvider.allDay == 0
                  ? InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: selectedDate == null
                                  ? const Text('Ticket Date',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.blackColor,
                                          fontFamily:
                                              AppFontFamily.poppinsMedium))
                                  : Text(DateFormat("MMM dd, yyyy").format(selectedDate!)),
                            ),
                          )),
                    )
                  : const SizedBox(),
              ListView.builder(
                  itemCount: ticketProvider.allTax.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ticketProvider.allTax[index].name!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.blackColor,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                          ),
                          Text(
                            SharedPreferenceHelper.getString(
                                    Preferences.currencySymbol) +
                                ticketProvider.allTax[index].price!.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                          ),
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          if (widget.isSeatMapModuleInstalled == 1 && widget.seatMapId != 0) {
            // TODO: Seat Mapping Module: Step 6: Uncomment Following if you want to add this module
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => SeatingScreen(
            //       eventId: ticketProvider.ticketEventId,
            //       ticketId: ticketProvider.ticketId,
            //       quantity: quantity,
            //       payment: couponCode != '' ? totalAmount - int.parse(discountAmount.toInt().toString()) : totalAmount,
            //       tax: ticketProvider.totalTax.toDouble(),
            //       couponDiscount: discountAmount,
            //       moduleInstall: widget.isSeatMapModuleInstalled,
            //       seatMapId: widget.seatMapId!,
            //     ),
            //   ),
            // );
          } else {
            if (ticketProvider.allDay == 0 &&
                selectedDateController.text.isEmpty) {
              CommonFunction.toastMessage("Please select ticket date");
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentGateway(
                    payment: int.parse(totalAmount.round().toString()),
                    eventId: ticketProvider.ticketEventId,
                    quantity: quantity,
                    couponDiscount: discountAmount,
                    ticketId: ticketProvider.ticketId,
                    tax: ticketProvider.totalTax.toDouble(),
                    ticketType: ticketProvider.ticketType,
                    ticketDate: selectedDateController.text.isNotEmpty
                        ? selectedDateController.text
                        : "",
                    couponId: couponID,
                  ),
                ),
              );
            }
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: 05, right: 05, bottom: 05),
          height: 40,
          child: Button(
              text:
                  "${getTranslated(context, AppConstant.continueKey)} ${totalAmount - discountAmount}"),
        ),
      ),
    );
  }

  DateTime? selectedDate;
  TextEditingController selectedDateController = TextEditingController();

  void _selectDate(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, myState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with selected date
                  Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      child: Text(
                        selectedDate != null
                            ? DateFormat('MMM dd yyyy').format(selectedDate!)
                            : "Select Date",
                        style: const TextStyle(
                            color: AppColors.whiteColor, fontSize: 24),
                      ),
                    ),
                  ),
                  // Table Calendar
                  TableCalendar(
                    calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor.withOpacity(0.5)),
                        selectedDecoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor)),
                    firstDay: DateTime.utc(1900, 1, 1),
                    lastDay: DateTime.utc(2099, 12, 31),
                    focusedDay: selectedDate ?? DateTime.now(),
                    selectedDayPredicate: (day) {
                      return isSameDay(selectedDate, day);
                    },
                    onDaySelected: (selectedStartDate, focusedDay) {
                      setState(() {
                        selectedDate = selectedStartDate;
                      });

                      // Update controller and close modal
                      selectedDateController.text =
                          DateFormat('yyyy-MM-dd').format(selectedStartDate);

                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          });
        });
  }
}
