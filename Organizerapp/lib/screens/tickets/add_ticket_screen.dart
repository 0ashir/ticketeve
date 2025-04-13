import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/common_function.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/ticket_provider.dart';
import 'package:eventright_organizer/screens/components/button.dart';
import 'package:eventright_organizer/screens/components/field.dart';
import 'package:eventright_organizer/screens/tickets/tickets_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../constant/font_constant.dart';

class AddTicket extends StatefulWidget {
  final int eventId;

  const AddTicket({super.key, required this.eventId});

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  List<String> ticketType = ['Paid', 'Free'];
  List<String> ticketVisibility = ['Visible', 'Hidden'];
  String selectedTicketType = '';
  String selectedTicketVisibility = '';

  late TicketProvider ticketProvider;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController ticketNameController = TextEditingController();
  TextEditingController ticketDescriptionController = TextEditingController();
  TextEditingController ticketHowMuchController = TextEditingController();
  TextEditingController ticketPriceController = TextEditingController();
  TextEditingController ticketPerOrderController = TextEditingController();
  final TextEditingController _maxCheckInsController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    ticketProvider = Provider.of(context, listen: false);
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

    return ModalProgressHUD(
      inAsyncCall: ticketProvider.addTicketsLoader,
    progressIndicator: const SpinKitCircle(color: primaryColor),
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            getTranslated(context, 'tickets').toString(),
            style: const TextStyle(fontSize: 16, color: whiteColor, fontFamily: AppFontFamily.poppinsMedium),
          ),
          
        ),
        bottomNavigationBar:             InkWell(
              onTap: () {
                if (_formkey.currentState!.validate() && startDate!=null &&endDate!=null) {
                  Map<String, dynamic> body = {
                    "name": ticketNameController.text,
                    "event_id": widget.eventId,
                    "quantity": ticketHowMuchController.text,
                    "start_date": DateFormat('yyyy-MM-dd').format(startDate!),
                    "end_date": DateFormat('yyyy-MM-dd').format(endDate!),
                    "start_time":DateFormat('hh:mm a').format(startDate!),
                    "end_time":DateFormat('hh:mm a').format(endDate!),
                    "type": selectedTicketType,
                    "ticket_per_order": ticketPerOrderController.text,
                    "description": ticketDescriptionController.text,
                    "price": ticketPriceController.text,
                    "status": selectedTicketVisibility == "Visible" ? 1 : 0,
                    "maximum_checkins": _maxCheckInsController.text == '0'
                        ? null
                        : _maxCheckInsController.text,
                  };
                  ticketProvider.callApiForAddTicket(body).then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TicketScreen(eventId: widget.eventId),
                        ));
                  });
                } else if (selectedTicketVisibility == '') {
                  CommonFunction.toastMessage(
                    getTranslated(context, 'please_select_ticket_visibility')
                        .toString(),
                  );
                } else if (selectedTicketType == '') {
                  CommonFunction.toastMessage(
                    getTranslated(context, 'please_select_ticket_type')
                        .toString(),
                  );
                }else if(startDate  ==null || endDate==null){
                  CommonFunction.toastMessage(
                    "Please set Ticket timings.",
                  );

                }
              },
              child:Container(
                height: 40,
                margin: const EdgeInsets.all(12),
                child: const  Button(text: 'ADD TICKET'))
            ),
         
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child:  Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Field(
                          controller: ticketNameController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return getTranslated(
                                      context, 'please_enter_ticket_name')
                                  .toString();
                            }
                            return null;
                          },
                          label: getTranslated(context, 'ticket_name').toString(),
                          icon: const Icon(Icons.local_activity_outlined),
                          isPassword: false,
                          inputType: TextInputType.name),
                      const SizedBox(height: 10),
                      Field(
                          controller: ticketDescriptionController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return getTranslated(
                                      context, 'please_enter_optional_details')
                                  .toString();
                            }
                            return null;
                          },
                          label: getTranslated(context, 'description').toString(),
                          icon: const Icon(Icons.description_outlined),
                          isPassword: false,
                          inputType: TextInputType.text),
                      const SizedBox(height: 10),
                      Field(
                        controller: _maxCheckInsController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return getTranslated(context, 'required').toString();
                          }
                          return null;
                        },
                        label: getTranslated(context, 'maximum_checkIns_allowed')
                            .toString(),
                        icon: const Icon(Icons.people_alt_outlined),
                        isPassword: false,
                        inputType: TextInputType.number,
                        inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                      ),
                      const SizedBox(height: 10),
                      Field(
                          controller: ticketHowMuchController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return getTranslated(context, 'please_enter_how_much')
                                  .toString();
                            }
                            return null;
                          },
                          label: getTranslated(context, 'how_much_ticket').toString(),
                          icon: const Icon(Icons.local_activity_outlined),
                          isPassword: false,
                          inputType: TextInputType.number),
                      const SizedBox(height: 10),
                      Field(
                          controller: ticketPriceController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return getTranslated(context, 'please_enter_price')
                                  .toString();
                            }
                            return null;
                          },
                          label: getTranslated(context, 'price').toString(),
                          icon: const Icon(Icons.price_change_outlined),
                          isPassword: false,
                          inputType: TextInputType.number),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                startDate = DateTime.now();
                                _modalBottomSheetStartDate();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12)),
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 45,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_month,
                                        color: inputTextColor, size: 18),
                                    const SizedBox(width: 10),
                                    Text(
                                      startDate == null
                                          ? getTranslated(context, 'sales_start')
                                              .toString()
                                          : DateFormat('yyyy-MM-dd')
                                              .format(startDate!),
                                      style: const TextStyle(
                                          fontSize: 16, color: inputTextColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                endDate = DateTime.now();
                                _modalBottomSheetEndDate();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12)),
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 45,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_month,
                                        color: inputTextColor, size: 18),
                                    const SizedBox(width: 10),
                                    Text(
                                      endDate == null
                                          ? getTranslated(context, 'sales_end')
                                              .toString()
                                          : DateFormat('yyyy-MM-dd').format(endDate!),
                                      style: const TextStyle(
                                          fontSize: 16, color: inputTextColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Field(
                        controller: ticketPerOrderController,
                        label: getTranslated(context, 'ticket_per_order').toString(),
                        icon: const Icon(Icons.topic_outlined),
                        isPassword: false,
                        inputType: TextInputType.number,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return getTranslated(
                                    context, 'please_enter_ticket_per_order')
                                .toString();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 48,
                        decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12)),
                        child: DropDownTextField(
                          listBorderColor: whiteColor,
                          listBgColor: whiteColor,
                          clearOption: true,
                          clearIconProperty: IconProperty(color: primaryColor),
                          searchTextStyle: const TextStyle(color: Colors.red),
                          searchDecoration:
                              const InputDecoration(hintText: "Search by Type"),
                          listTextStyle: const TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                          textFieldDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 20),
                              label: Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                        getTranslated(context, 'select_visibility')
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                          fontFamily: AppFontFamily.poppinsMedium,
                                        ),
                                      )
                                   
                              ),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: primaryColor))),
                          validator: (value) {
                            if (value == null) {
                              return "Required field";
                            } else {
                              return null;
                            }
                          },
                          dropDownItemCount: 5,
                          dropDownList: const [
                            DropDownValueModel(name: 'Visible', value: "Visible"),
                            DropDownValueModel(name: 'Hidden', value: "Hidden"),
                          ],
                          onChanged: (val) {
                            try {
                              DropDownValueModel model = val as DropDownValueModel;
                              debugPrint("Value is ${model.value}");
                
                              setState(() {
                                selectedTicketVisibility = model.value;
                              });
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                        ),
                      ),
                       const SizedBox(height: 10),
                       Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 48,
                        decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12)),
                        child: DropDownTextField(
                          listBorderColor: whiteColor,
                          listBgColor: whiteColor,
                          clearOption: true,
                          clearIconProperty: IconProperty(color: primaryColor),
                          searchTextStyle: const TextStyle(color: Colors.red),
                          searchDecoration:
                              const InputDecoration(hintText: "Search by Type"),
                          listTextStyle: const TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                          textFieldDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 20),
                              label: Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                      getTranslated(context, 'ticket_type').toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                          fontFamily: AppFontFamily.poppinsMedium,
                                        ),
                                      )
                                   
                              ),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: primaryColor))),
                          validator: (value) {
                            if (value == null) {
                              return "Required field";
                            } else {
                              return null;
                            }
                          },
                          dropDownItemCount: 5,
                          dropDownList: const [
                            DropDownValueModel(name: 'Paid', value: "Paid"),
                            DropDownValueModel(name: 'Free', value: "Free"),
                          ],
                          onChanged: (val) {
                            try {
                              DropDownValueModel model = val as DropDownValueModel;
                              debugPrint("Value is ${model.value}");
                
                              setState(() {
                                selectedTicketType = model.value;
                              });
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                        ),
                      ),
                      
                ],
                  ),
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

}
