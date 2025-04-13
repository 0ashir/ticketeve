import 'dart:developer';

import 'package:eventright_pro_user/model/all_tax_model.dart';
import 'package:eventright_pro_user/model/event_tickets_model.dart';
import 'package:eventright_pro_user/model/ticket_details_model.dart';
import 'package:eventright_pro_user/retrofit/api_client.dart';
import 'package:eventright_pro_user/retrofit/base_model.dart';
import 'package:eventright_pro_user/retrofit/server_error.dart';
import 'package:eventright_pro_user/retrofit/api_header.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class TicketProvider extends ChangeNotifier {
  /// call api for event ticket ///

  bool _eventTicketLoader = false;

  bool get eventTicketLoader => _eventTicketLoader;

  List<Ticket> ticketData = [];
  String organizerName = '';
  String eventName = '';
  Module? module;

  Future<BaseModel<EventTicketsModel>> callApiForEventTickets(id) async {
    EventTicketsModel response;
    _eventTicketLoader = true;
    notifyListeners();

    try {
      ticketData.clear();
      if (kDebugMode) {
        print("Ticket Id : $id");
      }
      response = await RestClient(RetroApi().dioData()).eventTickets(id);
      if (response.success == true) {
        log(response.data!.toJson().toString());
        _eventTicketLoader = false;
        notifyListeners();

        ticketData.addAll(response.data!.ticket!);
        module = response.data!.module;
        if (response.data!.eventName != null) {
          eventName = response.data!.eventName!;
        }
        if (response.data!.organization != null) {
          organizerName = response.data!.organization!;
        }
        notifyListeners();
      }
    } catch (error) {
      _eventTicketLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for ticket details ///

  bool _ticketDetailsLoader = false;

  bool get ticketDetailsLoader => _ticketDetailsLoader;

  String startDate = '';
  String endDate = '';
  int price = 0;
  int qty = 0;
  bool soldOut = false;
  int tickerPerOrder = 0;
  String time = '';
  int ticketEventId = 0;
  int ticketId = 0;
  String ticketType = '';
  num allDay = 0;

  Future<BaseModel<TicketDetailsModel>> callApiForTicketDetails(id) async {
    TicketDetailsModel response;
    _ticketDetailsLoader = true;
    notifyListeners();

    try {
      if (kDebugMode) {
        print("Ticket Id Details : $id");
      }
      response = await RestClient(RetroApi().dioData()).ticketDetails(id);
      if (response.success == true) {
        _ticketDetailsLoader = false;
        notifyListeners();
        if (response.data!.startTime != null &&
            response.data!.endTime != null) {
          startDate = DateFormat('MMM dd yyyy hh:mm aa')
              .format(DateTime.parse(response.data!.startTime!));
          endDate = DateFormat('MMM dd yyyy hh:mm aa')
              .format(DateTime.parse(response.data!.endTime!));
          time =
              "${DateFormat('hh:mm aa').format(DateTime.parse(response.data!.startTime!))} - ${DateFormat('hh:mm aa').format(DateTime.parse(response.data!.endTime!))}";
        }
        ticketType = response.data!.type ?? "";
        allDay = response.data!.allDay ?? 0;
        if (response.data!.eventId != null) {
          ticketEventId = response.data!.eventId!.toInt();
          ticketId = response.data!.id!.toInt();
          notifyListeners();
        }
        if (response.data!.price != null) {
          price = response.data!.price!.toInt();
          notifyListeners();
        }
        if (response.data!.quantity != null) {
          qty = response.data!.quantity!.toInt();
          notifyListeners();
        }
        if (response.data!.soldOut != null) {
          soldOut = response.data!.soldOut!;
          notifyListeners();
        }
        if (response.data!.ticketPerOrder != null) {
          tickerPerOrder = response.data!.ticketPerOrder!.toInt();
          notifyListeners();
        }
        notifyListeners();
      }
    } catch (error) {
      _ticketDetailsLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for tax ///

  List<TaxData> allTax = [];
  int totalTax = 0;

  Future<BaseModel<AllTaxModel>> callApiForTax(id) async {
    AllTaxModel response;

    try {
      allTax.clear();
      totalTax = 0;
      response = await RestClient(RetroApi().dioData()).allTax(id);

      if (response.success == true) {
        allTax.addAll(response.data!);

        for (int i = 0; i < response.data!.length; i++) {
          totalTax += response.data![i].price!.toInt();
        }
        notifyListeners();
      }
    } catch (error) {
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }
}
