class AddReviewModel {
  AddReviewModel({
    bool? success,
    dynamic msg,
    Data? data,
  }) {
    _success = success;
    _msg = msg;
    _data = data;
  }

  AddReviewModel.fromJson(dynamic json) {
    _success = json['success'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _success;
  dynamic _msg;
  Data? _data;

  AddReviewModel copyWith({
    bool? success,
    dynamic msg,
    Data? data,
  }) =>
      AddReviewModel(
        success: success ?? _success,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  bool? get success => _success;

  dynamic get msg => _msg;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    String? eventId,
    String? orderId,
    String? message,
    String? rate,
    num? userId,
    num? organizationId,
    num? status,
    String? updatedAt,
    String? createdAt,
    num? id,
    User? user,
    Event? event,
  }) {
    _eventId = eventId;
    _orderId = orderId;
    _message = message;
    _rate = rate;
    _userId = userId;
    _organizationId = organizationId;
    _status = status;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
    _user = user;
    _event = event;
  }

 Data.fromJson(dynamic json) {
      _eventId = json['event_id'].toString();
      _orderId = json['order_id'].toString();
      _message = json['message'] .toString();
      _rate = json['rate'].toString();
      _userId = (json['user_id'] is num) ? json['user_id'] : num.tryParse(json['user_id'].toString());
      _organizationId = (json['organization_id'] is num) ? json['organization_id'] : num.tryParse(json['organization_id'].toString());
      _status = (json['status'] is num) ? json['status'] : num.tryParse(json['status'].toString());
      _id = num.tryParse(json['id'].toString());
      _updatedAt = json['updated_at'] ;
      _createdAt = json['created_at'] ;
      _user = json['user'] != null ? User.fromJson(json['user']) : null;
      _event = json['event'] != null ? Event.fromJson(json['event']) : null;
    
  }String? _eventId;
  String? _orderId;
  String? _message;
  String? _rate;
  num? _userId;
  num? _organizationId;
  num? _status;
  String? _updatedAt;
  String? _createdAt;
  num? _id;
  User? _user;
  Event? _event;

  Data copyWith({
    String? eventId,
    String? orderId,
    String? message,
    String? rate,
    num? userId,
    num? organizationId,
    num? status,
    String? updatedAt,
    String? createdAt,
    num? id,
    User? user,
    Event? event,
  }) =>
      Data(
        eventId: eventId ?? _eventId,
        orderId: orderId ?? _orderId,
        message: message ?? _message,
        rate: rate ?? _rate,
        userId: userId ?? _userId,
        organizationId: organizationId ?? _organizationId,
        status: status ?? _status,
        updatedAt: updatedAt ?? _updatedAt,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
        user: user ?? _user,
        event: event ?? _event,
      );

  String? get eventId => _eventId;

  String? get orderId => _orderId;

  String? get message => _message;

  String? get rate => _rate;

  num? get userId => _userId;

  num? get organizationId => _organizationId;

  num? get status => _status;

  String? get updatedAt => _updatedAt;

  String? get createdAt => _createdAt;

  num? get id => _id;

  User? get user => _user;

  Event? get event => _event;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_id'] = _eventId;
    map['order_id'] = _orderId;
    map['message'] = _message;
    map['rate'] = _rate;
    map['user_id'] = _userId;
    map['organization_id'] = _organizationId;
    map['status'] = _status;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_event != null) {
      map['event'] = _event?.toJson();
    }
    return map;
  }
}

/// id : 12
/// name : "abcd"

class Event {
  Event({
    num? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Event.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }

  num? _id;
  String? _name;

  Event copyWith({
    num? id,
    String? name,
  }) =>
      Event(
        id: id ?? _id,
        name: name ?? _name,
      );

  num? get id => _id;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

class User {
  User({
    num? id,
    String? name,
    String? lastName,
    String? image,
    String? email,
  }) {
    _id = id;
    _name = name;
    _lastName = lastName;
    _image = image;
    _email = email;
  }

  User.fromJson(dynamic json) {
    _id = num.tryParse(json['id'].toString());
    _name = json['name'];
    _lastName = json['last_name'];
    _image = json['image'];
    _email = json['email'];
  }

  num? _id;
  String? _name;
  String? _lastName;
  String? _image;
  String? _email;

  User copyWith({
    num? id,
    String? name,
    String? lastName,
    String? image,
    String? email,
  }) =>
      User(
        id: id ?? _id,
        name: name ?? _name,
        lastName: lastName ?? _lastName,
        image: image ?? _image,
        email: email ?? _email,
      );

  num? get id => _id;

  String? get name => _name;

  String? get lastName => _lastName;

  String? get image => _image;

  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['last_name'] = _lastName;
    map['image'] = _image;
    map['email'] = _email;
    return map;
  }
}
