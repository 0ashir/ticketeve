import 'package:event_right_scanner/DeviceUtil/fonts.dart';
import 'package:event_right_scanner/Screen/Components/field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:event_right_scanner/DeviceUtil/app_string.dart';
import 'package:event_right_scanner/DeviceUtil/palette.dart';
import 'package:event_right_scanner/Providers/event_provider.dart';
import 'package:event_right_scanner/localization/localization_constant.dart';
import 'package:event_right_scanner/main.dart';
import 'package:event_right_scanner/Screen/Event/ticket_detail_screen.dart';

class AttendanceScreen extends StatefulWidget {
  final int? id;

  const AttendanceScreen({
    super.key,
    this.id,
  });

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  TextEditingController search = TextEditingController();

  late EventProvider eventProviderRef;

  @override
  void initState() {
    eventProviderRef = Provider.of<EventProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 0), () {
      eventProviderRef.callApiAttendance(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (_, eventProviderRef, __) {
        return ModalProgressHUD(
          inAsyncCall: eventProviderRef.eventLoader,
          opacity: 0.5,
          progressIndicator: const SpinKitPulse(
            color: Palette.primary,
            size: 50.0,
          ),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Palette.primary,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Palette.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              title: Text(
                  // attendees,
                  getTranslated(context, attendees).toString(),
                  style: const TextStyle(
                      fontSize: 16,
                      color: Palette.white,
                      fontFamily: AppFontFamily.poppinsMedium)),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Field(
                    onChange: onSearchUser,
                      controller: search,
                      label: getTranslated(context, searchHere).toString(),
                      icon: const Icon(Icons.search_outlined),
                      isPassword: false,
                      inputType: TextInputType.emailAddress),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: eventProviderRef.searchAttendanceList.isNotEmpty ||
                            search.text.isNotEmpty
                        ? ListView.builder(
                            itemCount:
                                eventProviderRef.searchAttendanceList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TicketDetailScreen(
                                        id: eventProviderRef
                                            .searchAttendanceList[index].id,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 80.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  eventProviderRef
                                                      .searchAttendanceList[
                                                          index]
                                                      .name!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          color:
                                                              Palette.primary),
                                                ),
                                                Text(
                                                  "#${eventProviderRef.searchAttendanceList[index].ticketNumber!}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        fontSize: 14,
                                                        color: Palette.darkGrey,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          eventProviderRef
                                                      .searchAttendanceList[
                                                          index]
                                                      .status ==
                                                  1
                                              ? const Icon(
                                                  Icons.check_box,
                                                  size: 30,
                                                  color: Palette.green,
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : eventProviderRef.attendanceList.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    eventProviderRef.attendanceList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TicketDetailScreen(
                                            id: eventProviderRef
                                                .attendanceList[index].id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 80.w,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      eventProviderRef
                                                          .attendanceList[index]
                                                          .name!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color: Palette
                                                                  .primary),
                                                    ),
                                                    Text(
                                                      "#${eventProviderRef.attendanceList[index].ticketNumber!}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                            fontSize: 14,
                                                            color: Palette
                                                                .darkGrey,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              eventProviderRef
                                                          .attendanceList[index]
                                                          .status ==
                                                      1
                                                  ? const Icon(
                                                      Icons.check_box,
                                                      size: 30,
                                                      color: Palette.green,
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Divider(
                                            thickness: 1,
                                            color:
                                                Palette.primary.withAlpha(80),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : eventProviderRef.eventLoader == true
                                ? const SizedBox()
                                : const Center(
                                    child: Text("No Data Found"),
                                  ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  onSearchUser(String text) async {
    eventProviderRef.searchAttendanceList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var appointmentData in eventProviderRef.attendanceList) {
      if (appointmentData.ticketNumber!
              .toLowerCase()
              .contains(text.toLowerCase()) ||
          appointmentData.name!.toLowerCase().contains(text.toLowerCase())) {
        eventProviderRef.searchAttendanceList.add(appointmentData);
      }
    }

    setState(() {});
  }
}
