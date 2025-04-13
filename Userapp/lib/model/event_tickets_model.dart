class EventTicketsModel {
  EventTicketsModel({
    dynamic msg,
    Data? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  EventTicketsModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  dynamic _msg;
  Data? _data;
  bool? _success;

  EventTicketsModel copyWith({
    dynamic msg,
    Data? data,
    bool? success,
  }) =>
      EventTicketsModel(
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
  Data(
      {String? eventName,
      String? organization,
      List<Ticket>? ticket,
      Module? module}) {
    _eventName = eventName;
    _organization = organization;
    _ticket = ticket;
    _module = module;
  }

  Data.fromJson(dynamic json) {
    _eventName = json['event_name'];
    _organization = json['organization'];
    if (json['ticket'] != null) {
      _ticket = [];
      json['ticket'].forEach((v) {
        _ticket?.add(Ticket.fromJson(v));
      });
    }
    _module = json['module'] != null ? Module.fromJson(json['module']) : null;
  }

  String? _eventName;
  String? _organization;
  List<Ticket>? _ticket;
  Module? _module;

  Data copyWith({
    String? eventName,
    String? organization,
    List<Ticket>? ticket,
    Module? module,
  }) =>
      Data(
        eventName: eventName ?? _eventName,
        organization: organization ?? _organization,
        ticket: ticket ?? _ticket,
        module: module ?? _module,
      );

  String? get eventName => _eventName;

  String? get organization => _organization;

  List<Ticket>? get ticket => _ticket;

  Module? get module => _module;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_name'] = _eventName;
    map['organization'] = _organization;
    if (_ticket != null) {
      map['ticket'] = _ticket?.map((v) => v.toJson()).toList();
    }
    if (_module != null) {
      map['module'] = _module!.toJson();
    }
    return map;
  }
}

class Ticket {
  Ticket({
    num? id,
    num? eventId,
    num? userId,
    num? seatMapId,
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
    String? createdAt,
    String? updatedAt,
    dynamic useTicket,
    bool? soldOut,
  }) {
    _id = id;
    _eventId = eventId;
    _userId = userId;
    _seatMapId = seatMapId;
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
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _useTicket = useTicket;
    _soldOut = soldOut;
  }

  Ticket.fromJson(Map<String, dynamic> json) {
    _id = json['id'] is num ? json['id'] : num.tryParse(json['id'].toString());
    _eventId = json['event_id'] is num
        ? json['event_id']
        : num.tryParse(json['event_id'].toString());
    _userId = json['user_id'] is num
        ? json['user_id']
        : num.tryParse(json['user_id'].toString());
    _seatMapId = json['seatmap_id'] is num
        ? json['seatmap_id']
        : num.tryParse(json['seatmap_id'].toString());
    _ticketNumber = json['ticket_number'] as String?;
    _name = json['name'] as String?;
    _type = json['type'] as String?;
    _quantity = json['quantity'] is num
        ? json['quantity']
        : num.tryParse(json['quantity'].toString());
    _ticketPerOrder = json['ticket_per_order'] is num
        ? json['ticket_per_order']
        : num.tryParse(json['ticket_per_order'].toString());
    _startTime = json['start_time'] as String?;
    _endTime = json['end_time'] as String?;
    _price = json['price'] is num
        ? json['price']
        : num.tryParse(json['price'].toString());
    _description = json['description'] as String?;
    _status = json['status'] is num
        ? json['status']
        : num.tryParse(json['status'].toString());
    _isDeleted = json['is_deleted'] is num
        ? json['is_deleted']
        : num.tryParse(json['is_deleted'].toString());
    _createdAt = json['created_at'] as String?;
    _updatedAt = json['updated_at'] as String?;
    _useTicket = json[
        'use_ticket']; // Could be of any type depending on your backend structure
    _soldOut = json['sold_out'] is bool
        ? json['sold_out']
        : (json['sold_out']?.toString().toLowerCase() == 'true');
  }

  num? _id;
  num? _eventId;
  num? _userId;
  num? _seatMapId;
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
  String? _createdAt;
  String? _updatedAt;
  dynamic _useTicket;
  bool? _soldOut;

  Ticket copyWith({
    num? id,
    num? eventId,
    num? userId,
    num? seatMapId,
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
    String? createdAt,
    String? updatedAt,
    dynamic useTicket,
    bool? soldOut,
  }) =>
      Ticket(
        id: id ?? _id,
        eventId: eventId ?? _eventId,
        userId: userId ?? _userId,
        seatMapId: seatMapId ?? _seatMapId,
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
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        useTicket: useTicket ?? _useTicket,
        soldOut: soldOut ?? _soldOut,
      );

  num? get id => _id;

  num? get eventId => _eventId;

  num? get userId => _userId;

  num? get seatMapId => _seatMapId;

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

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  dynamic get useTicket => _useTicket;

  bool? get soldOut => _soldOut;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['event_id'] = _eventId;
    map['user_id'] = _userId;
    map['seatmap_id'] = _seatMapId;
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
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['use_ticket'] = _useTicket;
    map['sold_out'] = _soldOut;
    return map;
  }
}

class Module {
  int? _id;
  String? _module;
  int? _isEnable;
  int? _isInstall;
  String? _updatedAt;
  String? _createdAt;

  Module(
      {int? id,
      String? module,
      int? isEnable,
      int? isInstall,
      String? updatedAt,
      String? createdAt}) {
    if (id != null) {
      _id = id;
    }
    if (module != null) {
      _module = module;
    }
    if (isEnable != null) {
      _isEnable = isEnable;
    }
    if (isInstall != null) {
      _isInstall = isInstall;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
  }

  int? get id => _id;

  String? get module => _module;

  int? get isEnable => _isEnable;

  int? get isInstall => _isInstall;

  String? get updatedAt => _updatedAt;

  String? get createdAt => _createdAt;

  Module.fromJson(Map<String, dynamic> json) {
    _id = int.parse(json['id'].toString());
    _module = json['module'];
    _isEnable = int.parse(json['is_enable'].toString());
    _isInstall = int.parse(json['is_install'].toString());
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['module'] = _module;
    data['is_enable'] = _isEnable;
    data['is_install'] = _isInstall;
    data['updated_at'] = _updatedAt;
    data['created_at'] = _createdAt;
    return data;
  }
}
