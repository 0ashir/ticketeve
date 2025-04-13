import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/common_function.dart';
import 'package:eventright_organizer/constant/design_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/constant/pref_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/model/enums.dart';
import 'package:eventright_organizer/provider/event_provider.dart';
import 'package:eventright_organizer/provider/scanner_provider.dart';
import 'package:eventright_organizer/screens/gallery/gallery_screen.dart';
import 'package:eventright_organizer/screens/home_screen.dart';
import 'package:eventright_organizer/screens/tickets/tickets_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: depend_on_referenced_packages
import 'package:google_api_headers/google_api_headers.dart';

// ignore: depend_on_referenced_packages
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';

class EditEventScreen extends StatefulWidget {
  final int eventId;

  const EditEventScreen({super.key, required this.eventId});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late EventProvider eventProvider;
  late ScannerProvider scannerProvider;

  List<String> status = ['Active', 'Inactive'];

  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now();
  String? name;
  String? selectedCategoryName;
  EventTypes? eventType;
  Status? selectedStatus;
  List<String> selectedScannerName = [];
  List<String> initialTags = [];

  List<String> selectedScannerID = [];
  num selectedCategoryID = 0;

  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  final TextEditingController _onlineEventURLController =
      TextEditingController();
  final TextEditingController _eventPeopleController = TextEditingController();
  final TextEditingController _addressSearchController =
      TextEditingController();
  final TextfieldTagsController _textFieldTagsController =
      TextfieldTagsController();

  @override
  void initState() {
    eventProvider = Provider.of<EventProvider>(context, listen: false);
    scannerProvider = Provider.of<ScannerProvider>(context, listen: false);
    thumbnailImage = null;
    newThumbnailImage = "";

    // Filling up Event Details
    Future.delayed(Duration.zero, () async {
      eventProvider.callApiForEventDetails(widget.eventId).then((value) {
        if (value.data!.success == true) {
          _eventNameController.text = eventProvider.eventName;
          _eventDescriptionController.text = eventProvider.description;
          _eventPeopleController.text = eventProvider.people.toString();
          eventType = eventProvider.eventType;
          initialTags = eventProvider.tags;
          _addressSearchController.text = eventProvider.address;
          selectLat = eventProvider.lat;
          selectLang = eventProvider.lang;
          selectedStatus = getStatusFromInt(eventProvider.eventStatus);
          startDateTime = eventProvider.startTime.isEmpty
              ? DateTime.now()
              : DateTime.parse(eventProvider.startTime);
          endDateTime = eventProvider.endTime.isEmpty
              ? DateTime.now()
              : DateTime.parse(eventProvider.endTime);
          _onlineEventURLController.text = eventProvider.url;
          for (int i = 0; i < eventProvider.tags.length; i++) {
            _textFieldTagsController.addTag = eventProvider.tags[i];
          }
        }
      });
      eventProvider.callApiForCategory();
      scannerProvider.callApiForScanner();
    });

    selectedScannerName.clear();
    selectedScannerID.clear();
    for (int i = 0; i < scannerProvider.scanners.length; i++) {
      for (int m = 0; m < eventProvider.eventScannerId.length; m++) {
        if (eventProvider.eventScannerId[m] ==
            scannerProvider.scanners[i].id.toString()) {
          selectedScannerName.add(
              "${scannerProvider.scanners[i].firstName!} ${scannerProvider.scanners[i].lastName!}");
          selectedScannerID.add(scannerProvider.scanners[i].id!.toString());
        }
      }
    }
    for (int i = 0; i < eventProvider.categories.length; i++) {
      if (eventProvider.categoryName == eventProvider.categories[i].name) {
        selectedCategoryName = eventProvider.categories[i].name!;
        selectedCategoryID = eventProvider.categories[i].id!.toInt();
      }
    }

    super.initState();
  }

  // Future<void> callAPIS() async {
  //   if (kDebugMode) {
  //     print("Event ID: ${widget.eventId}");
  //   }
  //   Future.delayed(Duration.zero, () {
  //     eventProvider.callApiForEventDetails(widget.eventId);
  //     eventProvider.callApiForCategory();
  //     scannerProvider.callApiForScanner();
  //   });
  // }

  double selectLat = 0.0;
  double selectLang = 0.0;

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDescriptionController.dispose();
    _onlineEventURLController.dispose();
    _eventPeopleController.dispose();
    _addressSearchController.dispose();
    _textFieldTagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);
    scannerProvider = Provider.of<ScannerProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          getTranslated(context, 'edit_event').toString(),
          style: const TextStyle(
              fontSize: 16,
              color: whiteColor,
              fontFamily: AppFontFamily.poppinsMedium),
        ),
        actions: [
          PopupMenuButton(
            position: PopupMenuPosition.under,
            color: whiteColor,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text(
                  getTranslated(context, 'cancel_events').toString(),
                  style: const TextStyle(fontSize: 14, color: inputTextColor),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(
                  getTranslated(context, 'delete_event').toString(),
                  style: const TextStyle(fontSize: 14, color: Colors.red),
                ),
              )
            ],
            onSelected: (dynamic values) {
              if (values == 1) {
                eventProvider
                    .callApiForCancelEvent(widget.eventId)
                    .then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                });
              } else {
                eventProvider
                    .callApiForDeleteEvent(widget.eventId)
                    .then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                });
              }
            },
          )
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: eventProvider.eventLoader,
        progressIndicator: const SpinKitCircle(color: primaryColor),
        offset: Offset(MediaQuery.of(context).size.width * 0.43,
            MediaQuery.of(context).size.height * 0.35),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  thumbnailImage != null
                      ? Image.file(
                          File(thumbnailImage!.path),
                          height: 250,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        )
                      : GestureDetector(
                          onTap: () {
                            chooseThumbnailImage(context);
                          },
                          child: CachedNetworkImage(
                            imageUrl: eventProvider.eventImage,
                            height: 190,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                                strokeWidth: 3,
                                color: primaryColor.withOpacity(0.4),
                              ),
                            ),
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: 250,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/NoImage.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        chooseThumbnailImage(context);
                      },
                      icon: const CircleAvatar(
                        backgroundColor: whiteColor,
                        child: Icon(
                          Icons.edit,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///event name
                    Text(
                      getTranslated(context, 'event_name').toString(),
                      style: AppTextStyles.labelTextStyle,
                    ),
                    TextFormField(
                      controller: _eventNameController,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 12,
                      minLines: 1,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: getTranslated(context, 'please_name_hint')
                            .toString(),
                        hintStyle: const TextStyle(
                            color: inputTextColor, fontSize: 16),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return getTranslated(context, 'please_enter_name')
                              .toString();
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => name = value),
                    ),
                    const SizedBox(height: 4),

                    ///event description
                    Text(
                      getTranslated(context, 'describe_your_event').toString(),
                      style: AppTextStyles.labelTextStyle,
                    ),
                    TextFormField(
                      controller: _eventDescriptionController,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 12,
                      minLines: 1,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText:
                            getTranslated(context, 'event_description_hint')
                                .toString(),
                        hintStyle: const TextStyle(
                            color: inputTextColor, fontSize: 16),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return getTranslated(
                                  context, 'please_enter_description')
                              .toString();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    ///event start title
                    Text(
                      getTranslated(context, 'event_start_title').toString(),
                      style: AppTextStyles.labelTextStyle,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _modalBottomSheetStartDate();
                          },
                          child: Row(
                            children: [
                              Text(
                                DateFormat('MMM dd yyyy').format(startDateTime),
                                style: const TextStyle(
                                    fontSize: 16, color: inputTextColor),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.keyboard_arrow_down,
                                  color: inputTextColor, size: 25),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _modalBottomSheetStartTime();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 35, right: 35),
                            child: Row(
                              children: [
                                Text(
                                  DateFormat('hh:mm a').format(startDateTime),
                                  style: const TextStyle(
                                      fontSize: 16, color: inputTextColor),
                                ),
                                const SizedBox(width: 10),
                                const Icon(Icons.keyboard_arrow_down,
                                    color: inputTextColor, size: 25),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),

                    ///event end title
                    Text(
                      getTranslated(context, 'event_end_title').toString(),
                      style: AppTextStyles.labelTextStyle,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _modalBottomSheetEndDate();
                          },
                          child: Row(
                            children: [
                              Text(
                                DateFormat('MMM dd yyyy').format(endDateTime),
                                style: const TextStyle(
                                    fontSize: 16, color: inputTextColor),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.keyboard_arrow_down,
                                  color: inputTextColor, size: 25),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _modalBottomSheetEndTime();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 35, right: 35),
                            child: Row(
                              children: [
                                Text(
                                  DateFormat('hh:mm a').format(endDateTime),
                                  style: const TextStyle(
                                      fontSize: 16, color: inputTextColor),
                                ),
                                const SizedBox(width: 10),
                                const Icon(Icons.keyboard_arrow_down,
                                    color: inputTextColor, size: 25),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),

                    ///event type
                    Text(
                      getTranslated(context, 'event_type').toString(),
                      style: AppTextStyles.labelTextStyle,
                    ),
                    InkWell(
                      onTap: () {
                        _modalBottomSheetEventType();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          eventType != null
                              ? Text(
                                  eventType!.name,
                                  style: const TextStyle(
                                      fontSize: 14, color: inputTextColor),
                                )
                              : const Text(
                                  "Select Event Type",
                                  style: TextStyle(
                                      fontSize: 14, color: inputTextColor),
                                ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 25,
                            color: inputTextColor,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (eventType == EventTypes.offline) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslated(context, 'enter_your_event_location')
                                .toString(),
                            style: AppTextStyles.labelTextStyle,
                          ),
                          TextFormField(
                            readOnly: true,
                            controller: _addressSearchController,
                            style: const TextStyle(
                                fontSize: 14, color: inputTextColor),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              hintText: "Address",
                              hintStyle: TextStyle(
                                  color: inputTextColor, fontSize: 14),
                            ),
                            onTap: () async {
                              Prediction? p = await PlacesAutocomplete.show(
                                context: context,
                                mode: Mode.overlay,
                                apiKey: Preferences.mapKey,
                                offset: 0,
                                types: [],
                                strictbounds: false,
                                components: [],
                              );
                              await displayPrediction(p);
                              _addressSearchController.text =
                                  '${p!.description}';
                            },
                          ),
                          const SizedBox(height: 10),

                          ///event scanner
                          Text(
                            getTranslated(context, 'event_scanner').toString(),
                            style: AppTextStyles.labelTextStyle,
                          ),
                          InkWell(
                            onTap: () {
                              _modalBottomSheetEventScanner();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                selectedScannerName.isNotEmpty
                                    ? Expanded(
                                        child: Text(
                                          selectedScannerName.join(', '),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: inputTextColor),
                                        ),
                                      )
                                    : const Text(
                                        "Select Event Scanner",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: inputTextColor),
                                      ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 25,
                                  color: inputTextColor,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],

                    if (eventType == EventTypes.online) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslated(context, 'event_url').toString(),
                            style: AppTextStyles.labelTextStyle,
                          ),
                          TextFormField(
                            controller: _onlineEventURLController,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              hintText: "https://www.example.com",
                              hintStyle: TextStyle(
                                  color: inputTextColor, fontSize: 16),
                            ),
                            keyboardType: TextInputType.url,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],

                    ///event category
                    Text(
                      getTranslated(context, 'event_category').toString(),
                      style: AppTextStyles.labelTextStyle,
                    ),
                    InkWell(
                      onTap: () {
                        _modalBottomSheetEventCategory();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          selectedCategoryName != null &&
                                  selectedCategoryName!.isNotEmpty
                              ? Text(
                                  selectedCategoryName!,
                                  style: const TextStyle(
                                      fontSize: 14, color: inputTextColor),
                                )
                              : const Text(
                                  "Select Category",
                                  style: TextStyle(
                                      fontSize: 14, color: inputTextColor),
                                ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 25,
                            color: inputTextColor,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    ///status
                    Text(
                      getTranslated(context, 'status').toString(),
                      style: AppTextStyles.labelTextStyle,
                    ),
                    InkWell(
                      onTap: () {
                        _modalBottomSheetEventStatus();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          selectedStatus != null
                              ? Text(
                                  selectedStatus!.name,
                                  style: const TextStyle(
                                      fontSize: 14, color: inputTextColor),
                                )
                              : const Text(
                                  "Select Event Status",
                                  style: TextStyle(
                                      fontSize: 14, color: inputTextColor),
                                ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 25,
                            color: inputTextColor,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    ///people allow
                    Text(
                      getTranslated(context, 'people_allow').toString(),
                      style: AppTextStyles.labelTextStyle,
                    ),
                    TextFormField(
                      controller: _eventPeopleController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "100",
                        hintStyle:
                            TextStyle(color: inputTextColor, fontSize: 16),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return getTranslated(
                                  context, 'please_enter_people_allow')
                              .toString();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    /// Tags
                    Text(
                      getTranslated(context, 'tags').toString(),
                      style: AppTextStyles.labelTextStyle,
                    ),
                    TextFieldTags(
                      textfieldTagsController: _textFieldTagsController,
                      initialTags: initialTags,
                      textSeparators: const [','],
                      letterCase: LetterCase.small,
                      inputfieldBuilder:
                          (context, tec, fn, error, onChanged, onSubmitted) {
                        return ((context, tagsScrollController, tagsList,
                            onTagDelete) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 0),
                            child: TextFormField(
                              controller: tec,
                              focusNode: fn,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: _textFieldTagsController.hasTags
                                    ? ''
                                    : "Enter comma separated tags..",
                                hintStyle: const TextStyle(
                                    color: inputTextColor, fontSize: 16),
                                errorText: error,
                                prefixIconConstraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width),
                                prefixIcon: tagsList.isNotEmpty
                                    ? SingleChildScrollView(
                                        controller: tagsScrollController,
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                            children:
                                                tagsList.map((String tag) {
                                          return Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(4.0),
                                              ),
                                              color: primaryColor,
                                            ),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  tag.toLowerCase(),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(width: 4.0),
                                                InkWell(
                                                  child: const Icon(
                                                    Icons.cancel,
                                                    size: 14.0,
                                                    color: whiteColor,
                                                  ),
                                                  onTap: () {
                                                    onTagDelete(tag);
                                                  },
                                                )
                                              ],
                                            ),
                                          );
                                        }).toList()),
                                      )
                                    : null,
                              ),
                              onChanged: onChanged,
                              onFieldSubmitted: onSubmitted,
                            ),
                          );
                        });
                      },
                    ),

                    // Save button
                    InkWell(
                      onTap: () {
                        setState(
                          () {
                            if (kDebugMode) {
                              print(selectedScannerID.join(","));
                            }
                            if (selectedScannerID.isEmpty &&
                                eventType == EventTypes.offline) {
                              CommonFunction.toastMessage(
                                  "Please select scanner");
                            } else {
                              Map<String, dynamic> body = {
                                "id": widget.eventId,
                                "name": _eventNameController.text,
                                if (_isThumbnailChanged) ...{
                                  "image": newThumbnailImage
                                },
                                "start_date": DateFormat('yyyy-MM-dd')
                                    .format(startDateTime),
                                "end_date": DateFormat('yyyy-MM-dd')
                                    .format(endDateTime),
                                "start_time": DateFormat('HH:mm:ss')
                                    .format(startDateTime),
                                "end_time":
                                    DateFormat('HH:mm:ss').format(endDateTime),
                                "tags": _textFieldTagsController.getTags == null
                                    ? []
                                    : _textFieldTagsController.getTags!
                                        .join(","),
                                if (eventType == EventTypes.offline) ...{
                                  "address": _addressSearchController.text,
                                  "lat": selectLat,
                                  "lang": selectLang,
                                  "scanner_id": selectedScannerID.join(","),
                                  "url": null,
                                } else if (eventType == EventTypes.online) ...{
                                  "url": _onlineEventURLController.text,
                                  "address": null,
                                  "lat": null,
                                  "lang": null,
                                  "scanner_id": null,
                                },
                                "category_id": selectedCategoryID,
                                "type": eventType!.name,
                                "status": getStatusAsInt(selectedStatus!),
                                "people": _eventPeopleController.text,
                                "description": _eventDescriptionController.text,
                              };
                              if (kDebugMode) {
                                print(body);
                              }
                              eventProvider.callApiForEditEvent(body, context);
                            }
                          },
                        );
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            getTranslated(context, 'save').toString(),
                            style: const TextStyle(
                                fontSize: 16, color: whiteColor),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // View or Edit Tickets Button which will navigate to Tickets Screen
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TicketScreen(eventId: widget.eventId),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor),
                        ),
                        child: Center(
                          child: Text(
                            getTranslated(context, 'view_or_add_tickets')
                                .toString(),
                            style: const TextStyle(
                                fontSize: 16, color: primaryColor),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Edit Images Button which will navigate to Gallery Screen
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GalleryScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor),
                        ),
                        child: Center(
                          child: Text(
                            getTranslated(context, 'edit_images').toString(),
                            style: const TextStyle(
                                fontSize: 16, color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetEventStatus() {
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
                    height: 60.0,
                    color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          getTranslated(context, 'select_any_one').toString(),
                          style:
                              const TextStyle(color: whiteColor, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  ListView.separated(
                    itemCount: status.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedStatus = Status.values[index];
                            Navigator.pop(context);

                            setState(() {});
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              status[index],
                              style: const TextStyle(
                                  fontSize: 14, color: blackColor),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, indexes) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(thickness: 1),
                      );
                    },
                  )
                ],
              ),
            );
          });
        });
  }

  void _modalBottomSheetEventType() {
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
                    height: 60.0,
                    color: Colors.transparent,
                    child: Container(
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
                          getTranslated(context, 'select_any_one').toString(),
                          style: const TextStyle(
                              color: whiteColor,
                              fontSize: 16,
                              fontFamily: AppFontFamily.poppinsMedium),
                        ),
                      ),
                    ),
                  ),
                  ListView.separated(
                    itemCount: EventTypes.values.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            eventType = EventTypes.values[index];
                            Navigator.pop(context);
                            setState(() {});
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              EventTypes.values[index].name,
                              style: const TextStyle(
                                  fontSize: 14, color: blackColor),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, indexes) {
                      return const SizedBox();
                    },
                  )
                ],
              ),
            );
          });
        });
  }

  void _modalBottomSheetEventScanner() {
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
                    height: 60.0,
                    color: Colors.transparent,
                    child: Container(
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
                          getTranslated(context, 'select_scanner').toString(),
                          style: const TextStyle(
                              color: whiteColor,
                              fontSize: 16,
                              fontFamily: AppFontFamily.poppinsMedium),
                        ),
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: scannerProvider.scanners.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (selectedScannerID.every((element) =>
                                element !=
                                scannerProvider.scanners[index].id
                                    .toString())) {
                              selectedScannerID.add(scannerProvider
                                  .scanners[index].id
                                  .toString());
                              selectedScannerName.add(
                                  "${scannerProvider.scanners[index].firstName ?? ''} ${scannerProvider.scanners[index].lastName ?? ''}");
                            } else if (selectedScannerID.any((element) =>
                                element ==
                                scannerProvider.scanners[index].id
                                    .toString())) {
                              int indexId = selectedScannerID.indexWhere(
                                  (element) =>
                                      element ==
                                      scannerProvider.scanners[index].id
                                          .toString());
                              selectedScannerID.removeAt(indexId);
                              int indexName = selectedScannerName.indexWhere(
                                  (element) =>
                                      element ==
                                      "${scannerProvider.scanners[index].firstName ?? ''} ${scannerProvider.scanners[index].lastName ?? ''}");
                              selectedScannerName.removeAt(indexName);
                            }
                            Navigator.pop(context);
                            setState(() {});
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${scannerProvider.scanners[index].firstName!} ${scannerProvider.scanners[index].lastName!}",
                                style: const TextStyle(
                                    fontSize: 18, color: blackColor),
                              ),
                              selectedScannerID.any((element) =>
                                      element ==
                                      scannerProvider.scanners[index].id
                                          .toString())
                                  ? const Icon(
                                      Icons.check,
                                      color: primaryColor,
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, indexes) {
                      return const SizedBox();
                    },
                  )
                ],
              ),
            );
          });
        });
  }

  void _modalBottomSheetEventCategory() {
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
                    height: 60.0,
                    color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          getTranslated(context, 'select_event_category')
                              .toString(),
                          style:
                              const TextStyle(color: whiteColor, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  ListView.separated(
                    itemCount: eventProvider.categories.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedCategoryName =
                                eventProvider.categories[index].name!;
                            selectedCategoryID =
                                eventProvider.categories[index].id!;
                            Navigator.pop(context);

                            setState(() {});
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              eventProvider.categories[index].name!,
                              style: const TextStyle(
                                  fontSize: 14, color: blackColor),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, indexes) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(thickness: 1),
                      );
                    },
                  )
                ],
              ),
            );
          });
        });
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
                    height: 45.0,
                    color: Colors.transparent,
                    child: Container(
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
                          DateFormat('MMM dd yyyy').format(startDateTime),
                          style:
                              const TextStyle(color: whiteColor, fontSize: 24),
                        ),
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
                    focusedDay: startDateTime,
                    selectedDayPredicate: (day) {
                      return isSameDay(startDateTime, day);
                    },
                    onDaySelected: (selectedStartDate, focusedDay) {
                      setState(() {
                        startDateTime = selectedStartDate;
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
                    height: 45.0,
                    color: Colors.transparent,
                    child: Container(
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
                          DateFormat('MMM dd yyyy').format(endDateTime),
                          style:
                              const TextStyle(color: whiteColor, fontSize: 24),
                        ),
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
                    focusedDay: endDateTime,
                    selectedDayPredicate: (day) {
                      return isSameDay(endDateTime, day);
                    },
                    onDaySelected: (selectEndDate, focusedDay) {
                      setState(() {
                        endDateTime = selectEndDate;
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

  void _modalBottomSheetStartTime() {
    DateTime tempHoldingStartTime = startDateTime;
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
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              getTranslated(context, 'cancel_button')
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 16, color: primaryColor),
                            )),
                        const SizedBox(width: 10),
                        InkWell(
                            onTap: () {
                              setState(() {
                                startDateTime = tempHoldingStartTime;
                              });
                              Navigator.pop(context);
                            },
                            child: Text(
                              getTranslated(context, 'done_button').toString(),
                              style: const TextStyle(
                                  fontSize: 16, color: primaryColor),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 150,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (value) {
                          tempHoldingStartTime = value;
                        },
                        initialDateTime: startDateTime,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void _modalBottomSheetEndTime() {
    DateTime tempHoldingEndDate = endDateTime;
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
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              getTranslated(context, 'cancel_button')
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 16, color: primaryColor),
                            )),
                        const SizedBox(width: 10),
                        InkWell(
                            onTap: () {
                              setState(() {
                                endDateTime = tempHoldingEndDate;
                              });
                              Navigator.pop(context);
                            },
                            child: Text(
                              getTranslated(context, 'done_button').toString(),
                              style: const TextStyle(
                                  fontSize: 16, color: primaryColor),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 150,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (value) {
                          tempHoldingEndDate = value;
                        },
                        initialDateTime: endDateTime,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  /// select thumbnail image ///

  File? thumbnailImage;
  bool _isThumbnailChanged = false;
  final eventMainImage = ImagePicker();
  String newThumbnailImage = "";

  chooseThumbnailImage(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(
                    getTranslated(context, 'gallery').toString(),
                  ),
                  onTap: () {
                    _thumbnailImgFromGallery(context);
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(
                  getTranslated(context, 'camera').toString(),
                ),
                onTap: () {
                  _thumbnailImgFromCamera(context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _thumbnailImgFromGallery(context) async {
    final pickedFile =
        await eventMainImage.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _isThumbnailChanged = true;
      thumbnailImage = File(pickedFile.path);
      List<int> imageBytes = thumbnailImage!.readAsBytesSync();
      newThumbnailImage = base64Encode(imageBytes);
      setState(() {});
    } else {
      _isThumbnailChanged = false;
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  void _thumbnailImgFromCamera(context) async {
    final pickedFile =
        await eventMainImage.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _isThumbnailChanged = true;
      thumbnailImage = File(pickedFile.path);
      List<int> imageBytes = thumbnailImage!.readAsBytesSync();
      newThumbnailImage = base64Encode(imageBytes);
      setState(() {});
    } else {
      _isThumbnailChanged = false;
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  Future<dynamic> displayPrediction(Prediction? p) async {
    if (p != null) {
      GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: Preferences.mapKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );

      PlacesDetailsResponse detail =
          await places.getDetailsByPlaceId(p.placeId!);

      double lat = detail.result.geometry!.location.lat;
      double lng = detail.result.geometry!.location.lng;

      selectLang = double.parse('$lng');
      selectLat = double.parse('$lat');
    }
  }
}
