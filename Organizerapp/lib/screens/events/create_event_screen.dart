import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/pref_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/event_provider.dart';
import 'package:eventright_organizer/provider/scanner_provider.dart';
import 'package:eventright_organizer/screens/components/button.dart';
import 'package:eventright_organizer/screens/components/desc_field.dart';
import 'package:eventright_organizer/screens/components/field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// ignore: depend_on_referenced_packages
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_webservice/places.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../constant/font_constant.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late EventProvider eventProvider;
  late ScannerProvider scannerProvider;

  GoogleMapController? controller;
  final TextEditingController _addressSearchController =
      TextEditingController();
  final TextEditingController _onlineEventURLController =
      TextEditingController();
  final TextfieldTagsController _textfieldTagsController =
      TextfieldTagsController();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  final TextEditingController _eventPeopleController = TextEditingController();

  double selectLat = 0.0;
  double selectLang = 0.0;
  bool deniedForever = false;

  String address = '';

  List<String> eventTypes = ['Online', "Offline"];
  List<String> status = ['Active', 'InActive'];
  int currentStep = 0;
  String eventStatus = '';
  String eventType = '';

  int categoryId = 0;
  String category = '';

  List<String> scannerId = [];
  List<String> scannerName = [];

  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();

  DateTime? startTime = DateTime.now();
  DateTime? endTime = DateTime.now();

  @override
  void initState() {
    eventProvider = Provider.of<EventProvider>(context, listen: false);
    scannerProvider = Provider.of<ScannerProvider>(context, listen: false);

    Future.delayed(Duration.zero, () {
      scannerProvider.callApiForScanner();
      eventProvider.callApiForCategory();
    });
    super.initState();
  }

  @override
  void dispose() {
    _addressSearchController.dispose();
    _eventNameController.dispose();
    _eventDescriptionController.dispose();
    _eventPeopleController.dispose();
    _onlineEventURLController.dispose();
    _textfieldTagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);
    scannerProvider = Provider.of<ScannerProvider>(context);

    return ModalProgressHUD(
        inAsyncCall: eventProvider.createEventLoader,
      progressIndicator: const SpinKitCircle(color: primaryColor),
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            getTranslated(context, 'create_event').toString(),
            style: const TextStyle(
              fontSize: 16,
              color: whiteColor,
              fontFamily: AppFontFamily.poppinsMedium,
            ),
          ),
        ),
        body: Stepper(
          elevation: 0,
          steps: getSteps(),
          type: StepperType.horizontal,
          currentStep: currentStep,
          controlsBuilder: (context, details) {
            return const SizedBox();
          },
          connectorColor: WidgetStateProperty.all(primaryColor),
          onStepTapped: (int step) {
            setState(() {
              currentStep = step;
            });
          },
        ),
        bottomNavigationBar: Container(
          height: 40,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  currentStep > 0 ? setState(() => currentStep -= 1) : null;
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    getTranslated(context, 'cancel').toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: whiteColor,
                      fontFamily: AppFontFamily.poppinsMedium,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (kDebugMode) {
                    print(currentStep);
                  }
                  if (kDebugMode) {
                    print(currentStep);
                  }
      
                  // Only call api when it is last step
                  if (currentStep == 2) {
                    Map<String, dynamic> body = {
                      "name": _eventNameController.text,
                      "start_date": DateFormat('yyyy-MM-dd').format(startDate!),
                      "end_date": DateFormat('yyyy-MM-dd').format(endDate!),
                      "start_time": DateFormat('hh:mm aa').format(startTime!),
                      "end_time": DateFormat('hh:mm aa').format(endTime!),
                      if (eventType.toLowerCase() == "offline")
                        "scanner_id": scannerId.join(","),
                      "category_id": categoryId,
                      // "tags": _textfieldTagsController.getTags == null ? [] : _textfieldTagsController.getTags!.join(','),
                      "type": eventType.toLowerCase(),
                      if (eventType.toLowerCase() == "online")
                        "url": _onlineEventURLController.text.isEmpty
                            ? null
                            : _onlineEventURLController.text,
                      if (eventType.toLowerCase() == "offline")
                        "address": _addressSearchController.text,
                      if (eventType.toLowerCase() == "offline") "lat": selectLat,
                      if (eventType.toLowerCase() == "offline")
                        "lang": selectLang,
                      "status": eventStatus == "Active" ? 1 : 0,
                      "description": _eventDescriptionController.text,
                      "people": _eventPeopleController.text,
                      "image": eventProvider.image,
                    };
                    if (kDebugMode) {
                      print(body['tags']);
                      print(body);
                    }
                    eventProvider.callApiForAddEvent(body, context);
                  }
                  currentStep < 2 ? setState(() => currentStep += 1) : null;
                },
                child: Button(
                    width: MediaQuery.of(context).size.width * 0.5,
                    text:currentStep==2?'POST': 'Continue'),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    double width = MediaQuery.of(context).size.width;
    return [
      Step(
        title: const Text(""),
        content: Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getTranslated(context, 'set_up_your_event').toString(),
                style: const TextStyle(
                    fontSize: 28,
                    color: blackColor,
                    fontFamily: AppFontFamily.poppinsSemiBold),
              ),
              const SizedBox(height: 15),
              Field(
                  controller: _eventNameController,
                  label: getTranslated(context, 'event_name').toString(),
                  icon: const Icon(Icons.local_activity_outlined),
                  isPassword: false,
                  inputType: TextInputType.name),
              const SizedBox(height: 15),
              DescField(
                  controller: _eventDescriptionController,
                  label:
                      getTranslated(context, 'describe_your_event').toString()),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  setState(() {
                    eventProvider.chooseProfileImage(context);
                  });
                },
                child: Row(
                  children: [
                    eventProvider.eventImageFile == null
                        ? Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor.withOpacity(0.1),
                            ),
                            child: const Icon(Icons.camera_alt,
                                color: whiteColor, size: 50),
                          )
                        : Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              child: Image.file(
                                eventProvider.eventImageFile!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    const SizedBox(width: 10),
                    Text(
                      getTranslated(context, 'select_event_picture').toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          color: blackColor,
                          fontFamily: AppFontFamily.poppinsRegular),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        isActive: currentStep >= 0,
        state: currentStep == 0 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: const Text(""),
        content: Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getTranslated(context, 'set_date_and_time').toString(),
                style: const TextStyle(
                    fontSize: 24,
                    color: blackColor,
                    fontFamily: AppFontFamily.poppinsMedium),
              ),
              const SizedBox(height: 15),
              Text(
                getTranslated(context, 'event_start_from').toString(),
                style: const TextStyle(
                    fontSize: 18,
                    color: blackColor,
                    fontFamily: AppFontFamily.poppinsRegular),
              ),
              const SizedBox(height: 05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _modalBottomSheetStartDate();
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month,
                            color: blackColor, size: 25),
                        const SizedBox(width: 10),
                        Text(
                          DateFormat('MMM dd yyyy').format(startDate!),
                          style: const TextStyle(
                              fontSize: 16, color: inputTextColor),
                        ),
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
                          const Icon(Icons.watch_later,
                              color: blackColor, size: 25),
                          const SizedBox(width: 10),
                          Text(
                            DateFormat('hh:mm a').format(startTime!),
                            style: const TextStyle(
                                fontSize: 16, color: inputTextColor),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                getTranslated(context, 'event_end_at').toString(),
                style: const TextStyle(
                    fontSize: 18,
                    color: blackColor,
                    fontFamily: AppFontFamily.poppinsRegular),
              ),
              const SizedBox(height: 05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _modalBottomSheetEndDate();
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month,
                            color: blackColor, size: 25),
                        const SizedBox(width: 10),
                        Text(
                          DateFormat('MMM dd yyyy').format(endDate!),
                          style: const TextStyle(
                              fontSize: 16, color: inputTextColor),
                        ),
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
                          const Icon(Icons.watch_later,
                              color: blackColor, size: 25),
                          const SizedBox(width: 10),
                          Text(
                            DateFormat('hh:mm a').format(endTime!),
                            style: const TextStyle(
                                fontSize: 16, color: inputTextColor),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        isActive: currentStep >= 1,
        state: currentStep == 1
            ? StepState.editing
            : currentStep < 1
                ? StepState.disabled
                : StepState.complete,
      ),
      Step(
        title: const Text(""),
        content: Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getTranslated(context, 'which_type_of_event').toString(),
                style: const TextStyle(
                    fontSize: 24,
                    color: blackColor,
                    fontFamily: AppFontFamily.poppinsMedium),
              ),
              const SizedBox(height: 15),
              _eventType(),
              const SizedBox(height: 10),
              _eventStatus(),
              const SizedBox(height: 10),

              Container(
                height: 45,
                width: width * 0.9,
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  child: InkWell(
                    onTap: () {
                      _modalBottomSheetEventCategory();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        category != ''
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  category,
                                  style: const TextStyle(
                                      fontSize: 14, color: blackColor),
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Event Category",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: blackColor,
                                      fontFamily: AppFontFamily.poppinsMedium),
                                ),
                              ),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 25,
                          color: blackColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (eventType.toLowerCase() == "offline") ...[
                Container(
                  height: 45,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12),
                    child: InkWell(
                      onTap: () {
                        _modalBottomSheetEventScanner();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          scannerName.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    scannerName.join(","),
                                    style: const TextStyle(
                                        fontSize: 14, color: inputTextColor),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    getTranslated(context, 'select_scanner')
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: blackColor,
                                        fontFamily:
                                            AppFontFamily.poppinsMedium),
                                  ),
                                ),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 25,
                            color: blackColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],

              if (eventType.toLowerCase() == "offline") ...[
                Container(
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    readOnly: true,
                    controller: _addressSearchController,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          right: 6,
                          left: 24,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        suffixIcon: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            splashColor: inputTextColor,
                            child: const Icon(Icons.location_on_outlined)),
                        label: Text(
                          getTranslated(context, 'enter_your_event_location')
                              .toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: blackColor,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        )),
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
                      if (p != null) {
                        _addressSearchController.text = '${p.description}';
                      }
                      if (kDebugMode) {
                        print(_addressSearchController.text);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],

              // Custom URL Field
              if (eventType.toLowerCase() == "online") ...[
                Field(
                    controller: _onlineEventURLController,
                    label: getTranslated(context, 'enter_your_event_url')
                        .toString(),
                    icon: const Icon(
                      Icons.link,
                      color: blackColor,
                    ),
                    isPassword: false,
                    inputType: TextInputType.url),
                const SizedBox(height: 10),
              ],

              Container(
                width: width * 0.9,
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12)),
                child: TextFieldTags(
                  textfieldTagsController: _textfieldTagsController,
                  initialTags: const [],
                  textSeparators: const [','],
                  letterCase: LetterCase.small,
                  validator: (String tag) {
                    if (_textfieldTagsController.getTags!.contains(tag)) {
                      return 'you already entered that';
                    }
                    return null;
                  },
                  inputfieldBuilder:
                      (context, tec, fn, error, onChanged, onSubmitted) {
                    return ((context, tagsScrollController, tagsList,
                        onTagDelete) {
                      return TextFormField(
                        controller: tec,
                        focusNode: fn,
                        cursorColor: blackColor,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            right: 6,
                            left: 24,
                          ),
                          isDense: true,
                          border: InputBorder.none,
                          suffixIcon: const Icon(
                            Icons.tag,
                            color: blackColor,
                          ),
                          hintText: _textfieldTagsController.hasTags
                              ? ''
                              : "Enter comma separated tags..",
                          hintStyle: const TextStyle(
                              color: blackColor,
                              fontSize: 14,
                              fontFamily: AppFontFamily.poppinsMedium),
                          errorText: error,
                          prefixIconConstraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width),
                          prefixIcon: tagsList.isNotEmpty
                              ? SingleChildScrollView(
                                  controller: tagsScrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: tagsList.map((String tag) {
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
                                          horizontal: 10.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                      );
                    });
                  },
                ),
              ),

              const SizedBox(height: 10),

              Field(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, 'please_enter_people_allow')
                          .toString();
                    }
                    return null;
                  },
                  controller: _eventPeopleController,
                  label: getTranslated(context, 'people_allow').toString(),
                  icon: const Icon(Icons.group_outlined),
                  isPassword: false,
                  inputType: TextInputType.number),
            ],
          ),
        ),
        isActive: currentStep >= 2,
        state: currentStep == 2
            ? StepState.editing
            : currentStep < 2
                ? StepState.disabled
                : StepState.complete,
      ),
    ];
  }

  Widget _eventStatus() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 48,
      decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)),
      child: DropDownTextField(
        controller: controller,
        listBorderColor: whiteColor,
        listBgColor: whiteColor,
        clearOption: true,
        clearIconProperty: IconProperty(color: primaryColor),
        searchTextStyle: const TextStyle(color: Colors.red),
        searchDecoration: const InputDecoration(hintText: "Search by Type"),
        listTextStyle: const TextStyle(
          fontSize: 16,
          color: blackColor,
          fontFamily: AppFontFamily.poppinsMedium,
        ),
        textStyle: const TextStyle(fontSize: 16),
        textFieldDecoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            label: const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text(
                'Event Status',
                style: TextStyle(
                  fontSize: 16,
                  color: blackColor,
                  fontFamily: AppFontFamily.poppinsMedium,
                ),
              ),
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: primaryColor))),
        validator: (value) {
          if (value == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        dropDownItemCount: 5,
        dropDownList: const [
          DropDownValueModel(name: 'Active', value: "Active"),
          DropDownValueModel(name: 'InActive', value: "InActive"),
        ],
        onChanged: (val) {
          try {
            DropDownValueModel model = val as DropDownValueModel;
            setState(() {
              eventStatus = model.value;
            });
          } catch (e) {
            debugPrint(e.toString());
          }
        },
      ),
    );
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        child: Text(
                          getTranslated(context, 'select_event_category')
                              .toString(),
                          style: const TextStyle(
                              color: whiteColor,
                              fontSize: 16,
                              fontFamily: AppFontFamily.poppinsMedium),
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
                            category = eventProvider.categories[index].name!;
                            categoryId =
                                eventProvider.categories[index].id!.toInt();
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
                                  fontSize: 16, color: blackColor),
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (scannerId.every((element) =>
                                  element !=
                                  scannerProvider.scanners[index].id
                                      .toString())) {
                                scannerId.add(scannerProvider.scanners[index].id
                                    .toString());
                                scannerName.add(
                                    "${scannerProvider.scanners[index].firstName ?? ''} ${scannerProvider.scanners[index].lastName ?? ''}");
                              } else if (scannerId.any((element) =>
                                  element ==
                                  scannerProvider.scanners[index].id
                                      .toString())) {
                                int indexId = scannerId.indexWhere((element) =>
                                    element ==
                                    scannerProvider.scanners[index].id
                                        .toString());
                                scannerId.removeAt(indexId);
                                int indexName = scannerName.indexWhere((element) =>
                                    element ==
                                    "${scannerProvider.scanners[index].firstName ?? ''} ${scannerProvider.scanners[index].lastName ?? ''}");
                                scannerName.removeAt(indexName);
                              }
                              setState(() {});
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${scannerProvider.scanners[index].firstName!} ${scannerProvider.scanners[index].lastName!}",
                                style: const TextStyle(
                                    fontSize: 18, color: blackColor),
                              ),
                              scannerId.any((element) =>
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

  Widget _eventType() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 48,
      decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)),
      child: DropDownTextField(
        controller: controller,
        listBorderColor: whiteColor,
        listBgColor: whiteColor,
        clearOption: true,
        clearIconProperty: IconProperty(color: primaryColor),
        searchTextStyle: const TextStyle(color: Colors.red),
        searchDecoration: const InputDecoration(hintText: "Search by Type"),
        listTextStyle: const TextStyle(
          fontSize: 16,
          color: blackColor,
          fontFamily: AppFontFamily.poppinsMedium,
        ),
        textStyle: const TextStyle(fontSize: 16),
        textFieldDecoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            label: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                getTranslated(context, 'event_type').toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: blackColor,
                  fontFamily: AppFontFamily.poppinsMedium,
                ),
              ),
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: primaryColor))),
        validator: (value) {
          if (value == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        dropDownItemCount: 5,
        dropDownList: const [
          DropDownValueModel(name: 'Online', value: "Online"),
          DropDownValueModel(name: 'Offline', value: "Offline"),
        ],
        onChanged: (val) {
          try {
            DropDownValueModel model = val as DropDownValueModel;
            debugPrint("Value is ${model.value}");

            setState(() {
              eventType = model.value;
            });
          } catch (e) {
            debugPrint(e.toString());
          }
        },
      ),
    );
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
                        DateFormat('MMM dd yyyy').format(startDate!),
                        style: const TextStyle(color: whiteColor, fontSize: 24),
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
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      return isSameDay(startDate, day);
                    },
                    onDaySelected: (selectedStartDate, focusedDay) {
                      setState(() {
                        startDate = selectedStartDate;
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
                        DateFormat('MMM dd yyyy').format(endDate!),
                        style: const TextStyle(color: whiteColor, fontSize: 24),
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
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      return isSameDay(endDate, day);
                    },
                    onDaySelected: (selectEndDate, focusedDay) {
                      setState(() {
                        endDate = selectEndDate;
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
    DateTime? tempTime = startTime ?? DateTime.now();
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
                                startTime = tempTime;
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
                          tempTime = value;
                        },
                        initialDateTime: tempTime,
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
    DateTime? tempTime = endTime ?? DateTime.now();
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
                                endTime = tempTime;
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
                          tempTime = value;
                        },
                        initialDateTime: tempTime,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
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
