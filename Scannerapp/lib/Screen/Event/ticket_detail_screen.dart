import 'package:event_right_scanner/DeviceUtil/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:event_right_scanner/DeviceUtil/app_string.dart';
import 'package:event_right_scanner/DeviceUtil/palette.dart';
import 'package:event_right_scanner/Providers/event_provider.dart';
import 'package:event_right_scanner/localization/localization_constant.dart';

class TicketDetailScreen extends StatefulWidget {
  final int? id;

  const TicketDetailScreen({
    super.key,
    this.id,
  });

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  late EventProvider eventProviderRef;

  @override
  void initState() {
    eventProviderRef = Provider.of<EventProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 0), () {
      eventProviderRef.callApiTicketDetail(widget.id);
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
              backgroundColor: Palette.primary,
              automaticallyImplyLeading: false,
              elevation: 0,
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
                // ticketDetail,
                getTranslated(context, ticketDetail).toString(),
                style: const TextStyle(fontSize: 16, color: Palette.white, fontFamily: AppFontFamily.poppinsMedium)
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    eventProviderRef.name,
                    style: const TextStyle(color: Palette.black, fontSize: 18, fontFamily: AppFontFamily.poppinsMedium)
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: eventProviderRef.ticketStartTime,
                          style: const TextStyle(color: Palette.darkGrey, fontSize: 14, fontFamily: AppFontFamily.poppinsRegular)
                        ),
                   const     TextSpan(
                          text: " To ",
                          style:  TextStyle(color: Palette.primary, fontSize: 16, fontFamily: AppFontFamily.poppinsMedium)
                        ),
                        TextSpan(
                          text: eventProviderRef.ticketEndTime,
                          style: const TextStyle(color: Palette.darkGrey, fontSize: 14, fontFamily: AppFontFamily.poppinsRegular)
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // ticketNumber,
                        getTranslated(context, ticketNumber).toString(),
                        style: const TextStyle(color: Palette.darkGrey, fontSize: 14, fontFamily: AppFontFamily.poppinsMedium)
                      ),
                      Text(
                        "#${eventProviderRef.ticketNumber}",
                        style: const TextStyle(color: Palette.black, fontSize: 16, fontFamily: AppFontFamily.poppinsMedium)
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // owner,
                        getTranslated(context, owner).toString(),
                        style: const TextStyle(color: Palette.darkGrey, fontSize: 14, fontFamily: AppFontFamily.poppinsMedium)
                      ),
                      Text(
                        eventProviderRef.name,
                        style: const TextStyle(color: Palette.black, fontSize: 16, fontFamily: AppFontFamily.poppinsMedium)
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // ticketType,
                        getTranslated(context, ticketType).toString(),
                        style: const TextStyle(color: Palette.darkGrey, fontSize: 14, fontFamily: AppFontFamily.poppinsMedium)
                      ),
                      Text(
                        eventProviderRef.ticketType,
                        style: const TextStyle(color: Palette.black, fontSize: 16, fontFamily: AppFontFamily.poppinsMedium)
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
