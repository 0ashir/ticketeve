import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:event_right_scanner/DeviceUtil/fonts.dart';
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
import 'package:event_right_scanner/Screen/Home/home_screen.dart';
import 'package:event_right_scanner/Screen/Event/attendance_screen.dart';
import 'package:event_right_scanner/Screen/Event/scanner_screen.dart';
import 'package:flutter_html/flutter_html.dart';

class EventDetail extends StatefulWidget {
  final int? id;

  const EventDetail({
    super.key,
    this.id,
  });

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  late EventProvider eventProviderRef;

  @override
  void initState() {
    eventProviderRef = Provider.of<EventProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 0), () {
      eventProviderRef.callApiEventDetail(widget.id);
    });
    super.initState();
  }

  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  final ValueNotifier<double> _valueNotifier1 = ValueNotifier(0);

  Future<bool> onWillPop() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
    return Future.value(true);
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
          child: PopScope(
            canPop: true,
            onPopInvoked: (didPop) => onWillPop,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
                centerTitle: true,
                title: Text(
                  // eventDetail,
                  getTranslated(context, eventDetail).toString(),
                  style: const TextStyle(
                    color: Palette.white,
                    fontFamily: AppFontFamily.poppinsMedium,
                    fontSize: 16,
                  ),
                ),
              ),
              body: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(
                  children: [
                    eventProviderRef.eventDetailBannerList.isNotEmpty
                        ? SizedBox(
                            height: 200,
                            width: 100.w,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 2,
                                  viewportFraction: 1,
                                  autoPlayCurve: Curves.easeInToLinear,
                                  enlargeCenterPage: false,
                                  onPageChanged: (index, reason) {
                                    setState(() {});
                                  }),
                              items: eventProviderRef.eventDetailBannerList
                                  .map((imageObject) {
                                return CachedNetworkImage(
                                  imageUrl: imageObject,
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 100.w,
                                  placeholder: (context, url) =>
                                      const SpinKitFadingCircle(
                                          color: Palette.primary),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    "assets/images/NoImage.png",
                                    height: 200,
                                    width: 100.w,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eventProviderRef.eventName,
                            style:
                              const  TextStyle(color: Palette.primary, fontFamily: AppFontFamily.poppinsMedium, fontSize: 18
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Html(
                            data: eventProviderRef.eventDescription,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: eventProviderRef.startTime,
                                  style: const TextStyle(color: Palette.darkGrey, fontSize: 14, fontFamily: AppFontFamily.poppinsRegular)
                                ),
                               const  TextSpan(
                                  text: "  To  ",
                                  style:  TextStyle(color: Palette.primary, fontSize: 16, fontFamily: AppFontFamily.poppinsMedium)
                                ),
                                TextSpan(
                                  text: eventProviderRef.endTime,
                                  style: const TextStyle(color: Palette.darkGrey, fontSize: 14, fontFamily: AppFontFamily.poppinsRegular)
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              eventProviderRef.totalTicket != 0
                                  ? SizedBox(
                                      width: 40.w,
                                      child: Column(
                                        children: [
                                          Text(
                                            // totalTicketSales,
                                            getTranslated(
                                                    context, totalTicketSales)
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 150,
                                            height: 150,
                                            child: DashedCircularProgressBar
                                                .aspectRatio(
                                              aspectRatio: 1,
                                              valueNotifier: _valueNotifier,
                                              maxProgress: eventProviderRef
                                                  .totalTicket
                                                  .toDouble(),
                                              progress: eventProviderRef
                                                  .soldTicket
                                                  .toDouble(),
                                              startAngle: 0,
                                              sweepAngle: 360,
                                              foregroundColor: Palette.primary,
                                              backgroundColor: Palette.grey,
                                              foregroundStrokeWidth: 10,
                                              backgroundStrokeWidth: 10,
                                              animation: true,
                                              seekSize: 5,
                                              seekColor: Palette.white,
                                              child: Center(
                                                child: ValueListenableBuilder(
                                                  valueListenable:
                                                      _valueNotifier,
                                                  builder:
                                                      (_, double value, __) =>
                                                          Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        eventProviderRef
                                                            .soldTicket
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(),
                                                      ),
                                                      Text(
                                                        eventProviderRef
                                                            .totalTicket
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                color: Palette
                                                                    .darkGrey),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              eventProviderRef.soldTicket != 0
                                  ? SizedBox(
                                      width: 40.w,
                                      child: Column(
                                        children: [
                                          Text(
                                            // attendance,
                                            getTranslated(context, attendance)
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 150,
                                            height: 150,
                                            child: DashedCircularProgressBar
                                                .aspectRatio(
                                              aspectRatio: 1,
                                              valueNotifier: _valueNotifier1,
                                              maxProgress: eventProviderRef
                                                  .soldTicket
                                                  .toDouble(),
                                              progress: eventProviderRef
                                                  .scanTicket
                                                  .toDouble(),
                                              startAngle: 0,
                                              sweepAngle: 360,
                                              foregroundColor: Palette.primary,
                                              backgroundColor: Palette.grey,
                                              foregroundStrokeWidth: 10,
                                              backgroundStrokeWidth: 10,
                                              animation: true,
                                              seekSize: 5,
                                              seekColor: Palette.white,
                                              child: Center(
                                                child: ValueListenableBuilder(
                                                  valueListenable:
                                                      _valueNotifier1,
                                                  builder:
                                                      (_, double value, __) =>
                                                          Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        eventProviderRef
                                                            .scanTicket
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(),
                                                      ),
                                                      Text(
                                                        eventProviderRef
                                                            .soldTicket
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                color: Palette
                                                                    .darkGrey),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: SizedBox(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScannerScreen(
                                id: widget.id,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          // width: 100.w,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Palette.primary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.qr_code_scanner_outlined,
                                size: 20,
                                color: Palette.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                // scanTickets,
                                getTranslated(context, scanTickets).toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 18,
                                      color: Palette.white,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttendanceScreen(
                                id: eventProviderRef.eventId,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Palette.primary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            // checkAttendees,
                            getTranslated(context, checkAttendees).toString(),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 18,
                                      color: Palette.white,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
