class TicketsModel {
  TicketsModel({
    List<TicketData>? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  TicketsModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(
          TicketData.fromJson(v),
        );
      });
    }
    _success = json['success'];
  }

  List<TicketData>? _data;
  bool? _success;

  TicketsModel copyWith({
    List<TicketData>? data,
    bool? success,
  }) =>
      TicketsModel(
        data: data ?? _data,
        success: success ?? _success,
      );

  List<TicketData>? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data
          ?.map(
            (v) => v.toJson(),
          )
          .toList();
    }
    map['success'] = _success;
    return map;
  }
}

class TicketData {
  TicketData({
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
    int? maximumCheckIns,
    String? description,
    num? status,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
    dynamic useTicket,
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
    _maximumCheckIns = maximumCheckIns;
    _description = description;
    _status = status;
    _isDeleted = isDeleted;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _useTicket = useTicket;
  }

  TicketData.fromJson(dynamic json) {
    _id = num.tryParse(json['id']);
    _eventId =num.tryParse( json['event_id']);
    _userId =num.tryParse( json['user_id']);
    _ticketNumber = json['ticket_number'];
    _name = json['name'];
    _type = json['type'];
    _quantity = num.tryParse(json['quantity']);
    _ticketPerOrder = num.tryParse(json['ticket_per_order']);
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _price = num.parse(json['price'].toString());
    _maximumCheckIns =int.parse( json['maximum_check_ins']);
    _description = json['description'];
    _status = num.tryParse(json['status']);
    _isDeleted =num.tryParse( json['is_deleted']);
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _useTicket = json['use_ticket'];
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
  int? _maximumCheckIns;
  String? _description;
  num? _status;
  num? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  dynamic _useTicket;

  TicketData copyWith({
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
    int? maximumCheckIns,
    String? description,
    num? status,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
    dynamic useTicket,
  }) =>
      TicketData(
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
        maximumCheckIns: maximumCheckIns ?? _maximumCheckIns,
        description: description ?? _description,
        status: status ?? _status,
        isDeleted: isDeleted ?? _isDeleted,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        useTicket: useTicket ?? _useTicket,
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

  int? get maximumCheckIns => _maximumCheckIns;

  String get maximumCheckInsString {
    switch (_maximumCheckIns) {
      case 0:
        return 'Unlimited';
      case null:
        return 'Unlimited';
      default:
        return _maximumCheckIns.toString();
    }
  }

  String? get description => _description;

  num? get status => _status;

  num? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  dynamic get useTicket => _useTicket;

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
    map['maximum_check_ins'] = _maximumCheckIns;
    map['description'] = _description;
    map['status'] = _status;
    map['is_deleted'] = _isDeleted;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['use_ticket'] = _useTicket;
    return map;
  }
}
