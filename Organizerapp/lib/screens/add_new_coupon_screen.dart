import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/coupon_provider.dart';
import 'package:eventright_organizer/screens/components/button.dart';
import 'package:eventright_organizer/screens/components/desc_field.dart';
import 'package:eventright_organizer/screens/components/field.dart';
import 'package:eventright_organizer/screens/coupons_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../constant/font_constant.dart';

class AddNewCoupon extends StatefulWidget {
  const AddNewCoupon({super.key});

  @override
  State<AddNewCoupon> createState() => _AddNewCouponState();
}

class _AddNewCouponState extends State<AddNewCoupon> {
  late CouponProvider couponProvider;

  List<String> discountType = ['Percentage', 'Amount'];
  int? value;

  final TextEditingController _couponNameController = TextEditingController();
  final TextEditingController _couponDiscountController =
      TextEditingController();
  final TextEditingController _couponUseController = TextEditingController();
  final TextEditingController _couponDescriptionController =
      TextEditingController();
  final TextEditingController _minimumAmountController =
      TextEditingController();
  final TextEditingController _maximumAmountController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedEventName = '';
  int _eventId = 0;
  int? _discountValue;

  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();

  @override
  void initState() {
    couponProvider = Provider.of<CouponProvider>(context, listen: false);

    Future.delayed(Duration.zero, () {
      couponProvider.callApiForCouponEvent();
    });
    super.initState();
  }

  @override
  void dispose() {
    _couponNameController.dispose();
    _couponDiscountController.dispose();
    _couponUseController.dispose();
    _couponDescriptionController.dispose();
    _minimumAmountController.dispose();
    _maximumAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    couponProvider = Provider.of<CouponProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(getTranslated(context, 'add_new_coupon').toString(),
            style: const TextStyle(
                fontSize: 16,
                color: whiteColor,
                fontFamily: AppFontFamily.poppinsMedium)),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Field(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return getTranslated(
                                context, 'please_enter_coupon_name')
                            .toString();
                      }
                      return null;
                    },
                    controller: _couponNameController,
                    label: getTranslated(context, 'coupon_name').toString(),
                    icon: const Icon(Icons.confirmation_number_outlined),
                    isPassword: false,
                    inputType: TextInputType.name),

                const SizedBox(height: 10),
                SizedBox(
                  width: width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _modalBottomSheetStartDate();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12)),
                          width: width * 0.4,
                          height: 45,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month,
                                  color: inputTextColor, size: 18),
                              const SizedBox(width: 10),
                              Text(
                                DateFormat('yyyy-MM-dd').format(startDate!),
                                style: const TextStyle(
                                    fontSize: 16, color: inputTextColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _modalBottomSheetEndDate();
                        },
                        child: Container(
                          width: width * 0.4,
                          decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12)),
                          height: 45,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month,
                                  color: inputTextColor, size: 18),
                              const SizedBox(width: 10),
                              Text(
                                DateFormat('yyyy-MM-dd').format(endDate!),
                                style: const TextStyle(
                                    fontSize: 16, color: inputTextColor),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    _modalBottomSheetEvents();
                  },
                  child: Container(
                    height: 45,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        selectedEventName == ''
                            ? Text(
                                getTranslated(context, 'select_your_event')
                                    .toString(),
                                style: const TextStyle(
                                    fontFamily: AppFontFamily.poppinsMedium,
                                    fontSize: 14,
                                    color: blackColor),
                              )
                            : Text(
                                selectedEventName!,
                                style: const TextStyle(
                                    fontSize: 14, color: inputTextColor),
                              )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                DescField(
                    controller: _couponDescriptionController,
                    label: getTranslated(context, 'description').toString()),
                const SizedBox(height: 10),
                Field(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return getTranslated(
                                context, 'please_enter_minimum_amount')
                            .toString();
                      }
                      return null;
                    },
                    controller: _minimumAmountController,
                    label: getTranslated(context, 'minimum_amount').toString(),
                    icon: const Icon(Icons.price_change_outlined),
                    isPassword: false,
                    inputType: TextInputType.number),

                const SizedBox(height: 10),
                Field(
                    controller: _maximumAmountController,
                    label: getTranslated(context, 'maximum_amount').toString(),
                    icon: const Icon(Icons.price_change_outlined),
                    isPassword: false,
                    inputType: TextInputType.number),

                const SizedBox(height: 10),
                Field(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return getTranslated(
                                context, 'please_enter_how_many_times')
                            .toString();
                      }
                      return null;
                    },
                    controller: _couponUseController,
                    label: getTranslated(context, 'how_many_times').toString(),
                    icon: const Icon(Icons.insert_chart_outlined_rounded),
                    isPassword: false,
                    inputType: TextInputType.number),

                const SizedBox(height: 10),
                Field(controller: _couponDiscountController, label: getTranslated(context, 'discount').toString(), icon: const Icon(Icons.price_change_outlined), isPassword: false, inputType: TextInputType.number),
                
                
                const SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: width * 0.05),
                  alignment: Alignment.topLeft,
                  child: Text(
                    getTranslated(context, 'discount_type').toString(),
                    style: const TextStyle(fontSize: 15, color: blackColor, fontFamily: AppFontFamily.poppinsMedium ),
                  ),
                ),
                const SizedBox(height: 05),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: discountType.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      activeColor: primaryColor,
                      dense: true,
                      value: index,
                      groupValue: _discountValue,
                      onChanged: (int? reason) {
                        setState(() {
                          _discountValue = reason!.toInt();
                          setState(() {});
                        });
                      },
                      title: Text(
                        discountType[index],style:const TextStyle(fontSize: 12, fontFamily: AppFontFamily.poppinsMedium, color: blackColor),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                // Save Button
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> body = {
                        "name": _couponNameController.text,
                        "event_id": _eventId,
                        "discount": _couponDiscountController.text,
                        "start_date":
                            DateFormat('yyyy-MM-dd').format(startDate!),
                        "end_date": DateFormat('yyyy-MM-dd').format(endDate!),
                        "max_use": _couponUseController.text,
                        "description": _couponDescriptionController.text,
                        "discount_type": _discountValue,
                        "minimum_amount": _minimumAmountController.text,
                        "maximum_discount": _maximumAmountController.text
                      };
                      couponProvider.callApiForAddCoupon(body).then((value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Coupons(),
                            ));
                      });
                    }
                  },
                  child: 
                  Button(text: getTranslated(context, 'save').toString())
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetStartDate() {
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
                  Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      child: Text(
                        DateFormat('MMM dd yyyy').format(startDate!),
                        style: const TextStyle(color: whiteColor, fontSize: 24),
                      ),
                    ),
                  ),
                  TableCalendar(
                    calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor.withOpacity(0.5)),
                        selectedDecoration: const BoxDecoration(
                            shape: BoxShape.circle, color: primaryColor)),
                    firstDay: DateTime.utc(1900, 1, 1),
                    lastDay: DateTime.utc(2099, 12, 31),
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      return isSameDay(startDate, day);
                    },
                    onDaySelected: (selectedStartDate, focusedDay) {
                      setState(() {
                        startDate = selectedStartDate;
                        Navigator.pop(context);
                        myState(() {});
                      });
                    },
                  ),
                ],
              ),
            );
          });
        });
  }

  void _modalBottomSheetEndDate() {
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
                  Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      child: Text(
                        DateFormat('MMM dd yyyy').format(endDate!),
                        style: const TextStyle(color: whiteColor, fontSize: 24),
                      ),
                    ),
                  ),
                  TableCalendar(
                    calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor.withOpacity(0.5)),
                        selectedDecoration: const BoxDecoration(
                            shape: BoxShape.circle, color: primaryColor)),
                    firstDay: DateTime.utc(1900, 1, 1),
                    lastDay: DateTime.utc(2099, 12, 31),
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      return isSameDay(endDate, day);
                    },
                    onDaySelected: (selectEndDate, focusedDay) {
                      setState(() {
                        endDate = selectEndDate;
                        Navigator.pop(context);
                        myState(() {});
                      });
                    },
                  ),
                ],
              ),
            );
          });
        });
  }

  void _modalBottomSheetEvents() {
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
                  Container(
                    color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                        child: Text(
                          getTranslated(context, 'events').toString(),
                          style:
                              const TextStyle(color: whiteColor, fontSize: 24, fontFamily: AppFontFamily.poppinsMedium),
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: couponProvider.couponEventsData.length,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        value: index,
                        groupValue: value,
                        onChanged: (int? reason) {
                          myState(() {
                            value = reason!.toInt();
                            _eventId = couponProvider
                                .couponEventsData[index].id!
                                .toInt();
                            selectedEventName =
                                couponProvider.couponEventsData[index].name;
                            Navigator.pop(context);
                            setState(() {});
                          });
                        },
                        activeColor: primaryColor,
                        title: Text(
                          couponProvider.couponEventsData[index].name!,
                          style: const TextStyle(color: blackColor, fontFamily: AppFontFamily.poppinsMedium, fontSize: 14),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          });
        });
  }
}
