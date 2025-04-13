import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/ticket_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class EditTicket extends StatefulWidget {
  const EditTicket({super.key, required this.ticketId});
  final num ticketId;

  @override
  State<EditTicket> createState() => _EditTicketState();
}

class _EditTicketState extends State<EditTicket> {
  late TicketProvider ticketProvider;

  List<String> ticketType = ['Paid', 'Free'];
  List<String> ticketVisibility = ['Visible', 'Hidden'];
  String selectedTicketType = '';
  String selectedTicketVisibility = '';
  int maximumCheckIns = 0;

  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();

  TextEditingController ticketNameController = TextEditingController();
  TextEditingController ticketDescriptionController = TextEditingController();
  TextEditingController ticketHowMuchController = TextEditingController();
  TextEditingController ticketPriceController = TextEditingController();
  TextEditingController ticketPerOrderController = TextEditingController();
  final TextEditingController _maxCheckInsController = TextEditingController();

  @override
  void initState() {
    ticketProvider = Provider.of<TicketProvider>(context, listen: false);

    Future.delayed(Duration.zero, () {
      ticketNameController.text = ticketProvider.ticketName;
      ticketDescriptionController.text = ticketProvider.ticketDescription;
      ticketHowMuchController.text = ticketProvider.howMuchTicket.toString();
      ticketPriceController.text = ticketProvider.ticketPrice.toString();
      ticketPerOrderController.text = ticketProvider.ticketPerOrder.toString();
      selectedTicketType = ticketProvider.ticketType == 'Paid' ? "Paid" : "Free";
      selectedTicketVisibility = ticketProvider.visibility == 1 ? "Visible" : "Hidden";
      _maxCheckInsController.text = ticketProvider.maximumCheckIns.toString();
      startDate = DateTime.parse(ticketProvider.startTime);
      endDate = DateTime.parse(ticketProvider.endTime);
    });
    super.initState();
  }

  @override
  void dispose() {
    ticketNameController.dispose();
    ticketDescriptionController.dispose();
    ticketHowMuchController.dispose();
    ticketPriceController.dispose();
    ticketPerOrderController.dispose();
    _maxCheckInsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ticketProvider = Provider.of<TicketProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          getTranslated(context, 'edit_tickets').toString(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              onPressed: () {
                if (ticketNameController.text.isNotEmpty &&
                    ticketDescriptionController.text.isNotEmpty &&
                    ticketHowMuchController.text.isNotEmpty &&
                    ticketPriceController.text.isNotEmpty &&
                    ticketPerOrderController.text.isNotEmpty &&
                    selectedTicketType.isNotEmpty &&
                    selectedTicketVisibility.isNotEmpty &&
                    _maxCheckInsController.text.isNotEmpty) {
                  Map<String, dynamic> body = {
                    "id": widget.ticketId,
                    "name": ticketNameController.text,
                    "description": ticketDescriptionController.text,
                    "quantity": ticketHowMuchController.text,
                    "price": ticketPriceController.text,
                    "start_date": DateFormat('yyyy-MM-dd').format(startDate!),
                    "end_date": DateFormat('yyyy-MM-dd').format(endDate!),
                    "type": selectedTicketType,
                    "ticket_per_order": ticketPerOrderController.text,
                    "visibility": selectedTicketVisibility,
                    "maximum_checkins": _maxCheckInsController.text == '0' ? null : _maxCheckInsController.text,
                  };
                  ticketProvider.callApiForEditTicket(body);
                } else {
                  Fluttertoast.showToast(msg: getTranslated(context, 'please_fill_all_details').toString());
                }
              },
              icon: const Icon(CupertinoIcons.check_mark_circled_solid, color: whiteColor, size: 20),
            ),
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: ticketProvider.ticketDetailsLoader,
        progressIndicator: const SpinKitCircle(color: primaryColor),
        offset: Offset(MediaQuery.of(context).size.width * 0.43, MediaQuery.of(context).size.height * 0.35),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTranslated(context, 'ticket_name').toString(),
                  style: const TextStyle(fontSize: 14, color: blackColor),
                ),
                TextFormField(
                  controller: ticketNameController,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: getTranslated(context, 'enter_ticket_name').toString(),
                    hintStyle: const TextStyle(color: inputTextColor, fontSize: 16),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, 'please_enter_ticket_name').toString();
                    }
                    return null;
                  },
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 05),
                Text(
                  getTranslated(context, 'description').toString(),
                  style: const TextStyle(fontSize: 14, color: blackColor),
                ),
                TextFormField(
                  controller: ticketDescriptionController,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: getTranslated(context, 'optional_details').toString(),
                    hintStyle: const TextStyle(color: inputTextColor, fontSize: 16),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, 'please_enter_optional_details').toString();
                    }
                    return null;
                  },
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 05),
                Text(
                  getTranslated(context, 'maximum_checkIns_allowed').toString(),
                  style: const TextStyle(fontSize: 14, color: blackColor),
                ),
                TextFormField(
                  controller: _maxCheckInsController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: getTranslated(context, 'set_0_for_unlimited_check_ins').toString(),
                    hintStyle: const TextStyle(color: inputTextColor, fontSize: 16),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, 'required').toString();
                    }
                    return null;
                  },
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 05),
                Text(
                  getTranslated(context, 'how_much_ticket').toString(),
                  style: const TextStyle(fontSize: 14, color: blackColor),
                ),
                TextFormField(
                  controller: ticketHowMuchController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "0",
                    hintStyle: TextStyle(color: inputTextColor, fontSize: 16),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, 'please_enter_how_much').toString();
                    }
                    return null;
                  },
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 05),
                Text(
                  getTranslated(context, 'price').toString(),
                  style: const TextStyle(fontSize: 14, color: blackColor),
                ),
                TextFormField(
                  controller: ticketPriceController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: getTranslated(context, 'price').toString(),
                    hintStyle: const TextStyle(color: inputTextColor, fontSize: 16),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, 'please_enter_price').toString();
                    }
                    return null;
                  },
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslated(context, 'sales_start').toString(),
                          style: const TextStyle(fontSize: 16, color: blackColor),
                        ),
                        InkWell(
                          onTap: () {
                            _modalBottomSheetStartDate();
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month, color: inputTextColor, size: 20),
                              const SizedBox(width: 10),
                              Text(
                                DateFormat('MMM dd yyyy').format(startDate!),
                                style: const TextStyle(fontSize: 16, color: inputTextColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslated(context, 'sales_end').toString(),
                          style: const TextStyle(fontSize: 16, color: blackColor),
                        ),
                        InkWell(
                          onTap: () {
                            _modalBottomSheetEndDate();
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month, color: inputTextColor, size: 20),
                              const SizedBox(width: 10),
                              Text(
                                DateFormat('MMM dd yyyy').format(endDate!),
                                style: const TextStyle(fontSize: 16, color: inputTextColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 05),
                Text(
                  getTranslated(context, 'ticket_visibility').toString(),
                  style: const TextStyle(fontSize: 14, color: blackColor),
                ),
                const SizedBox(height: 05),
                InkWell(
                  onTap: () {
                    _modalBottomSheetTicketVisibility();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      selectedTicketVisibility == ''
                          ? Text(
                              getTranslated(context, 'select_visibility').toString(),
                              style: const TextStyle(fontSize: 14, color: inputTextColor),
                            )
                          : Text(
                              selectedTicketVisibility,
                              style: const TextStyle(fontSize: 14, color: inputTextColor),
                            ),
                      const Icon(Icons.keyboard_arrow_down_outlined, size: 25, color: inputTextColor)
                    ],
                  ),
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 05),
                Text(
                  getTranslated(context, 'ticket_per_order').toString(),
                  style: const TextStyle(fontSize: 14, color: blackColor),
                ),
                TextFormField(
                  controller: ticketPerOrderController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: getTranslated(context, 'ticket_per_order').toString(),
                    hintStyle: const TextStyle(color: inputTextColor, fontSize: 16),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, 'please_enter_ticket_per_order').toString();
                    }
                    return null;
                  },
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 05),
                Text(
                  getTranslated(context, 'event_type').toString(),
                  style: const TextStyle(fontSize: 14, color: blackColor),
                ),
                InkWell(
                  onTap: () {
                    _modalBottomSheetSelectType();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      selectedTicketType != ''
                          ? Text(
                              selectedTicketType,
                              style: const TextStyle(fontSize: 14, color: inputTextColor),
                            )
                          : const Text(
                              "Select Ticket Type",
                              style: TextStyle(fontSize: 14, color: inputTextColor),
                            ),
                      const Icon(Icons.keyboard_arrow_down_outlined, size: 25, color: inputTextColor)
                    ],
                  ),
                ),
                const Divider(thickness: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetSelectType() {
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
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 60.0,
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          getTranslated(context, 'select_any_one').toString(),
                          style: const TextStyle(color: whiteColor, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  ListView.separated(
                    itemCount: ticketType.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedTicketType = ticketType[index];
                            Navigator.pop(context);
                            setState(() {});
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            ticketType[index],
                            style: const TextStyle(fontSize: 18, color: blackColor),
                          )),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(thickness: 1);
                    },
                  )
                ],
              ),
            );
          });
        });
  }

  void _modalBottomSheetTicketVisibility() {
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
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 60.0,
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          getTranslated(context, 'select_any_one').toString(),
                          style: const TextStyle(color: whiteColor, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  ListView.separated(
                    itemCount: ticketVisibility.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedTicketVisibility = ticketVisibility[index];
                            Navigator.pop(context);
                            setState(() {});
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            ticketVisibility[index],
                            style: const TextStyle(fontSize: 18, color: blackColor),
                          )),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(thickness: 1);
                    },
                  )
                ],
              ),
            );
          });
        });
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
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 45.0,
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          DateFormat('MMM dd yyyy').format(startDate!),
                          style: const TextStyle(color: whiteColor, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  TableCalendar(
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
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 45.0,
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          DateFormat('MMM dd yyyy').format(endDate!),
                          style: const TextStyle(color: whiteColor, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  TableCalendar(
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
}
