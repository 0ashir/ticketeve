class AddTicketModel {
  AddTicketModel({
    Data? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  AddTicketModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  Data? _data;
  bool? _success;

  AddTicketModel copyWith({
    Data? data,
    bool? success,
  }) =>
      AddTicketModel(
        data: data ?? _data,
        success: success ?? _success,
      );

  Data? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    return map;
  }
}

class Data {
  Data({
    String? name,
    String? eventId,
    String? quantity,
    String? startTime,
    String? endTime,
    String? type,
    String? ticketPerOrder,
    String? description,
    String? price,
    String? status,
    String? ticketNumber,
    num? userId,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) {
    _name = name;
    _eventId = eventId;
    _quantity = quantity;
    _startTime = startTime;
    _endTime = endTime;
    _type = type;
    _ticketPerOrder = ticketPerOrder;
    _description = description;
    _price = price;
    _status = status;
    _ticketNumber = ticketNumber;
    _userId = userId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _eventId = json['event_id'];
    _quantity = json['quantity'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _type = json['type'];
    _ticketPerOrder = json['ticket_per_order'];
    _description = json['description'];
    _price = json['price'];
    _status = json['status'];
    _ticketNumber = json['ticket_number'];
    _userId =num.tryParse( json['user_id']);
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id =num.tryParse( json['id']);
  }

  String? _name;
  String? _eventId;
  String? _quantity;
  String? _startTime;
  String? _endTime;
  String? _type;
  String? _ticketPerOrder;
  String? _description;
  String? _price;
  String? _status;
  String? _ticketNumber;
  num? _userId;
  String? _updatedAt;
  String? _createdAt;
  num? _id;

  Data copyWith({
    String? name,
    String? eventId,
    String? quantity,
    String? startTime,
    String? endTime,
    String? type,
    String? ticketPerOrder,
    String? description,
    String? price,
    String? status,
    String? ticketNumber,
    num? userId,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) =>
      Data(
        name: name ?? _name,
        eventId: eventId ?? _eventId,
        quantity: quantity ?? _quantity,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        type: type ?? _type,
        ticketPerOrder: ticketPerOrder ?? _ticketPerOrder,
        description: description ?? _description,
        price: price ?? _price,
        status: status ?? _status,
        ticketNumber: ticketNumber ?? _ticketNumber,
        userId: userId ?? _userId,
        updatedAt: updatedAt ?? _updatedAt,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
      );

  String? get name => _name;

  String? get eventId => _eventId;

  String? get quantity => _quantity;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  String? get type => _type;

  String? get ticketPerOrder => _ticketPerOrder;

  String? get description => _description;

  String? get price => _price;

  String? get status => _status;

  String? get ticketNumber => _ticketNumber;

  num? get userId => _userId;

  String? get updatedAt => _updatedAt;

  String? get createdAt => _createdAt;

  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['event_id'] = _eventId;
    map['quantity'] = _quantity;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['type'] = _type;
    map['ticket_per_order'] = _ticketPerOrder;
    map['description'] = _description;
    map['price'] = _price;
    map['status'] = _status;
    map['ticket_number'] = _ticketNumber;
    map['user_id'] = _userId;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}
