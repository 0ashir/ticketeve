class TicketDetailsModel {
  TicketDetailsModel({
    dynamic msg,
    Data? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  TicketDetailsModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  dynamic _msg;
  Data? _data;
  bool? _success;

  TicketDetailsModel copyWith({
    dynamic msg,
    Data? data,
    bool? success,
  }) =>
      TicketDetailsModel(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  dynamic get msg => _msg;

  Data? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    return map;
  }
}

class Data {
  Data({
    num? id,
    num? eventId,
    num? userId,
    String? ticketNumber,
    String? name,
    String? type,
    num? quantity,
    num? ticketPerOrder,
    String? startTime,
    String? endTime,
    num? price,
    String? description,
    num? status,
    num? isDeleted,
    String? eventName,
    String? organization,
    num? useTicket,
    bool? soldOut,
    num? allDay,
  }) {
    _id = id;
    _eventId = eventId;
    _userId = userId;
    _ticketNumber = ticketNumber;
    _name = name;
    _type = type;
    _quantity = quantity;
    _ticketPerOrder = ticketPerOrder;
    _startTime = startTime;
    _endTime = endTime;
    _price = price;
    _description = description;
    _status = status;
    _isDeleted = isDeleted;
    _eventName = eventName;
    _organization = organization;
    _useTicket = useTicket;
    _soldOut = soldOut;
    _allDay = allDay;
  }

  Data.fromJson(dynamic json) {
    _id = _parseNum(json['id']);
    _eventId = _parseNum(json['event_id']);
    _userId = _parseNum(json['user_id']);
    _ticketNumber = json['ticket_number']?.toString();
    _name = json['name']?.toString();
    _type = json['type']?.toString();
    _quantity = _parseNum(json['quantity']);
    _ticketPerOrder = _parseNum(json['ticket_per_order']);
    _startTime = json['start_time']?.toString();
    _endTime = json['end_time']?.toString();
    _price = _parseNum(json['price']);
    _description = json['description']?.toString();
    _status = _parseNum(json['status']);
    _isDeleted = _parseNum(json['is_deleted']);
    _eventName = json['event_name']?.toString();
    _organization = json['organization']?.toString();
    _useTicket = _parseNum(json['use_ticket']);
    _soldOut = json['sold_out'] ==
        1; // Assuming sold_out is represented by 1 for true/0 for false
    _allDay = _parseNum(json['allday']);
  }

  // Helper function to safely parse numeric values
  num? _parseNum(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is num) {
      return value;
    }
    if (value is String) {
      return num.tryParse(value);
    }
    return null;
  }

  num? _id;
  num? _eventId;
  num? _userId;
  String? _ticketNumber;
  String? _name;
  String? _type;
  num? _quantity;
  num? _ticketPerOrder;
  String? _startTime;
  String? _endTime;
  num? _price;
  String? _description;
  num? _status;
  num? _isDeleted;
  String? _eventName;
  String? _organization;
  num? _useTicket;
  bool? _soldOut;
  num? _allDay;

  Data copyWith({
    num? id,
    num? eventId,
    num? userId,
    String? ticketNumber,
    String? name,
    String? type,
    num? quantity,
    num? ticketPerOrder,
    String? startTime,
    String? endTime,
    num? price,
    String? description,
    num? status,
    num? isDeleted,
    String? eventName,
    String? organization,
    num? useTicket,
    bool? soldOut,
    num? allDay,
  }) =>
      Data(
        id: id ?? _id,
        eventId: eventId ?? _eventId,
        userId: userId ?? _userId,
        ticketNumber: ticketNumber ?? _ticketNumber,
        name: name ?? _name,
        type: type ?? _type,
        quantity: quantity ?? _quantity,
        ticketPerOrder: ticketPerOrder ?? _ticketPerOrder,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        price: price ?? _price,
        description: description ?? _description,
        status: status ?? _status,
        isDeleted: isDeleted ?? _isDeleted,
        eventName: eventName ?? _eventName,
        organization: organization ?? _organization,
        useTicket: useTicket ?? _useTicket,
        soldOut: soldOut ?? _soldOut,
        allDay: allDay ?? _allDay,
      );

  num? get id => _id;

  num? get eventId => _eventId;

  num? get userId => _userId;

  String? get ticketNumber => _ticketNumber;

  String? get name => _name;

  String? get type => _type;

  num? get quantity => _quantity;

  num? get ticketPerOrder => _ticketPerOrder;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  num? get price => _price;

  String? get description => _description;

  num? get status => _status;

  num? get isDeleted => _isDeleted;

  String? get eventName => _eventName;

  String? get organization => _organization;

  num? get useTicket => _useTicket;

  bool? get soldOut => _soldOut;

  num? get allDay => _allDay;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['event_id'] = _eventId;
    map['user_id'] = _userId;
    map['ticket_number'] = _ticketNumber;
    map['name'] = _name;
    map['type'] = _type;
    map['quantity'] = _quantity;
    map['ticket_per_order'] = _ticketPerOrder;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['price'] = _price;
    map['description'] = _description;
    map['status'] = _status;
    map['is_deleted'] = _isDeleted;
    map['event_name'] = _eventName;
    map['organization'] = _organization;
    map['use_ticket'] = _useTicket;
    map['sold_out'] = _soldOut;
    map['allday'] = _allDay;
    return map;
  }
}
