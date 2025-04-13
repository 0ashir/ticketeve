class AddFeedBackModel {
  AddFeedBackModel({
    Data? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  AddFeedBackModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  Data? _data;
  bool? _success;

  AddFeedBackModel copyWith({
    Data? data,
    bool? success,
  }) =>
      AddFeedBackModel(
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
    String? email,
    String? message,
    String? rate,
    num? userId,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) {
    _email = email;
    _message = message;
    _rate = rate;
    _userId = userId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  Data.fromJson(dynamic json) {
    _email = json['email'];
    _message = json['message'];
    _rate = json['rate'];
    _userId =num.tryParse( json['user_id']);
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = num.tryParse(json['id']);
  }

  String? _email;
  String? _message;
  String? _rate;
  num? _userId;
  String? _updatedAt;
  String? _createdAt;
  num? _id;

  Data copyWith({
    String? email,
    String? message,
    String? rate,
    num? userId,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) =>
      Data(
        email: email ?? _email,
        message: message ?? _message,
        rate: rate ?? _rate,
        userId: userId ?? _userId,
        updatedAt: updatedAt ?? _updatedAt,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
      );

  String? get email => _email;

  String? get message => _message;

  String? get rate => _rate;

  num? get userId => _userId;

  String? get updatedAt => _updatedAt;

  String? get createdAt => _createdAt;

  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['message'] = _message;
    map['rate'] = _rate;
    map['user_id'] = _userId;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}
