import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:eventright_pro_user/model/add_review_model.dart';
import 'package:eventright_pro_user/model/order_model.dart';
import 'package:eventright_pro_user/model/single_order_details_model.dart';
import 'package:eventright_pro_user/retrofit/api_client.dart';
import 'package:eventright_pro_user/retrofit/api_header.dart';
import 'package:eventright_pro_user/retrofit/base_model.dart';
import 'package:eventright_pro_user/retrofit/server_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class OrderProvider extends ChangeNotifier {
  /// call api for user orders ///

  bool _orderLoader = false;

  bool get orderLoader => _orderLoader;
  List<Upcoming> upcomingData = [];
  List<Past> pastData = [];

  Future<BaseModel<OrderModel>> callApiForOrders() async {
    OrderModel response;
    _orderLoader = true;
    notifyListeners();

    try {
      upcomingData.clear();
      pastData.clear();
      response = await RestClient(RetroApi().dioData()).order();

      if (response.success == true) {
        _orderLoader = false;
        notifyListeners();

        upcomingData.addAll(response.data!.upcoming!);
        pastData.addAll(response.data!.past!);
        notifyListeners();
      }
    } catch (error) {
      _orderLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for single order details ///

  bool _singleOrderLoader = false;

  bool get singleOrderLoader => _singleOrderLoader;

  String eventName = '';
  String eventDate = '';
  int? orderId = 0;
  double eventReview = 0;
  String eventTicketNo = '';
  int qty = 0;
  String bookingStatus = '';
  int eventId = 0;
  dynamic couponDiscount;
  dynamic eventPayment;
  String paymentStatus = '';
  String paymentGateWay = '';
  String eventImage = '';
  List<Tickets> tickets = [];

  Future<BaseModel<SingleOrderDetailsModel>> callApiForSingleOrderDetails(id) async {
    SingleOrderDetailsModel response;
    _singleOrderLoader = true;
    notifyListeners();

    try {
      tickets.clear();
      response = await RestClient(RetroApi().dioData()).singleOrderDetails(id);
      if (response.success == true) {
        _singleOrderLoader = false;
        notifyListeners();

        if (response.data!.orderChild != null) {
          tickets.addAll(response.data!.orderChild!);
        }
        if (response.data!.event != null) {
          eventId = response.data!.event!.id!.toInt();
          orderId = response.data!.id!.toInt();
        }
        if (response.data!.event!.name != null) {
          eventName = response.data!.event!.name!;
        }
        if (response.data!.event!.imagePath != null) {
          eventImage = response.data!.event!.imagePath! + response.data!.event!.image!;
        }

        if (response.data!.event!.startTime != null) {
          eventDate = DateFormat('MMM dd yyyy').format(DateTime.parse(response.data!.event!.startTime!));
        }
        if (response.data!.review != null) {
          eventReview = response.data!.review!.rate!.toDouble();
        } else {
          eventReview = 0;
        }
        if (response.data!.ticket!.ticketNumber != null) {
          eventTicketNo = response.data!.ticket!.ticketNumber!;
        }
        if (response.data!.paymentType != null) {
          paymentGateWay = response.data!.paymentType!;
        }
        if (response.data!.orderStatus != null) {
          bookingStatus = response.data!.orderStatus!;
        }
        if (response.data!.quantity != null) {
          qty = response.data!.quantity!.toInt();
        }
        if (response.data!.couponDiscount != null) {
          couponDiscount = response.data!.couponDiscount!;
        }
        if (response.data!.payment != null) {
          eventPayment = response.data!.payment!;
        }
        if (response.data!.paymentStatus != null) {
          paymentStatus = response.data!.paymentStatus!.toString();
        }
        notifyListeners();
      }
    } catch (error) {
      _singleOrderLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for addReview ///

  Future<BaseModel<AddReviewModel>> callApiForAddReview(body) async {
    AddReviewModel response;

    try {
      response = await RestClient(RetroApi().dioData()).addReview(body);
      if (response.success == true) {
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
}
