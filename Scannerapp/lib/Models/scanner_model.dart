import 'dart:convert';

class ScannerModel {
  String? _msg;
  bool? _success;
  Data? _data;

  ScannerModel({String? msg, bool? success, Data? data}) {
    if (msg != null) {
      _msg = msg;
    }
    if (success != null) {
      _success = success;
    }
    if (data != null) {
      _data = data;
    }
  }

  String? get msg => _msg;
  // set msg(String? msg) => _msg = msg;
  bool? get success => _success;
  // set success(bool? success) => _success = success;
  Data? get data => _data;
  // set data(Data? data) => _data = data;

  ScannerModel.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = Data.fromJson(json['data']);
    } else {
      _data = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = _msg;
    data['success'] = _success;
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

class Data {
  String? _paymentType;
  String? _amount;
  String? _currency;
  int? _eventId;
  TicketModel? _ticket;
  String? _remainingCheckins;
  List<SeatDetail>? _seatDetails;
  Data({
    String? paymentType,
    String? amount,
    String? currency,
    int? eventId,
    String? remainingCheckins,
    List<SeatDetail>? seatDetails,
  }) {
    if (paymentType != null) {
      _paymentType = paymentType;
    }
    if (amount != null) {
      _amount = amount;
    }
    if (currency != null) {
      _currency = currency;
    }
    if (eventId != null) {
      _eventId = eventId;
    }
    if (ticket != null) {
      _ticket = ticket;
    }
    if (remainingCheckins != null) {
      _remainingCheckins = remainingCheckins;
    }
    if (seatDetails != null) {
      _seatDetails = seatDetails;
    }
  }

  String? get paymentType => _paymentType;
  // set paymentType(String? paymentType) => _paymentType = paymentType;
  String? get amount => _amount;
  // set amount(String? amount) => _amount = amount;
  String? get currency => _currency;
  // set currency(String? currency) => _currency = currency;
  int? get eventId => _eventId;
  // set eventId(int? eventId) => _eventId = eventId;
  TicketModel? get ticket => _ticket;
  // set ticket(TicketModel? ticket) => _ticket = ticket;
  // ignore: unnecessary_getters_setters
  String? get remainingCheckins => _remainingCheckins;
  set remainingCheckins(String? remainingCheckins) => _remainingCheckins = remainingCheckins;
  // ignore: unnecessary_getters_setters
  List<SeatDetail>? get seatDetails => _seatDetails;
  set seatDetails(List<SeatDetail>? seatDetails) => _seatDetails = seatDetails;
  Data.fromJson(Map<String, dynamic> json) {
    _paymentType = json['payment_type'];
    _amount = json['amount'].toString();
    _currency = json['currency'];
    _eventId = json['event_id'];
    _remainingCheckins = json['remaining_check_ins'].toString().toLowerCase() == "null"
        ? "Unlimited"
        : json['remaining_check_ins'].toString();
    _ticket = TicketModel.fromJson(json['ticket']);
    _seatDetails =json['seat_details']!=null?List<SeatDetail>.from(jsonDecode(json['seat_details']).map((x) => SeatDetail.fromJson(x))):null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_type'] = _paymentType;
    data['amount'] = _amount;
    data['currency'] = _currency;
    data['event_id'] = _eventId;
    data['ticket'] = _ticket;
    data['remaining_check_ins'] = _remainingCheckins;
    return data;
  }
}

class TicketModel {
  int? _id;
  int? _eventId;
  int? _userId;
  dynamic _seatmapId;
  String? _ticketNumber;
  String? _name;
  String? _type;
  int? _allday;
  int? _maximumCheckins;
  int? _quantity;
  int? _ticketPerOrder;
  String? _startTime;
  String? _endTime;
  num? _price;
  String? _description;
  int? _status;
  int? _isDeleted;
  String? _createdAt;
  String? _updatedAt;


  TicketModel(
      {int? id,
      int? eventId,
      int? userId,
      dynamic seatmapId,
      String? ticketNumber,
      String? name,
      String? type,
      int? allday,
      int? maximumCheckins,
      int? quantity,
      int? ticketPerOrder,
      String? startTime,
      String? endTime,
      num? price,
      String? description,
      int? status,
      int? isDeleted,
      String? createdAt,
      String? updatedAt,
      }) {
    if (id != null) {
      _id = id;
    }
    if (eventId != null) {
      _eventId = eventId;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (seatmapId != null) {
      _seatmapId = seatmapId;
    }
    if (ticketNumber != null) {
      _ticketNumber = ticketNumber;
    }
    if (name != null) {
      _name = name;
    }
    if (type != null) {
      _type = type;
    }
    if (allday != null) {
      _allday = allday;
    }
    if (maximumCheckins != null) {
      _maximumCheckins = maximumCheckins;
    }
    if (quantity != null) {
      _quantity = quantity;
    }
    if (ticketPerOrder != null) {
      _ticketPerOrder = ticketPerOrder;
    }
    if (startTime != null) {
      _startTime = startTime;
    }
    if (endTime != null) {
      _endTime = endTime;
    }
    if (price != null) {
      _price = price;
    }
    if (description != null) {
      _description = description;
    }
    if (status != null) {
      _status = status;
    }
    if (isDeleted != null) {
      _isDeleted = isDeleted;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }

  }

  // ignore: unnecessary_getters_setters
  int? get id => _id;
  set id(int? id) => _id = id;
  // ignore: unnecessary_getters_setters
  int? get eventId => _eventId;
  set eventId(int? eventId) => _eventId = eventId;
  // ignore: unnecessary_getters_setters
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  // ignore: unnecessary_getters_setters
  dynamic get seatmapId => _seatmapId;
  set seatmapId(dynamic seatmapId) => _seatmapId = seatmapId;
  // ignore: unnecessary_getters_setters
  String? get ticketNumber => _ticketNumber;
  set ticketNumber(String? ticketNumber) => _ticketNumber = ticketNumber;
  // ignore: unnecessary_getters_setters
  String? get name => _name;
  set name(String? name) => _name = name;
  // ignore: unnecessary_getters_setters
  String? get type => _type;
  set type(String? type) => _type = type;
  // ignore: unnecessary_getters_setters
  int? get allday => _allday;
  set allday(int? allday) => _allday = allday;
  // ignore: unnecessary_getters_setters
  int? get maximumCheckins => _maximumCheckins;
  set maximumCheckins(int? maximumCheckins) => _maximumCheckins = maximumCheckins;
  // ignore: unnecessary_getters_setters
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;
  // ignore: unnecessary_getters_setters
  int? get ticketPerOrder => _ticketPerOrder;
  set ticketPerOrder(int? ticketPerOrder) => _ticketPerOrder = ticketPerOrder;
  // ignore: unnecessary_getters_setters
  String? get startTime => _startTime;
  set startTime(String? startTime) => _startTime = startTime;
  // ignore: unnecessary_getters_setters
  String? get endTime => _endTime;
  set endTime(String? endTime) => _endTime = endTime;
  // ignore: unnecessary_getters_setters
  num? get price => _price;
  set price(num? price) => _price = price;
  // ignore: unnecessary_getters_setters
  String? get description => _description;
  set description(String? description) => _description = description;
  // ignore: unnecessary_getters_setters
  int? get status => _status;
  set status(int? status) => _status = status;
  // ignore: unnecessary_getters_setters
  int? get isDeleted => _isDeleted;
  set isDeleted(int? isDeleted) => _isDeleted = isDeleted;
  // ignore: unnecessary_getters_setters
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  // ignore: unnecessary_getters_setters
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  // ignore: unnecessary_getters_setters


  TicketModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _eventId = json['event_id'];
    _userId = json['user_id'];
    _seatmapId = json['seatmap_id'];
    _ticketNumber = json['ticket_number'];
    _name = json['name'];
    _type = json['type'];
    _allday = json['allday'];
    _maximumCheckins = json['maximum_checkins'];
    _quantity = json['quantity'];
    _ticketPerOrder = json['ticket_per_order'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _price = json['price'];
    _description = json['description'];
    _status = json['status'];
    _isDeleted = json['is_deleted'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['event_id'] = _eventId;
    data['user_id'] = _userId;
    data['seatmap_id'] = _seatmapId;
    data['ticket_number'] = _ticketNumber;
    data['name'] = _name;
    data['type'] = _type;
    data['allday'] = _allday;
    data['maximum_checkins'] = _maximumCheckins;
    data['quantity'] = _quantity;
    data['ticket_per_order'] = _ticketPerOrder;
    data['start_time'] = _startTime;
    data['end_time'] = _endTime;
    data['price'] = _price;
    data['description'] = _description;
    data['status'] = _status;
    data['is_deleted'] = _isDeleted;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

class SeatDetail {
  String row;
  String seat;

  SeatDetail({required this.row, required this.seat});

  factory SeatDetail.fromJson(Map<String, dynamic> json) {
    return SeatDetail(
      row: json['row'].toString(),
      seat: json['seat'].toString(),
    );
  }

  @override
  String toString() {
    return 'Row: $row, Seat: $seat';
  }
}
