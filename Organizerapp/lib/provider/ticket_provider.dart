import 'package:eventright_organizer/constant/common_function.dart';
import 'package:eventright_organizer/model/add_ticket_model.dart';
import 'package:eventright_organizer/model/delete_ticket_model.dart';
import 'package:eventright_organizer/model/edit_ticket_model.dart';
import 'package:eventright_organizer/model/ticket_details_model.dart';
import 'package:eventright_organizer/model/tickets_model.dart';
import 'package:eventright_organizer/retrofit/api_client.dart';
import 'package:eventright_organizer/retrofit/api_header.dart';
import 'package:eventright_organizer/retrofit/base_model.dart';
import 'package:eventright_organizer/retrofit/error_handler.dart';
import 'package:flutter/cupertino.dart';

class TicketProvider extends ChangeNotifier {
  /// call api for tickets ///

  bool _ticketsLoader = false;

  bool get ticketsLoader => _ticketsLoader;

  List<TicketData> tickets = [];

  Future<BaseModel<TicketsModel>> callApiForTickets(id) async {
    TicketsModel response;
    _ticketsLoader = true;
    notifyListeners();

    try {
      tickets.clear();
      response = await RestClient(
        RetroApi().dioData(),
      ).tickets(id);
      if (response.success == true) {
        _ticketsLoader = false;
        notifyListeners();
        if (response.data != null) {
          tickets.addAll(response.data!);
        }
        notifyListeners();
      }
    } catch (error) {
      _ticketsLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for ticket details ///

  bool _ticketDetailsLoader = false;

  bool get ticketDetailsLoader => _ticketDetailsLoader;

  String ticketName = '';
  String ticketDescription = '';
  int howMuchTicket = 0;
  int ticketPrice = 0;
  int maximumCheckIns = 0;
  String startTime = '';
  String endTime = '';
  int visibility = 0;
  int ticketPerOrder = 0;
  String ticketType = '';

  Future<BaseModel<TicketDetailsModel>> callApiForTicketDetails(id) async {
    TicketDetailsModel response;
    _ticketDetailsLoader = true;
    notifyListeners();

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).ticketDetails(id);

      if (response.success == true) {
        _ticketDetailsLoader = false;
        notifyListeners();
        if (response.data!.name != null) {
          ticketName = response.data!.name!;
        }
        if (response.data!.description != null) {
          ticketDescription = response.data!.description!;
        }
        if (response.data!.quantity != null) {
          howMuchTicket = response.data!.quantity!.toInt();
        }
        if (response.data!.price != null) {
          ticketPrice = response.data!.price!.toInt();
        }
        if (response.data!.maximumCheckIns != null) {
          maximumCheckIns = response.data!.maximumCheckIns!.toInt();
        }
        if (response.data!.startTime != null) {
          startTime = response.data!.startTime!;
        }
        if (response.data!.endTime != null) {
          endTime = response.data!.endTime!;
        }
        if (response.data!.status != null) {
          visibility = response.data!.status!.toInt();
        }
        if (response.data!.ticketPerOrder != null) {
          ticketPerOrder = response.data!.ticketPerOrder!.toInt();
        }
        if (response.data!.type != null) {
          ticketType = response.data!.type!;
        }

        notifyListeners();
      }
    } catch (error) {
      _ticketDetailsLoader = false;
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for add ticket ///
  bool _addTicketsLoader = false;
  bool get addTicketsLoader => _addTicketsLoader;
  Future<BaseModel<AddTicketModel>> callApiForAddTicket(body) async {
    AddTicketModel response;
    _addTicketsLoader = true;
    notifyListeners();
    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).addTicket(body);

      if (response.success == true) {
        notifyListeners();
      }
    } catch (error) {
      _addTicketsLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    _addTicketsLoader = false;
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for edit ticket ///

  Future<BaseModel<EditTicketModel>> callApiForEditTicket(body) async {
    EditTicketModel response;

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).editTicket(body);

      if (response.success == true) {
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

  /// call api for delete ticket ///

  Future<BaseModel<DeleteTicketModel>> callApiForDeleteTicket(id) async {
    DeleteTicketModel response;

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).deleteTicket(id);

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
}
