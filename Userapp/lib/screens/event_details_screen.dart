import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_pro_user/screens/event_image_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_const_image.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/events_provider.dart';
import 'package:intl/intl.dart';
import 'package:eventright_pro_user/provider/setting_provider.dart';
import 'package:eventright_pro_user/provider/ticket_provider.dart';
import 'auth/signin_screen.dart';
import 'read_more_screen.dart';
import 'report_event_screen.dart';
import 'ticket_details_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  final int eventId;

  const EventDetailsScreen({super.key, this.eventId = 0});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late EventProvider eventProvider;
  late SettingProvider settingProvider;
  late TicketProvider ticketProvider;
  final markers = <MarkerId, Marker>{};

  Future<void> refresh() async {
    setState(() {
      Future.delayed(
        const Duration(seconds: 0),
        () {
          eventProvider.callApiForEventDetails(widget.eventId);
        },
      );
    });
  }

  @override
  void initState() {
    eventProvider = Provider.of<EventProvider>(context, listen: false);
    if (SharedPreferenceHelper.getBoolean(Preferences.isLoggedIn) == true) {
      settingProvider = Provider.of<SettingProvider>(context, listen: false);
      ticketProvider = Provider.of<TicketProvider>(context, listen: false);
      ticketProvider.callApiForTax(widget.eventId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);
    if (SharedPreferenceHelper.getBoolean(Preferences.isLoggedIn) == true) {
      settingProvider = Provider.of<SettingProvider>(context);
      ticketProvider = Provider.of<TicketProvider>(context);
    }

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 00,
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: eventProvider.eventDetailsLoader,
          progressIndicator: const SpinKitCircle(
            color: AppColors.primaryColor,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: width,
                      height: 180,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: eventProvider.sImage,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => SpinKitCircle(
                            color: AppColors.primaryColor.withOpacity(0.4),
                          ),
                          errorWidget: (context, url, error) => Image.asset(AppConstantImage.noImage),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const CircleAvatar(
                            backgroundColor: AppColors.whiteColor,
                            child: Icon(Icons.chevron_left,color:AppColors.blackColor),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (SharedPreferenceHelper.getBoolean(Preferences.isLoggedIn) == true) {
                                  Map<String, dynamic> body = {"event_id": eventProvider.eventId};
                                  eventProvider.callApiForAddFavorite(body).then((value) {
                                    if (value.data!.success == true) {
                                      refresh();
                                    }
                                  });
                                } else {
                                  CommonFunction.toastMessage("Login Required");
                                }
                              },
                              icon: CircleAvatar(
                                backgroundColor: AppColors.whiteColor,
                                child: Icon(
                                  eventProvider.isLike == false ? Icons.favorite_border_rounded : Icons.favorite_rounded,
                                  color: eventProvider.isLike == false ? AppColors.blackColor : AppColors.primaryColor,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _modalBottomSheetMenu();
                                });
                              },
                              icon: const CircleAvatar(
                                backgroundColor: AppColors.whiteColor,
                                child: Icon(
                                  Icons.menu,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                eventProvider.gallery.isNotEmpty
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                        width: width,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: eventProvider.gallery.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventImagePreview(
                                      imageURL: eventProvider.gallery[index],
                                      eventName: eventProvider.sEventName,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: eventProvider.gallery[index],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => SpinKitCircle(
                                      color: AppColors.primaryColor.withOpacity(0.4),
                                    ),
                                    errorWidget: (context, url, error) => Image.asset(AppConstantImage.noImage),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        eventProvider.sEventName,
                        style: const TextStyle(
                          fontSize: 20,
                          color: AppColors.blackColor,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
                      Text(
                        "By ${eventProvider.sOrganizer}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.inputTextColor,
                          fontFamily: AppFontFamily.poppinsRegular,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 24,
                            color: AppColors.blackColor,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                eventProvider.sDate,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.blackColor,
                                  fontFamily: AppFontFamily.poppinsMedium,
                                ),
                              ),
                              Text(
                                eventProvider.sTime,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.inputTextColor,
                                  fontFamily: AppFontFamily.poppinsRegular,
                                ),
                              ),
                              eventProvider.eventType == 'online'
                                  ? Text(
                                      eventProvider.eventType,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.inputTextColor,
                                        fontFamily: AppFontFamily.poppinsRegular,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                      // const Divider(height: 1),
                      const SizedBox(height: 18),
                      eventProvider.sAddress != ''
                          ? Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.blackColor,
                                  size: 24,
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Text(
                                    eventProvider.sAddress,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.blackColor,
                                      fontFamily: AppFontFamily.poppinsMedium,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      eventProvider.sAddress != '' ? const SizedBox(height: 18) : Container(),
                      // eventProvider.sAddress != '' ? const Divider(height: 1) : Container(),
                      Text(
                        getTranslated(context, AppConstant.about).toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.blackColor,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        eventProvider.sDescription,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.blackColor,
                          fontFamily: AppFontFamily.poppinsRegular,
                        ),
                        maxLines: 2,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReadMore(allText: eventProvider.sDescription),
                            ),
                          );
                        },
                        child: Text(
                          getTranslated(context, AppConstant.readMore).toString(),
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.blueColor,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        getTranslated(context, AppConstant.tags).toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.blackColor,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 08,
                        runSpacing: 12,
                        children: List.generate(
                          eventProvider.tags.length,
                          (index) => Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.primaryColor.withOpacity(0.1),
                            ),
                            child: Text(
                              eventProvider.tags[index],
                              style: const TextStyle(
                                fontFamily: AppFontFamily.poppinsRegular,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: eventProvider.organizerImage,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => SpinKitCircle(
                              color: AppColors.primaryColor.withOpacity(0.4),
                            ),
                            errorWidget: (context, url, error) => Image.asset(AppConstantImage.noImage),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        eventProvider.sOrganizer,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.blackColor,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Map<String, dynamic> body = {"user_id": eventProvider.organizerId};
                          settingProvider.callApiForAddFollowing(body).then((value) {
                            if (value.data!.success == true) {
                              refresh();
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 05),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: eventProvider.organizerFollow == false
                              ? Text(
                                  getTranslated(context, AppConstant.follow).toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.blackColor,
                                    fontFamily: AppFontFamily.poppinsMedium,
                                  ),
                                )
                              : Text(
                                  getTranslated(context, AppConstant.following).toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.blackColor,
                                    fontFamily: AppFontFamily.poppinsMedium,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                eventProvider.recentEvents.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          getTranslated(context, AppConstant.moreEventsLikeThis).toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.blackColor,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 15),
                if (eventProvider.recentEvents.isNotEmpty)
                  SizedBox(
                    height: 220,
                    width: width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: eventProvider.recentEvents.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              eventProvider.callApiForEventDetails(eventProvider.recentEvents[index].id);
                              refresh();
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              height: 220,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.inputTextColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 180,
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: width,
                                          height: 160,
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(04),
                                              topRight: Radius.circular(04),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: eventProvider.topEventImage,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => SpinKitCircle(
                                                color: AppColors.primaryColor.withOpacity(0.4),
                                              ),
                                              errorWidget: (context, url, error) => Image.asset(AppConstantImage.noImage),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 140,
                                          right: 10,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                Map<String, dynamic> body = {"event_id": eventProvider.topEventId};
                                                eventProvider.callApiForAddFavorite(body).then((value) {
                                                  if (value.data!.success == true) {
                                                    refresh();
                                                  }
                                                });
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(06),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.whiteColor,
                                              ),
                                              child: Icon(
                                                eventProvider.topIsLike == true ? Icons.favorite : Icons.favorite_border,
                                                color: eventProvider.topIsLike == true ? Colors.red : AppColors.inputTextColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              style: const TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 12,
                                                fontFamily: AppFontFamily.poppinsRegular,
                                              ),
                                              text: DateFormat('MMM').format(
                                                DateTime.parse(eventProvider.recentEvents[index].startTime!),
                                              ),
                                              children: [
                                                TextSpan(
                                                  style: const TextStyle(
                                                    color: AppColors.blackColor,
                                                    fontSize: 12,
                                                    fontFamily: AppFontFamily.poppinsRegular,
                                                  ),
                                                  text: DateFormat('dd').format(
                                                    DateTime.parse(eventProvider.recentEvents[index].startTime!),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                eventProvider.recentEvents[index].name!,
                                                style: const TextStyle(
                                                  color: AppColors.blackColor,
                                                  fontSize: 14,
                                                  fontFamily: AppFontFamily.poppinsMedium,
                                                ),
                                              ),
                                              Text(
                                                eventProvider.recentEvents[index].address??"",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.inputTextColor,
                                                  fontSize: 10,
                                                  fontFamily: AppFontFamily.poppinsRegular,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                else
                  Container()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          if (SharedPreferenceHelper.getBoolean(Preferences.isLoggedIn) == true) {
            ticketProvider.callApiForEventTickets(widget.eventId);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  TicketDetails(startDate:eventProvider.sDate,endDate: eventProvider.eDate),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            getTranslated(context, AppConstant.buyTicket).toString(),
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.whiteColor,
              fontFamily: AppFontFamily.poppinsMedium,
            ),
            textAlign: TextAlign.center,
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
            return Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Share.share('Check out my website ${eventProvider.shareUrl}');
                      },
                      child: Text(
                        getTranslated(context, AppConstant.shareThisEvent).toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.blackColor,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        launchUrl(Uri.parse('mailto:${SharedPreferenceHelper.getString(Preferences.email)}'));
                      },
                      child: Text(
                        getTranslated(context, AppConstant.contactOrganizer).toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.blackColor,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        if (SharedPreferenceHelper.getBoolean(Preferences.isLoggedIn) == true) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReportEvent(),
                            ),
                          );
                        } else {
                          CommonFunction.toastMessage("Login Required");
                        }
                      },
                      child: Text(
                        getTranslated(context, AppConstant.reportEvent).toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.blackColor,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(height: 1),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        getTranslated(context, AppConstant.cancel).toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.blackColor,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ]);
          });
        });
  }
}
