class ReportEventModel {
  ReportEventModel({
    dynamic msg,
    Data? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  ReportEventModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  dynamic _msg;
  Data? _data;
  bool? _success;

  ReportEventModel copyWith({
    dynamic msg,
    Data? data,
    bool? success,
  }) =>
      ReportEventModel(
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
    String? eventId,
    String? email,
    String? reason,
    String? message,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) {
    _eventId = eventId;
    _email = email;
    _reason = reason;
    _message = message;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  Data.fromJson(dynamic json) {
    _eventId = json['event_id'];
    _email = json['email'];
    _reason = json['reason'];
    _message = json['message'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }

  String? _eventId;
  String? _email;
  String? _reason;
  String? _message;
  String? _updatedAt;
  String? _createdAt;
  num? _id;

  Data copyWith({
    String? eventId,
    String? email,
    String? reason,
    String? message,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) =>
      Data(
        eventId: eventId ?? _eventId,
        email: email ?? _email,
        reason: reason ?? _reason,
        message: message ?? _message,
        updatedAt: updatedAt ?? _updatedAt,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
      );

  String? get eventId => _eventId;

  String? get email => _email;

  String? get reason => _reason;

  String? get message => _message;

  String? get updatedAt => _updatedAt;

  String? get createdAt => _createdAt;

  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_id'] = _eventId;
    map['email'] = _email;
    map['reason'] = _reason;
    map['message'] = _message;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}
