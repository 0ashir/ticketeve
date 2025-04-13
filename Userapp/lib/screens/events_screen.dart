import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_pro_user/utilities/extension_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_const_image.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/model/all_events_model.dart';
import 'package:eventright_pro_user/provider/events_provider.dart';
import 'package:eventright_pro_user/provider/setting_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'event_details_screen.dart';
import 'search/go_out.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late EventProvider eventProvider;

  late SettingProvider settingProvider;
  bool deniedForever = false;
  late TextEditingController? _searchController;
  String? searchString;
  DateTime? searchDate;
  num? selectedCategoryID;

  Future<void> resetEventsToDefault() async {
    setState(() {
      _searchController!.clear();
      searchDate = null;
      searchString = null;
      // searchProvider.searchData.clear();
      // searchProvider.searchDate = null;
      Future.delayed(
        Duration.zero,
        () {
          Map<String, dynamic> body = {
            "searchString": searchString,
            "searchDate": searchDate.toFormattedDateTimeYYYYMMDD(),
          };
          // searchProvider.searchData.clear();
          eventProvider.callApiForAllEvents(body);
        },
      );
    });
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    eventProvider = Provider.of<EventProvider>(context, listen: false);
    //  searchProvider = Provider.of<SearchProvider>(context, listen: false);
    if (SharedPreferenceHelper.getBoolean(Preferences.isLoggedIn) == true) {
      settingProvider = Provider.of<SettingProvider>(context, listen: false);
      Future.delayed(Duration.zero, () {
        settingProvider.callApiForSetting();
      });
    }

    Future.delayed(
      const Duration(seconds: 0),
      () {
        _checkAndFetchData();
      },
    );

    super.initState();
  }

  void _checkAndFetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int lastApiCallTime = prefs.getInt('lastApiCallTime') ?? 0;
    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    final bool shouldFetch =
        (currentTime - lastApiCallTime) > 300000 || // 5 minutes in milliseconds
            eventProvider.category.isEmpty ||
            eventProvider.eventsData.isEmpty;

    if (shouldFetch) {
      _fetchData();
      prefs.setInt('lastApiCallTime', currentTime); // Update API call time
    }
  }

  void _fetchData() {
    eventProvider.callApiForCategory();
    Map<String, dynamic> body = {
      "searchString": searchString,
      "searchDate": searchDate.toFormattedDateTimeYYYYMMDD(),
    };
    eventProvider.callApiForAllEvents(body);
  }

  @override
  void dispose() {
    _searchController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);
    settingProvider = Provider.of<SettingProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 00,
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: eventProvider.allEventsLoader,
          progressIndicator: const SpinKitCircle(color: AppColors.primaryColor),
          color: Colors.transparent,
          child: RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: resetEventsToDefault,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    width: width,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          TextField(
                            cursorColor: AppColors.whiteColor,
                            controller: _searchController,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            onChanged: (value) async {
                              if (value.isEmpty) {
                                searchString = null;
                              } else {
                                searchString = value;
                              }
                              await Future.delayed(
                                      const Duration(milliseconds: 300))
                                  .then((value) {
                                eventProvider.searchEventsByQuery(searchString);
                              });
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText:
                                  getTranslated(context, AppConstant.search)
                                      .toString(),
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                color: AppColors.whiteColor,
                                fontFamily: AppFontFamily.poppinsRegular,
                              ),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.whiteColor,
                              fontFamily: AppFontFamily.poppinsRegular,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const GoOut(),
                                    ),
                                  );
                                  // setState(() {
                                  //   searchDate = searchProvider.searchDate;
                                  // });
                                },
                                child: const Text(
                                  "When do you want to go?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.whiteColor,
                                    fontFamily: AppFontFamily.poppinsRegular,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: Tooltip(
                                      message: "Search",
                                      child: InkWell(
                                        onTap: () {
                                          Map<String, dynamic> body = {
                                            "searchString": searchString,
                                            "searchDate": searchDate
                                                .toFormattedDateTimeYYYYMMDD(),
                                          };
                                          // searchProvider.searchData.clear();
                                          eventProvider
                                              .callApiForAllEvents(body);
                                        },
                                        child: const Icon(
                                          Icons.search,
                                          color: AppColors.whiteColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Tooltip(
                                    message: "Reset Search",
                                    child: InkWell(
                                      onTap: () => resetEventsToDefault(),
                                      child: const Icon(
                                        Icons.refresh,
                                        color: AppColors.whiteColor,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 05),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: eventProvider.category.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    selectedCategoryID =
                                        eventProvider.category[index].id;
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: selectedCategoryID ==
                                                eventProvider.category[index].id
                                            ? AppColors.primaryColor
                                            : AppColors.primaryColor
                                                .withOpacity(0.2),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        eventProvider.category[index].name!,
                                        style: TextStyle(
                                          // fontSize: 12,
                                          color: selectedCategoryID ==
                                                  eventProvider
                                                      .category[index].id
                                              ? AppColors.whiteColor
                                              : AppColors.blackColor,
                                          fontFamily:
                                              AppFontFamily.poppinsRegular,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        eventProvider.eventsData.isEmpty ||
                                (selectedCategoryID != null &&
                                    eventProvider.eventsData
                                        .where((event) =>
                                            event.categoryId ==
                                            selectedCategoryID)
                                        .toList()
                                        .isEmpty)
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5 +
                                        30,
                                child: const Center(
                                  child: Text(
                                    "No Events Found",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.blackColor,
                                      fontFamily: AppFontFamily.poppinsRegular,
                                    ),
                                  ),
                                ),
                              )
                            : ListView.separated(
                                keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
                                shrinkWrap: true,
                                itemCount: selectedCategoryID == null
                                    ? eventProvider.eventsData.length
                                    : eventProvider.eventsData
                                        .where((event) =>
                                            event.categoryId ==
                                            selectedCategoryID)
                                        .toList()
                                        .length,
                                physics: const NeverScrollableScrollPhysics(),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                itemBuilder: (context, index) {
                                  Events event = selectedCategoryID == null
                                      ? eventProvider.eventsData[index]
                                      : eventProvider.eventsData
                                          .where((event) =>
                                              event.categoryId ==
                                              selectedCategoryID)
                                          .toList()[index];
                                  return InkWell(
                                    onTap: () {
                                      eventProvider
                                          .callApiForEventDetails(event.id!)
                                          .then((value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EventDetailsScreen(
                                              eventId: event.id!.toInt(),
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    child: Card(
                                      color: AppColors.whiteColor,
                                      shadowColor: AppColors.primaryColor
                                          .withOpacity(0.3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 20,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //Image
                                            Container(
                                              height: 150,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(4),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: event.imagePath! +
                                                      event.image!,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      SpinKitCircle(
                                                    color: AppColors
                                                        .primaryColor
                                                        .withOpacity(0.4),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    AppConstantImage.noImage,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Event Name
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
                                              child: Text(
                                                event.name!,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: AppFontFamily
                                                      .poppinsMedium,
                                                ),
                                              ),
                                            ),
                                            // Event Starting Time
                                            Text(
                                              event.time!,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.inputTextColor,
                                                fontFamily: AppFontFamily
                                                    .poppinsRegular,
                                              ),
                                            ),
                                            // Event Description
                                            Text(
                                              event.description!,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      AppColors.inputTextColor,
                                                  fontFamily: AppFontFamily
                                                      .poppinsRegular,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                // Event Ratings
                                                event.rate != null
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 5),
                                                        child:
                                                            RatingBar.builder(
                                                          unratedColor:
                                                              AppColors
                                                                  .blackColor,
                                                          initialRating: event
                                                              .rate!
                                                              .toDouble(),
                                                          minRating: 1,
                                                          itemSize: 16,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          ignoreGestures: true,
                                                          itemPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      2.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {},
                                                        ),
                                                      )
                                                    : Container(),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      Share.share(
                                                          event.shareUrl ?? "");
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.share,
                                                    color: AppColors.blackColor,
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(width: 15),
                                                StatefulBuilder(
                                                  builder:
                                                      (context, setStateLike) {
                                                    return InkWell(
                                                      onTap: () {
                                                        if (SharedPreferenceHelper
                                                                .getBoolean(
                                                                    Preferences
                                                                        .isLoggedIn) ==
                                                            true) {
                                                          Map<String, dynamic>
                                                              body = {
                                                            "event_id": event.id
                                                          };
                                                          eventProvider
                                                              .callApiForAddFavorite(
                                                                  body)
                                                              .then((value) {
                                                            if (value.data!
                                                                    .success ==
                                                                true) {
                                                              setStateLike(() {
                                                                event.setIsLike =
                                                                    !event
                                                                        .isLike!; // Toggle like state
                                                              });
                                                            }
                                                          });
                                                        } else {
                                                          CommonFunction
                                                              .toastMessage(
                                                                  "Login Required");
                                                        }
                                                      },
                                                      child: Icon(
                                                        event.isLike == true
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                        color: event.isLike ==
                                                                true
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .blackColor,
                                                        size: 20,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 14);
                                },
                              ),
                      ],
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
}
