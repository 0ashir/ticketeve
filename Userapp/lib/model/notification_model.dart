class NotificationModel {
  NotificationModel({
    bool? success,
    dynamic msg,
    List<NotificationData>? data,
  }) {
    _success = success;
    _msg = msg;
    _data = data;
  }

  NotificationModel.fromJson(dynamic json) {
    _success = json['success'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(NotificationData.fromJson(v));
      });
    }
  }

  bool? _success;
  dynamic _msg;
  List<NotificationData>? _data;

  NotificationModel copyWith({
    bool? success,
    dynamic msg,
    List<NotificationData>? data,
  }) =>
      NotificationModel(
        success: success ?? _success,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  bool? get success => _success;

  dynamic get msg => _msg;

  List<NotificationData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class NotificationData {
  NotificationData({
    num? id,
    num? userId,
    dynamic organizerId,
    num? orderId,
    String? title,
    String? message,
    String? createdAt,
    String? updatedAt,
    String? eventImage,
    User? user,
    Event? event,
  }) {
    _id = id;
    _userId = userId;
    _organizerId = organizerId;
    _orderId = orderId;
    _title = title;
    _message = message;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _eventImage = eventImage;
    _user = user;
    _event = event;
  }

  NotificationData.fromJson(dynamic json) {
  _id = json['id'];
  _userId = json['user_id'];
  
  // Handling dynamic type for 'organizerId'
  _organizerId = json['organizer_id'];
  
  _orderId = json['order_id'];
  _title = json['title'];
  _message = json['message'];
  
  // Handling date fields to ensure they are in string format if needed
  _createdAt = _parseDate(json['created_at']);
  _updatedAt = _parseDate(json['updated_at']);
  
  _eventImage = json['event_image'];
  
  // Safely parsing 'user' and 'event' fields if they are present
  _user = json['user'] != null ? User.fromJson(json['user']) : null;
  _event = json['event'] != null ? Event.fromJson(json['event']) : null;
}

// Helper method to parse date values (converts non-string values to strings)
String? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is String) return value; // If it's already a string, return it
  return value.toString(); // Otherwise, convert it to a string
}


  num? _id;
  num? _userId;
  dynamic _organizerId;
  num? _orderId;
  String? _title;
  String? _message;
  String? _createdAt;
  String? _updatedAt;
  String? _eventImage;
  User? _user;
  Event? _event;

  NotificationData copyWith({
    num? id,
    num? userId,
    dynamic organizerId,
    num? orderId,
    String? title,
    String? message,
    String? createdAt,
    String? updatedAt,
    String? eventImage,
    User? user,
    Event? event,
  }) =>
      NotificationData(
        id: id ?? _id,
        userId: userId ?? _userId,
        organizerId: organizerId ?? _organizerId,
        orderId: orderId ?? _orderId,
        title: title ?? _title,
        message: message ?? _message,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        eventImage: eventImage ?? _eventImage,
        user: user ?? _user,
        event: event ?? _event,
      );

  num? get id => _id;

  num? get userId => _userId;

  dynamic get organizerId => _organizerId;

  num? get orderId => _orderId;

  String? get title => _title;

  String? get message => _message;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get eventImage => _eventImage;

  User? get user => _user;

  Event? get event => _event;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['organizer_id'] = _organizerId;
    map['order_id'] = _orderId;
    map['title'] = _title;
    map['message'] = _message;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['event_image'] = _eventImage;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_event != null) {
      map['event'] = _event?.toJson();
    }
    return map;
  }
}

class Event {
  Event({
    num? id,
    String? name,
    String? image,
    String? imagePath,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _imagePath = imagePath;
  }

  Event.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _imagePath = json['imagePath'];
  }

  num? _id;
  String? _name;
  String? _image;
  String? _imagePath;

  Event copyWith({
    num? id,
    String? name,
    String? image,
    String? imagePath,
  }) =>
      Event(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
        imagePath: imagePath ?? _imagePath,
      );

  num? get id => _id;

  String? get name => _name;

  String? get image => _image;

  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['imagePath'] = _imagePath;
    return map;
  }
}

class User {
  User({
    num? id,
    String? name,
    String? lastName,
    String? image,
    String? imagePath,
  }) {
    _id = id;
    _name = name;
    _lastName = lastName;
    _image = image;
    _imagePath = imagePath;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _lastName = json['last_name'];
    _image = json['image'];
    _imagePath = json['imagePath'];
  }

  num? _id;
  String? _name;
  String? _lastName;
  String? _image;
  String? _imagePath;

  User copyWith({
    num? id,
    String? name,
    String? lastName,
    String? image,
    String? imagePath,
  }) =>
      User(
        id: id ?? _id,
        name: name ?? _name,
        lastName: lastName ?? _lastName,
        image: image ?? _image,
        imagePath: imagePath ?? _imagePath,
      );

  num? get id => _id;

  String? get name => _name;

  String? get lastName => _lastName;

  String? get image => _image;

  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['last_name'] = _lastName;
    map['image'] = _image;
    map['imagePath'] = _imagePath;
    return map;
  }
}
