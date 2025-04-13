import 'package:event_right_scanner/Models/event_detail_model.dart';
import 'package:event_right_scanner/Models/single_ticket_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:event_right_scanner/DeviceUtil/const_strings.dart';
import 'package:event_right_scanner/Models/all_event_model.dart';
import 'package:event_right_scanner/Models/attendance_model.dart';
import 'package:event_right_scanner/Models/scanner_model.dart';
import 'package:event_right_scanner/Screen/Event/event_detail_screen.dart';
import 'package:event_right_scanner/api/retrofit_api.dart';
import 'package:event_right_scanner/api/base_model.dart';
import 'package:event_right_scanner/api/network_api.dart';
import 'package:event_right_scanner/api/server_error.dart';

class EventProvider extends ChangeNotifier {
  bool eventLoader = false;

  List<AllEventData> allEventList = [];
  List<AllEventData> searchAllEventList = [];

  Future<BaseModel<AllEventModel>> callApiAllEvent() async {
    AllEventModel response;
    eventLoader = true;
    notifyListeners();
    try {
      response = await RestClient(RetroApi().dioData()).allEventRequest();
      if (response.success == true) {
        eventLoader = false;
        allEventList.clear();
        allEventList.addAll(response.data!);
        notifyListeners();
      } else {
        eventLoader = false;
        notifyListeners();
      }
    } catch (error) {
      eventLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  List<String> eventDetailBannerList = [];
  int eventId = 0;
  String eventName = "";
  String eventDescription = "";
  String startTime = "";
  String endTime = "";
  int totalTicket = 0;
  int soldTicket = 0;
  int scanTicket = 0;

  Future<BaseModel<EventDetailModel>> callApiEventDetail(id) async {
    EventDetailModel response;
    eventLoader = true;
    eventDetailBannerList.clear();
    notifyListeners();
    try {
      response = await RestClient(RetroApi().dioData()).eventDetailRequest(id);
      if (response.success == true) {
        eventLoader = false;
        eventDetailBannerList.addAll(response.data!.gallery!);
        eventId = response.data!.id!;
        eventName = response.data!.name!;
        eventDescription = response.data!.description!;
        startTime = DateUtilShow1().formattedDate(DateTime.parse(response.data!.startTime!));
        endTime = DateUtilShow1().formattedDate(DateTime.parse(response.data!.endTime!));
        totalTicket = response.data!.totalTickets!;
        soldTicket = response.data!.soldTickets!;
        scanTicket = response.data!.scanTicket!;
        notifyListeners();
      } else {
        eventLoader = false;
        notifyListeners();
      }
    } catch (error) {
      eventLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  List<AttendanceData> attendanceList = [];
  List<AttendanceData> searchAttendanceList = [];

  Future<BaseModel<AttendanceModel>> callApiAttendance(id) async {
    AttendanceModel response;
    eventLoader = true;
    attendanceList.clear();
    notifyListeners();
    try {
      response = await RestClient(RetroApi().dioData()).attendanceRequest(id);
      if (response.success == true) {
        eventLoader = false;
        attendanceList.addAll(response.data!);
        notifyListeners();
      } else {
        eventLoader = false;
        notifyListeners();
      }
    } catch (error) {
      eventLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  String name = "";
  String ticketStartTime = "";
  String ticketEndTime = "";
  String ticketNumber = "";
  String ticketType = "";

  Future<BaseModel<SingleTicketModel>> callApiTicketDetail(id) async {
    SingleTicketModel response;
    eventLoader = true;
    allEventList.clear();
    notifyListeners();
    try {
      response = await RestClient(RetroApi().dioData()).singleTicketRequest(id);
      if (response.success == true) {
        eventLoader = false;
        name = response.data!.name!;
        ticketStartTime = response.data!.startTime!;
        ticketEndTime = response.data!.endTime!;
        ticketNumber = response.data!.ticketNumber!;
        ticketType = response.data!.ticketType!;
        notifyListeners();
      } else {
        eventLoader = false;
        notifyListeners();
      }
    } catch (error) {
      eventLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<ScannerModel>> callApiScan(ticketNumber, id, context) async {
    ScannerModel response;
    eventLoader = true;
    allEventList.clear();
    notifyListeners();
    try {

      if (kDebugMode) {
        print("Ticket Number :$ticketNumber");
        print("Event Id :$id");
      }
      response = await RestClient(RetroApi().dioData()).scannerRequest(ticketNumber, id);
      if (response.success == true) {
        eventLoader = false;
        Fluttertoast.showToast(msg: response.msg!);
        if (response.msg != null) {
          Fluttertoast.showToast(msg: response.msg!);
        }

        notifyListeners();
      } else {
        eventLoader = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetail(
              id: id,
            ),
          ),
        );
        if (response.msg != null) {
          Fluttertoast.showToast(msg: response.msg!);
        }
        notifyListeners();
      }
    } catch (error) {
      eventLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  @override
  notifyListeners();
}
