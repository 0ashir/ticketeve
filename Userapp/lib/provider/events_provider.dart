import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:eventright_pro_user/model/add_favorite_model.dart';
import 'package:eventright_pro_user/model/all_events_model.dart';
import 'package:eventright_pro_user/model/category_model.dart';
import 'package:eventright_pro_user/model/events_detail_model.dart';
import 'package:eventright_pro_user/model/favorite_model.dart';
import 'package:eventright_pro_user/model/report_event_model.dart';
import 'package:eventright_pro_user/retrofit/api_client.dart';
import 'package:eventright_pro_user/retrofit/api_header.dart';
import 'package:eventright_pro_user/retrofit/base_model.dart';
import 'package:eventright_pro_user/retrofit/server_error.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  /// call api for favorites ///

  bool _favoriteLoader = false;

  bool get favoriteLoader => _favoriteLoader;
  List<FavoriteData> favoriteData = [];

  Future<BaseModel<FavoriteModel>> callApiForFavorite() async {
    FavoriteModel response;
    _favoriteLoader = true;
    notifyListeners();

    try {
      favoriteData.clear();
      response = await RestClient(RetroApi().dioData()).favorite();

      if (response.success == true) {
        _favoriteLoader = false;
        notifyListeners();

        favoriteData.addAll(response.data!);
        notifyListeners();
      }
    } catch (error) {
      _favoriteLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for events ///

  bool _allEventsLoader = false;

  bool get allEventsLoader => _allEventsLoader;
  List<Events> eventsData = [];
  List<Events> backup = [];

  String topEventName = '';
  String topEventDescription = '';
  bool topIsLike = false;
  String topEventDate = '';
  String topEventImage = '';
  int topEventId = 0;

  Future<BaseModel<AllEventsModel>> callApiForAllEvents(body) async {
    AllEventsModel response;

    try {
      _allEventsLoader = true;
      notifyListeners();
      eventsData.clear();
      response = await RestClient(RetroApi().dioData()).allEvents(body);
      if (response.success == true) {
        if (response.data!.events != null) {
          eventsData.addAll(response.data!.events!);
        }
        notifyListeners();
      }
      _allEventsLoader = false;
      notifyListeners();
    } catch (error) {
      _allEventsLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }

    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for event details ///

  bool _eventDetailsLoader = false;

  bool get eventDetailsLoader => _eventDetailsLoader;
  List<RecentEvent> recentEvents = [];
  String sEventName = '';
  String sOrganizer = '';
  int organizerId = 0;
  String sDate = '';
  String eDate = '';
  String sTime = '';
  String sAddress = '';
  List<String> gallery = [];
  List<String> tags = [];
  String sDescription = '';
  int eventId = 0;
  String sImage = '';
  String eventType = '';
  bool isLike = false;
  String organizerImage = '';
  bool organizerFollow = false;
  String shareUrl = "";

  Future<BaseModel<EventsDetailModel>> callApiForEventDetails(id) async {
    EventsDetailModel response;
    _eventDetailsLoader = true;
    notifyListeners();

    try {
      recentEvents.clear();
      tags.clear();
      gallery.clear();
      response = await RestClient(RetroApi().dioData()).eventDetails(id);
      if (response.success == true) {
        _eventDetailsLoader = false;
        notifyListeners();

        if (response.data!.name != null) {
          sEventName = response.data!.name!;
        }
        shareUrl = response.data!.shareUrl ?? "";
        if (response.data!.organization!.id != null) {
          organizerId = response.data!.organization!.id!.toInt();
          eventId = response.data!.id!;
        }

        if (response.data!.organization!.imagePath != null) {
          organizerImage = response.data!.organization!.imagePath!;
        }

        if (response.data!.organization!.isFollow != null) {
          organizerFollow = response.data!.organization!.isFollow!;
        }

        if (response.data!.organization != null) {
          sOrganizer = response.data!.organization!.firstName ?? "";
        }

        if (response.data!.description != null) {
          sDescription = response.data!.description!;
        }

        if (response.data!.date != null) {
          sDate = response.data!.date!;
        }
        if (response.data!.endDate != null) {
          eDate = response.data!.endDate ?? "";
        }

        if (response.data!.type != null) {
          eventType = response.data!.type!;
        }

        if (response.data!.isLike != null) {
          isLike = response.data!.isLike!;
        }

        if (response.data!.startTime != null &&
            response.data!.endTime != null) {
          sTime = "${response.data!.startTime!} - ${response.data!.endTime!}";
        }

        if (response.data!.address != null) {
          sAddress = response.data!.address!;
        }

        if (response.data!.imagePath != null && response.data!.image != null) {
          sImage = response.data!.imagePath! + response.data!.image!;
        }

        if (response.data!.hasTag != null) {
          for (int i = 0; i < response.data!.hasTag!.length; i++) {
            tags.add(response.data!.hasTag![i]);
          }
        }

        if (response.data!.gallery != null) {
          for (int i = 0; i < response.data!.gallery!.length; i++) {
            gallery.add(response.data!.imagePath! + response.data!.gallery![i]);
          }
        }

        if (response.data!.recentEvent != null) {
          recentEvents.addAll(response.data!.recentEvent!);
        }

        notifyListeners();
      }
    } catch (error) {
      _eventDetailsLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for add favorite ///

  Future<BaseModel<AddFavoriteModel>> callApiForAddFavorite(body) async {
    AddFavoriteModel response;

    try {
      response = await RestClient(RetroApi().dioData()).addFavorite(body);
      if (response.success == true) {
        CommonFunction.toastMessage(response.msg!);
        notifyListeners();
      } else if (response.success == false) {
        if (response.msg != null) CommonFunction.toastMessage(response.msg!);
      }
    } catch (error) {
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for category ///

  bool _categoryLoader = false;

  bool get categoryLoader => _categoryLoader;
  List<CategoryData> category = [];

  Future<BaseModel<CategoryModel>> callApiForCategory() async {
    CategoryModel response;
    _categoryLoader = true;
    notifyListeners();

    try {
      category.clear();
      response = await RestClient(RetroApi().dioData()).category();
      if (response.success == true) {
        _categoryLoader = false;
        notifyListeners();

        category.add(CategoryData(name: "All"));
        category.addAll(response.data!);

        notifyListeners();
      }
    } catch (error) {
      _categoryLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }

    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for report event ///

  bool _reportLoader = false;

  bool get reportLoader => _reportLoader;

  Future<BaseModel<ReportEventModel>> callApiForReportEvent(body) async {
    ReportEventModel response;
    _reportLoader = true;
    notifyListeners();

    try {
      response = await RestClient(RetroApi().dioData()).reportEvent(body);
      if (response.success == true) {
        _reportLoader = false;
        notifyListeners();
      }
    } catch (error) {
      _reportLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  searchEventsByQuery(String? query) {
    if (query == null || query.isEmpty) {
      eventsData = backup;
      notifyListeners();
      return;
    }
    if (backup.isEmpty) {
      backup = eventsData;
    }
    //querying from the full  list
    eventsData = backup.where((event) {
      final eventName = event.name?.toLowerCase() ?? "";
      // final eventTags = event.hasTag?.map((tag) => tag.toLowerCase()).toList() ?? [];
      final lowerQuery = query.toLowerCase();

      // return eventName.contains(lowerQuery) || eventTags.any((tag) => tag.contains(lowerQuery));
      return eventName.contains(lowerQuery);
    }).toList();
    notifyListeners();
    return;
  }

  filterEventsByDay(DateTime? selectedDate) {
    if (selectedDate == null) {
      eventsData = backup;
      notifyListeners();
      return;
    }
    if (backup.isEmpty) {
      backup = eventsData;
    }
    //querying from the full  list
    eventsData = backup.where((event) {
      DateTime eventDate = DateTime.parse(event.startTime!);
      return eventDate.year == selectedDate.year &&
          eventDate.month == selectedDate.month &&
          eventDate.day == selectedDate.day;
    }).toList();
    notifyListeners();
    return;
  }
}
