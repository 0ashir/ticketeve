import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/events_provider.dart';
import 'package:eventright_pro_user/screens/home_screen.dart';
import 'package:eventright_pro_user/utilities/extension_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum EventDates { anytime, today, tomorrow, date }

class GoOut extends StatefulWidget {
  const GoOut({super.key});

  @override
  State<GoOut> createState() => _GoOutState();
}

class _GoOutState extends State<GoOut> {
  List<String> goOutData = [];

  DateTime? selectedDate;
  EventDates? selectedEventDateEnum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(index: 0),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.blackColor,
            size: 18,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                getTranslated(context, AppConstant.whenDoYouWantToGoOut)
                    .toString(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                  fontFamily: AppFontFamily.poppinsMedium,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            ListView.builder(
                shrinkWrap: true,
                itemCount: EventDates.values.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      setState(() {
                        switch (EventDates.values[index]) {
                          case EventDates.anytime:
                            selectedDate = null;
                            selectedEventDateEnum = EventDates.anytime;
                            break;
                          case EventDates.today:
                            selectedDate = DateTime.now();
                            selectedEventDateEnum = EventDates.today;
                            break;
                          case EventDates.tomorrow:
                            selectedDate =
                                DateTime.now().add(const Duration(days: 1));
                            selectedEventDateEnum = EventDates.tomorrow;
                            break;
                          case EventDates.date:
                            selectedEventDateEnum = EventDates.date;
                            selectedDate = DateTime.now();
                            showDatePicker();
                            break;
                          default:
                            selectedDate = null;
                            break;
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 1,
                            color: selectedEventDateEnum ==
                                    EventDates.values[index]
                                ? AppColors.inputTextColor
                                : Colors.transparent,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          selectedEventDateEnum == EventDates.date &&
                                  EventDates.values[index] == EventDates.date
                              ? selectedDate!.toFormattedDate() ?? "Date"
                              : EventDates.values[index].name.toTitleCase(),
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.blackColor,
                            fontWeight: selectedEventDateEnum ==
                                    EventDates.values[index]
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: ()async {
          final eventProvider = context.read<EventProvider>();
          eventProvider.filterEventsByDay(selectedDate)
;
          Navigator.pop(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(index: 0),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: Text(
            getTranslated(context, AppConstant.next).toString(),
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 16,
              fontFamily: AppFontFamily.poppinsMedium,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              minimumDate: DateTime.now(),
              onDateTimeChanged: (value) {
                if (value != selectedDate) {
                  setState(() {
                    selectedDate = value;
                  });
                }
              },
              initialDateTime: DateTime.now(),
            ),
          );
        });
  }
}
