import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/model/search_event_model.dart';
import 'package:eventright_organizer/provider/event_provider.dart';
import 'package:eventright_organizer/screens/events/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late EventProvider eventProvider;
  List<SearchData> searchResult = [];

  TextEditingController searchController = TextEditingController();

  Future<void> refresh() async {
    Future.delayed(
      const Duration(seconds: 0),
      () {
        eventProvider.callApiForSearchEvent();
      },
    );
  }

  @override
  void initState() {
    eventProvider = Provider.of<EventProvider>(context, listen: false);

    Future.delayed(Duration.zero, () {
      eventProvider.callApiForSearchEvent();
    });

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: TextFormField(
          cursorColor: blackColor,
          controller: searchController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: getTranslated(context, 'type_something').toString(),
            hintStyle: const TextStyle(color: whiteColor, fontSize: 16),
          ),
          style: const TextStyle(color: whiteColor, fontSize: 16),
          onChanged: onSearchTextChanged,
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: eventProvider.searchLoader,
        progressIndicator: const SpinKitCircle(color: primaryColor),
        offset: Offset(MediaQuery.of(context).size.width * 0.43, MediaQuery.of(context).size.height * 0.35),
        child: RefreshIndicator(
          onRefresh: refresh,
          child: Container(
            child: searchController.text.isNotEmpty
                ? searchResult.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        itemCount: searchResult.length,
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              eventProvider.callApiForEventDetails(searchResult[index].id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EventDetails(),
                                ),
                              );
                            },
                            leading: CachedNetworkImage(
                              height: 60,
                              width: 60,
                              imageUrl: eventProvider.searchEvents[index].imagePath! +
                                  eventProvider.searchEvents[index].image!,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  value: progress.progress,
                                  strokeWidth: 3,
                                  color: primaryColor.withOpacity(0.4),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/NoImage.png"),
                                  ),
                                ),
                              ),
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              eventProvider.searchEvents[index].name!,
                              style: const TextStyle(fontSize: 18, color: blackColor),
                            ),
                            subtitle: Text(
                                "${DateFormat('MMM dd, yyyy').format(DateTime.parse(eventProvider.searchEvents[index].startTime!))}"
                                " ${getTranslated(context, 'to')} "
                                "${DateFormat('MMM dd, yyyy').format(DateTime.parse(eventProvider.searchEvents[index].endTime!))}"),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      )
                    : Center(
                        child: Text(getTranslated(context, 'no_data_found').toString()),
                      )
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: eventProvider.searchEvents.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          eventProvider.callApiForEventDetails(eventProvider.searchEvents[index].id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EventDetails(),
                            ),
                          );
                        },
                        leading: CachedNetworkImage(
                          height: 60,
                          width: 60,
                          imageUrl: eventProvider.searchEvents[index].image == null
                              ? "https://dummyimage.com/200x200/f5f5f5/4d4d4d.png&text=No+Image"
                              :
                              eventProvider.searchEvents[index].imagePath! + eventProvider.searchEvents[index].image!,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) => Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                              strokeWidth: 3,
                              color: primaryColor.withOpacity(0.4),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              image: DecorationImage(
                                image: AssetImage("assets/images/NoImage.png"),
                              ),
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          eventProvider.searchEvents[index].name!,
                          style: const TextStyle(fontSize: 18, color: blackColor),
                        ),
                        subtitle: Text(
                            "${DateFormat('MMM dd, yyyy').format(DateTime.parse(eventProvider.searchEvents[index].startTime!))}"
                            " ${getTranslated(context, 'to')} "
                            "${DateFormat('MMM dd, yyyy').format(DateTime.parse(eventProvider.searchEvents[index].endTime!))}"),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    for (var events in eventProvider.searchEvents) {
      if (events.name!.toLowerCase().contains(
            text.toLowerCase(),
          )) {
        searchResult.add(events);
      }
    }
    setState(() {});
  }
}
