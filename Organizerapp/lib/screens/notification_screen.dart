import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late EventProvider eventProvider;

  Future<void> refresh() async {
    Future.delayed(
      const Duration(seconds: 0),
      () {
        eventProvider.callApiForNotification();
      },
    );
  }

  @override
  void initState() {
    eventProvider = Provider.of<EventProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      eventProvider.callApiForNotification();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(

        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: whiteColor, size: 18),
        ),
        title: Text(
          getTranslated(context, 'notification').toString(),
          style:const  TextStyle(color: whiteColor, fontSize: 16, fontFamily: AppFontFamily.poppinsMedium),
          
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                eventProvider.callApiForDeleteNotification();
                refresh();
              });
            },
            icon: const Icon(
              Icons.delete,
              color: whiteColor,
              size: 18,
            ),
          )
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: eventProvider.notificationLoader,
        progressIndicator: const SpinKitCircle(color: primaryColor),
        offset: Offset(MediaQuery.of(context).size.width * 0.43, MediaQuery.of(context).size.height * 0.35),
        child: RefreshIndicator(
          onRefresh: refresh,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: eventProvider.notificationData.isNotEmpty
                ? ListView.builder(
                    itemCount: eventProvider.notificationData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        shadowColor: primaryColor.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    eventProvider.notificationData[index].title!,
                                    style: const TextStyle(fontSize: 16, color: blackColor),
                                  ),
                                  Text(
                                    DateFormat('dd MMM yyyy').format(
                                      DateTime.parse(eventProvider.notificationData[index].createdAt!),
                                    ),
                                    style: const TextStyle(fontSize: 16, color: blackColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 05),
                              Text(
                                eventProvider.notificationData[index].message!,
                                style: const TextStyle(fontSize: 16, color: inputTextColor),
                              )
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Text(getTranslated(context, 'no_data_found').toString()),
                  ),
          ),
        ),
      ),
    );
  }
}
