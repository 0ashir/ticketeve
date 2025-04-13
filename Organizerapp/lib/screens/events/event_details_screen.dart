import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/event_provider.dart';
import 'package:eventright_organizer/screens/events/edit_event_screen.dart';
import 'package:eventright_organizer/screens/guest_list_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late EventProvider eventProvider;

  CarouselSliderController? _sliderController;

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, eventProvider, child) => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            getTranslated(context, 'event_details').toString(),
            style: const TextStyle(
                fontFamily: AppFontFamily.poppinsMedium,
                color: whiteColor,
                fontSize: 16),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditEventScreen(eventId: eventProvider.eventId!),
                    ),
                  );
                },
                child: const Icon(Icons.edit, size: 24, color: whiteColor),
              ),
            )
          ],
        ),
        body: ModalProgressHUD(
          inAsyncCall: eventProvider.eventDetailsLoader,
          progressIndicator: const SpinKitCircle(color: primaryColor),
          offset: Offset(MediaQuery.of(context).size.width * 0.43,
              MediaQuery.of(context).size.height * 0.35),
          child: SingleChildScrollView(
            child: eventProvider.eventDetailsLoader == false
                ? Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: CarouselSlider.builder(
                            autoSliderDelay: const Duration(seconds: 05),
                            unlimitedMode: true,
                            controller: _sliderController,
                            autoSliderTransitionTime:
                                const Duration(milliseconds: 600),
                            slideBuilder: (index) {
                              return CachedNetworkImage(
                                imageUrl:
                                index==0?    eventProvider.eventImage:"${eventProvider.imagePath}${eventProvider.gallery[index]}",
                                progressIndicatorBuilder:
                                    (context, url, progress) => const Center(
                                  child: SpinKitCircle(
                                      color: primaryColor, size: 30),
                                ),
                                imageBuilder: (context, imageProvider) =>
                                    ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: imageProvider,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            slideIndicator: CircularSlideIndicator(
                                padding: const EdgeInsets.only(bottom: 10),
                                indicatorBorderColor: whiteColor,
                                currentIndicatorColor: whiteColor,
                                indicatorRadius: 3),
                            itemCount: 1 + eventProvider.gallery.length ,
                            initialPage: 0,
                            enableAutoSlider: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.black87),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${eventProvider.soldTicket}  /  ${eventProvider.totalTicket} Sold",
                                  style: const TextStyle(
                                      fontSize: 12, color: whiteColor),
                                ),
                                InkWell(
                                  onTap: () {
                                    eventProvider
                                        .callApiForGuest(eventProvider.eventId);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const GuestList(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        getTranslated(context, 'see_guest_list')
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 12, color: blueColor),
                                      ),
                                      const Icon(Icons.arrow_forward_ios,
                                          color: blueColor, size: 14)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          eventProvider.eventName,
                          style:
                              const TextStyle(fontSize: 18, color: blackColor),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          eventProvider.description,
                          style: const TextStyle(
                              fontSize: 14, color: inputTextColor),
                        ),
                        const SizedBox(height: 10),
                        if (eventProvider.startTime.isNotEmpty &&
                            eventProvider.endTime.isNotEmpty)
                          Text(
                            "${DateFormat('dd MMM yyyy hh:mm aa').format(
                              DateTime.parse(eventProvider.startTime),
                            )} to ${DateFormat('dd MMM yyyy hh:mm aa').format(
                              DateTime.parse(eventProvider.endTime),
                            )}",
                            style: const TextStyle(
                                color: primaryColor, fontSize: 14),
                          ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Text(
                          getTranslated(context, 'tags_title').toString(),
                          style: const TextStyle(
                              fontSize: 14, color: inputTextColor),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 08,
                          runSpacing: 10,
                          children: List.generate(
                            eventProvider.tags.length,
                            (index) => Container(
                              padding: const EdgeInsets.all(08),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                              child: Text(eventProvider.tags[index]),
                            ),
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, 'total_peoples')
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 14, color: inputTextColor),
                            ),
                            Text(
                              eventProvider.people.toString(),
                              style: const TextStyle(
                                  fontSize: 14, color: inputTextColor),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, 'start_time').toString(),
                              style: const TextStyle(
                                  fontSize: 14, color: inputTextColor),
                            ),
                            if (eventProvider.startTime.isNotEmpty)
                              Text(
                                DateFormat('dd MMM yyyy hh:mm aa').format(
                                  DateTime.parse(eventProvider.startTime),
                                ),
                                style: const TextStyle(
                                    fontSize: 14, color: inputTextColor),
                              ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, 'end_time').toString(),
                              style: const TextStyle(
                                  fontSize: 14, color: inputTextColor),
                            ),
                            if (eventProvider.endTime.isNotEmpty)
                              Text(
                                DateFormat('dd MMM yyyy hh:mm aa').format(
                                  DateTime.parse(eventProvider.endTime),
                                ),
                                style: const TextStyle(
                                    fontSize: 14, color: inputTextColor),
                              ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, 'rating').toString(),
                              style: const TextStyle(
                                  fontSize: 14, color: inputTextColor),
                            ),
                            RatingBar.builder(
                              initialRating: eventProvider.rate,
                              itemSize: 22,
                              glowColor: whiteColor,
                              ignoreGestures: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                switch (index) {
                                  case 0:
                                    return const Icon(
                                      Icons.sentiment_very_dissatisfied,
                                      color: primaryColor,
                                    );
                                  case 1:
                                    return const Icon(
                                      Icons.sentiment_neutral,
                                      color: primaryColor,
                                    );
                                  case 2:
                                    return const Icon(
                                      Icons.sentiment_dissatisfied,
                                      color: primaryColor,
                                    );
                                  case 3:
                                    return const Icon(
                                      Icons.sentiment_satisfied,
                                      color: primaryColor,
                                    );
                                  case 4:
                                    return const Icon(
                                      Icons.sentiment_very_satisfied,
                                      color: primaryColor,
                                    );
                                }
                                return Container();
                              },
                              onRatingUpdate: (rating) {
                                if (kDebugMode) {
                                  print(rating);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(),
          ),
        ),
      ),
    );
  }
}
