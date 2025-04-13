import 'dart:convert';
import 'dart:io';
import 'package:eventright_organizer/constant/common_function.dart';
import 'package:eventright_organizer/constant/preferences.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/model/add_event_model.dart';
import 'package:eventright_organizer/model/add_gallery_image_response_model.dart';
import 'package:eventright_organizer/model/all_events_model.dart';
import 'package:eventright_organizer/model/cancel_event_model.dart';
import 'package:eventright_organizer/model/category_model.dart';
import 'package:eventright_organizer/model/delete_event_model.dart';
import 'package:eventright_organizer/model/delete_notification_model.dart';
import 'package:eventright_organizer/model/edit_event_model.dart';
import 'package:eventright_organizer/model/enums.dart';
import 'package:eventright_organizer/model/event_details_model.dart';
import 'package:eventright_organizer/model/guest_list_model.dart';
import 'package:eventright_organizer/model/notification_model.dart';
import 'package:eventright_organizer/model/search_event_model.dart';
import 'package:eventright_organizer/retrofit/api_client.dart';
import 'package:eventright_organizer/retrofit/api_header.dart';
import 'package:eventright_organizer/retrofit/base_model.dart';
import 'package:eventright_organizer/retrofit/error_handler.dart';
import 'package:eventright_organizer/routes/route_names.dart';
import 'package:eventright_organizer/screens/auth/sign_in_screen.dart';
import 'package:eventright_organizer/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EventProvider extends ChangeNotifier {
  /// call api for notification ///

  bool _notificationLoader = false;

  bool get notificationLoader => _notificationLoader;

  List<NotificationData> notificationData = [];

  refresh() {
    notifyListeners();
  }

  Future<BaseModel<NotificationModel>> callApiForNotification() async {
    NotificationModel response;
    _notificationLoader = true;
    notifyListeners();

    try {
      notificationData.clear();
      response = await RestClient(
        RetroApi().dioData(),
      ).notification();
      if (response.success == true) {
        _notificationLoader = false;
        notifyListeners();

        if (response.data!.isNotEmpty) {
          notificationData.addAll(response.data!);
        }
      }
    } catch (error) {
      _notificationLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for delete notification ///

  Future<BaseModel<DeleteNotificationModel>>
      callApiForDeleteNotification() async {
    DeleteNotificationModel response;

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).deleteNotification();
      if (response.success == true) {
        CommonFunction.toastMessage(response.msg!);
        notifyListeners();
      }
    } catch (error) {
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for all events ///
  bool _eventsLoader = false;

  bool get eventLoader => _eventsLoader;
  List<Ongoing> ongoingEvents = [];
  List<Past> pastEvents = [];
  List<Draft> draftEvents = [];
  List<Upcoming> upcomingEvents = [];

  Future<BaseModel<AllEventsModel>> callApiForAllEvents() async {
    AllEventsModel response;
    _eventsLoader = true;
    notifyListeners();

    try {
      ongoingEvents.clear();
      pastEvents.clear();
      pastEvents.clear();
      upcomingEvents.clear();
      draftEvents.clear();
      response = await RestClient(RetroApi().dioData()).allEvents();
      if (response.success == true) {
        _eventsLoader = false;
        notifyListeners();

        if (response.data!.ongoing != null &&
            response.data!.ongoing!.isNotEmpty) {
          ongoingEvents.addAll(response.data!.ongoing!);
        }
        if (response.data!.past != null) {
          pastEvents.addAll(response.data!.past!);
        }
        if (response.data!.upcoming != null) {
          upcomingEvents.addAll(response.data!.upcoming!);
        }
        if (response.data!.draft != null) {
          draftEvents.addAll(response.data!.draft!);
        }
        notifyListeners();
      }
    } catch (error) {
      _eventsLoader = false;
      notifyListeners();
      return BaseModel()..setException(ErrorClass.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for guest list ///

  bool _guestLoader = false;

  bool get guestLoader => _guestLoader;
  List<GuestData> guest = [];

  Future<BaseModel<GuestListModel>> callApiForGuest(id) async {
    GuestListModel response;
    _guestLoader = true;
    notifyListeners();

    try {
      guest.clear();
      response = await RestClient(
        RetroApi().dioData(),
      ).guest(id);

      if (response.success == true) {
        _guestLoader = false;
        notifyListeners();

        if (response.data != null) {
          guest.addAll(response.data!);
        }

        notifyListeners();
      }
    } catch (error) {
      _guestLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for eventDetails ///

  bool _eventDetailsLoader = false;

  bool get eventDetailsLoader => _eventDetailsLoader;

  dynamic totalTicket;
  dynamic soldTicket;
  String eventName = '';
  String startTime = '';
  String endTime = '';
  String categoryName = '';
  List<String> gallery = [];
  List<String> tags = [];
  double rate = 0;
  String description = "";
  int people = 0;
  int? eventId;
  String eventImage = '';
  String imagePath = '';
  EventTypes? eventType;
  List<String> eventScannerId = [];
  int eventStatus = 0;
  double lat = 0;
  double lang = 0;
  String address = "";
  String url = "";

  Future<BaseModel<EventDetailsModel>> callApiForEventDetails(id) async {
    EventDetailsModel response;
    _eventDetailsLoader = true;
    notifyListeners();

    try {
      gallery.clear();
      tags.clear();
      response = await RestClient(RetroApi().dioData()).eventDetails(id);

      if (response.success == true) {
        _eventDetailsLoader = false;
        eventScannerId.clear();
        notifyListeners();

        if (response.data!.id != null) {
          eventId = response.data!.id!.toInt();
        }
        address = response.data!.address != null ? response.data!.address! : "";
        lat = response.data!.lat != null
            ? double.parse(response.data!.lat!)
            : 0.0;
        lang = response.data!.lang != null
            ? double.parse(response.data!.lang!)
            : 0.0;
        if (response.data!.scannerId != null) {
          List<String> scannerIdList = response.data!.scannerId
              .toString()
              .split(',')
              .map((s) => s)
              .toList();
          for (int i = 0; i < scannerIdList.length; i++) {
            eventScannerId.add(scannerIdList[i]);
          }
        }
        url = response.data!.url ?? "";
        if (response.data!.type != null) {
          eventType = response.data!.type!;
        }
        if (response.data!.status != null) {
          eventStatus = response.data!.status!.toInt();
        }
        if (response.data!.name != null) {
          eventName = response.data!.name!;
        }
        if (response.data!.category?.name != null) {
          categoryName = response.data!.category!.name!;
        }
        if (response.data!.imagePath != null && response.data!.image != null) {
          eventImage = response.data!.imagePath! + response.data!.image!;
        }
        if (response.data!.imagePath != null) {
          imagePath = response.data!.imagePath!;
        }
        if (response.data!.rate != null) {
          rate = response.data!.rate!.toDouble();
        }
        if (response.data!.people != null) {
          people = response.data!.people!.toInt();
        }
        if (response.data!.description != null) {
          description = response.data!.description!;
        }
        if (response.data!.gallery != null &&
            response.data!.gallery!.isNotEmpty) {
          for (int i = 0; i < response.data!.gallery!.length; i++) {
            gallery.add(response.data!.gallery![i]);
          }
        }
        if (response.data!.tags != null) {
          for (int i = 0; i < response.data!.tags!.length; i++) {
            tags.add(response.data!.tags![i]);
          }
        }
        if (response.data!.startTime != null) {
          startTime = response.data!.startTime!;
        }
        if (response.data!.endTime != null) {
          endTime = response.data!.endTime!;
        }
        if (response.data!.soldTickets != null) {
          soldTicket = response.data!.soldTickets!;
        }
        if (response.data!.totalTickets != null) {
          totalTicket = response.data!.totalTickets!;
        }

        notifyListeners();
      }
    } catch (error) {
      _eventDetailsLoader = false;
      notifyListeners();
      return BaseModel()..setException(ErrorClass.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for edit event ///

  Future<BaseModel<EditEventModel>> callApiForEditEvent(body, context) async {
    EditEventModel response;

    try {
      _eventsLoader = true;
      notifyListeners();
      response = await RestClient(RetroApi().dioData()).editEvent(body);
      if (response.success == true) {
        if (response.msg != null) {
          CommonFunction.toastMessage(response.msg!);
        }
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        notifyListeners();
      } else if (response.success == false) {
        if (response.msg != null) {
          CommonFunction.toastMessage(response.msg!);
        }
      }
      _eventsLoader = false;
      notifyListeners();
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }
      _eventsLoader = false;
      notifyListeners();
      return BaseModel()..setException(ErrorClass.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  Future<BaseModel<GalleryImageAddRemoveResponseModel>> eventImageRemove(
      Map<String, dynamic> body) async {
    GalleryImageAddRemoveResponseModel response;
    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).eventGalleryImageRemove(body);
      if (response.success == true) {
        if (response.msg != null) {
          CommonFunction.toastMessage(response.msg!);
        }
      }
    } catch (error) {
      return BaseModel()..setException(ErrorClass.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<GalleryImageAddRemoveResponseModel>> eventImageAdd(
      Map<String, dynamic> body) async {
    GalleryImageAddRemoveResponseModel response;
    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).eventGalleryImageAdd(body);
      if (response.success == true) {
        if (response.msg != null) {
          CommonFunction.toastMessage(response.msg!);
        }
      }
    } catch (error) {
      return BaseModel()..setException(ErrorClass.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  /// call api for category ///

  List<CategoryData> categories = [];

  Future<BaseModel<CategoryModel>> callApiForCategory() async {
    CategoryModel response;

    try {
      categories.clear();
      response = await RestClient(
        RetroApi().dioData(),
      ).category();
      if (response.success == true) {
        if (response.data != null) {
          categories.addAll(response.data!);
        }
        notifyListeners();
      }
    } catch (error) {
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  bool _createEventLoader = false;
  bool get createEventLoader => _createEventLoader;

  /// call api for add event ///

  Future<BaseModel<AddEventModel>> callApiForAddEvent(body, context) async {
    AddEventModel response;
    _createEventLoader = true;
    notifyListeners();
    debugPrint('FUNCTION CALLEDD');
    try {
      response = await RestClient(RetroApi().dioData()).addEvent(body);
      debugPrint('GOT RESPONSE ${response.data}');
      if (response.success == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
        notifyListeners();
      }
    } catch (error) {
      _createEventLoader = false;
      notifyListeners();
      return BaseModel()..setException(ErrorClass.withError(error: error));
    }
    _createEventLoader = false;
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for search event ///

  bool _searchLoader = false;

  bool get searchLoader => _searchLoader;

  List<SearchData> searchEvents = [];

  Future<BaseModel<SearchEventModel>> callApiForSearchEvent() async {
    SearchEventModel response;
    _searchLoader = true;
    notifyListeners();

    try {
      searchEvents.clear();
      response = await RestClient(
        RetroApi().dioData(),
      ).searchEvent();

      if (response.success == true) {
        _searchLoader = false;
        notifyListeners();
        if (response.data != null) {
          searchEvents.addAll(response.data!);
        }
        notifyListeners();
      }
    } catch (error) {
      _searchLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for delete event ///

  Future<BaseModel<DeleteEventModel>> callApiForDeleteEvent(id) async {
    DeleteEventModel response;

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).deleteEvent(id);
      if (response.success == true) {
        CommonFunction.toastMessage(response.msg!);
        notifyListeners();
      }
    } catch (error) {
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for cancel event ///

  Future<BaseModel<CancelEventModel>> callApiForCancelEvent(id) async {
    CancelEventModel response;

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).cancelEvent(id);

      if (response.success == true) {
        CommonFunction.toastMessage(response.msg!);
        notifyListeners();
      }
    } catch (error) {
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// choose event image ///

  File? eventImageFile;
  final picker = ImagePicker();
  String image = "";

  chooseProfileImage(context) {
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
                    _proImgFromGallery(context);
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(
                  getTranslated(context, 'camera').toString(),
                ),
                onTap: () {
                  _proImgFromCamera(context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _proImgFromGallery(context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      eventImageFile = File(pickedFile.path);
      List<int> imageBytes = eventImageFile!.readAsBytesSync();
      image = base64Encode(imageBytes);
      notifyListeners();
    } else {
      if (kDebugMode) {
        debugPrint('No image selected.');
      }
    }
  }

  void _proImgFromCamera(context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      eventImageFile = File(pickedFile.path);
      List<int> imageBytes = eventImageFile!.readAsBytesSync();
      image = base64Encode(imageBytes);
      if (kDebugMode) {
        debugPrint("image is $image");
      }
    } else {
      if (kDebugMode) {
        debugPrint('No image selected.');
      }
    }
    notifyListeners();
  }

  Future<void> logoutUser(context) async {
    SharedPreferenceHelper.clearPref();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const SignInScreen(),
      ),
      ModalRoute.withName(loginRoute),
    );
  }
}
