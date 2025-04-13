
class AllEventsModel {
  AllEventsModel({
    dynamic msg,
    Data? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  AllEventsModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  dynamic _msg;
  Data? _data;
  bool? _success;

  AllEventsModel copyWith({
    dynamic msg,
    Data? data,
    bool? success,
  }) =>
      AllEventsModel(
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
  Data({List<Events>? events}) {
    _events = events;
  }

  Data.fromJson(dynamic json) {
    if (json['events'] != null) {
      _events = [];
      json['events'].forEach((v) {
        _events?.add(Events.fromJson(v));
      });
    }
  }

  List<Events>? _events;

  Data copyWith({
    List<Events>? events,
  }) =>
      Data(
        events: events ?? _events,
      );

  List<Events>? get events => _events;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_events != null) {
      map['events'] = _events?.map((v) => v.toJson()).toList();
    }

    return map;
  }
}

class Ticket {
  Ticket({
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
    String? createdAt,
    String? updatedAt,
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
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  
  Ticket.fromJson(dynamic json) {
    _id = _parseNum(json['id']);
    _eventId = _parseNum(json['event_id']);
    _userId = _parseNum(json['user_id']);
    _ticketNumber = json['ticket_number'];
    _name = json['name'];
    _type = json['type'];
    _quantity = _parseNum(json['quantity']);
    _ticketPerOrder = _parseNum(json['ticket_per_order']);
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _price = _parseNum(json['price']);
    _description = json['description'];
    _status = _parseNum(json['status']);
    _isDeleted = _parseNum(json['is_deleted']);
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  /// Utility function to safely parse numerical values
  num? _parseNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
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
  String? _createdAt;
  String? _updatedAt;

  Ticket copyWith({
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
    String? createdAt,
    String? updatedAt,
  }) =>
      Ticket(
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
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
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

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

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
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Events {
  Events({
    this.id,
    this.name,
    this.type,
    this.userId,
    this.scannerId,
    this.address,
    this.categoryId,
    this.startTime,
    this.endTime,
    this.image,
    this.gallery,
    this.people,
    this.lat,
    this.lang,
    this.description,
    this.security,
    this.tags,
    this.status,
    this.eventStatus,
    this.isDeleted,
    this.time,
    this.isLike,
    this.imagePath,
    this.rate,
    this.totalTickets,
    this.soldTickets,
    this.ticket,
    this.shareUrl,
  });

  Events.fromJson(dynamic json) {

  id = _parseNum(json['id']);
  name = json['name'];
  type = json['type'];
  userId = _parseNum(json['user_id']);
  scannerId = json['scanner_id']?.toString();
  address = json['address'];
  categoryId = _parseNum(json['category_id']);
  startTime = json['start_time'];
  endTime = json['end_time'];
  image = json['image'];
  gallery = json['gallery'];
  people = _parseNum(json['people']);
  lat = _parseNum(json['lat']);
  lang = _parseNum(json['lang']);
  description = json['description'];
  security = _parseNum(json['security']);
  tags = json['tags'];
  status = _parseNum(json['status']);
  eventStatus = json['event_status'];
  isDeleted = _parseNum(json['is_deleted']);
  time = json['time'];
  isLike = json['isLike'];
  imagePath = json['imagePath'];
  rate = _parseNum(json['rate']);
  totalTickets = _parseNum(json['totalTickets']);
  soldTickets = _parseNum(json['soldTickets']);
  shareUrl = json['share_url'];

  if (json['ticket'] != null) {
    ticket = [];
    json['ticket'].forEach((v) {
      ticket?.add(Ticket.fromJson(v));
    });
  }
}

/// Utility function to safely parse numerical values
num? _parseNum(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  if (value is String) return num.tryParse(value);
  return null;
}

  num? id;
  String? name;
  String? type;
  num? userId;
  String? scannerId;
  dynamic address;
  num? categoryId;
  String? startTime;
  String? endTime;
  String? image;
  String? gallery;
  num? people;
  dynamic lat;
  dynamic lang;
  String? description;
  num? security;
  String? tags;
  num? status;
  String? eventStatus;
  num? isDeleted;
  String? time;
  bool? isLike;
  String? imagePath;
  num? rate;
  dynamic totalTickets;
  dynamic soldTickets;
  List<Ticket>? ticket;
  String? shareUrl;

  // Setter for isLike
  set setIsLike(bool value) {
    isLike = value;
  }

  Events copyWith({
    num? id,
    String? name,
    String? type,
    num? userId,
    String? scannerId,
    dynamic address,
    num? categoryId,
    String? startTime,
    String? endTime,
    String? image,
    String? gallery,
    num? people,
    dynamic lat,
    dynamic lang,
    String? description,
    num? security,
    String? tags,
    num? status,
    String? eventStatus,
    num? isDeleted,
    String? time,
    bool? isLike,
    String? imagePath,
    num? rate,
    dynamic totalTickets,
    dynamic soldTickets,
    List<Ticket>? ticket,
    String? shareUrl,
  }) =>
      Events(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        userId: userId ?? this.userId,
        scannerId: scannerId ?? this.scannerId,
        address: address ?? this.address,
        categoryId: categoryId ?? this.categoryId,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        image: image ?? this.image,
        gallery: gallery ?? this.gallery,
        people: people ?? this.people,
        lat: lat ?? this.lat,
        lang: lang ?? this.lang,
        description: description ?? this.description,
        security: security ?? this.security,
        tags: tags ?? this.tags,
        status: status ?? this.status,
        eventStatus: eventStatus ?? this.eventStatus,
        isDeleted: isDeleted ?? this.isDeleted,
        time: time ?? this.time,
        isLike: isLike ?? this.isLike,
        imagePath: imagePath ?? this.imagePath,
        rate: rate ?? this.rate,
        totalTickets: totalTickets ?? this.totalTickets,
        soldTickets: soldTickets ?? this.soldTickets,
        ticket: ticket ?? this.ticket,
        shareUrl: shareUrl ?? this.shareUrl,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['user_id'] = userId;
    map['scanner_id'] = scannerId;
    map['address'] = address;
    map['category_id'] = categoryId;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['image'] = image;
    map['gallery'] = gallery;
    map['people'] = people;
    map['lat'] = lat;
    map['lang'] = lang;
    map['description'] = description;
    map['security'] = security;
    map['tags'] = tags;
    map['status'] = status;
    map['event_status'] = eventStatus;
    map['is_deleted'] = isDeleted;
    map['time'] = time;
    map['isLike'] = isLike;
    map['imagePath'] = imagePath;
    map['rate'] = rate;
    map['totalTickets'] = totalTickets;
    map['soldTickets'] = soldTickets;
    map['share_url'] = shareUrl;

    if (ticket != null) {
      map['ticket'] = ticket?.map((v) => v.toJson()).toList();
    }

    return map;
  }
}
