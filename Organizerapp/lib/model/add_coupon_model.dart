class AddCouponModel {
  AddCouponModel({
    bool? success,
    dynamic msg,
    Data? data,
  }) {
    _success = success;
    _msg = msg;
    _data = data;
  }

  AddCouponModel.fromJson(dynamic json) {
    _success = json['success'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _success;
  dynamic _msg;
  Data? _data;

  AddCouponModel copyWith({
    bool? success,
    dynamic msg,
    Data? data,
  }) =>
      AddCouponModel(
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
    String? name,
    String? eventId,
    String? discount,
    String? startDate,
    String? endDate,
    String? maxUse,
    String? description,
    num? userId,
    num? status,
    String? couponCode,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) {
    _name = name;
    _eventId = eventId;
    _discount = discount;
    _startDate = startDate;
    _endDate = endDate;
    _maxUse = maxUse;
    _description = description;
    _userId = userId;
    _status = status;
    _couponCode = couponCode;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _eventId = json['event_id'];
    _discount = json['discount'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _maxUse = json['max_use'];
    _description = json['description'];
    _userId = num.tryParse(json['user_id']);
    _status = num.tryParse(json['status']);
    _couponCode = json['coupon_code'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = num.tryParse(json['id']);
  }

  String? _name;
  String? _eventId;
  String? _discount;
  String? _startDate;
  String? _endDate;
  String? _maxUse;
  String? _description;
  num? _userId;
  num? _status;
  String? _couponCode;
  String? _updatedAt;
  String? _createdAt;
  num? _id;

  Data copyWith({
    String? name,
    String? eventId,
    String? discount,
    String? startDate,
    String? endDate,
    String? maxUse,
    String? description,
    num? userId,
    num? status,
    String? couponCode,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) =>
      Data(
        name: name ?? _name,
        eventId: eventId ?? _eventId,
        discount: discount ?? _discount,
        startDate: startDate ?? _startDate,
        endDate: endDate ?? _endDate,
        maxUse: maxUse ?? _maxUse,
        description: description ?? _description,
        userId: userId ?? _userId,
        status: status ?? _status,
        couponCode: couponCode ?? _couponCode,
        updatedAt: updatedAt ?? _updatedAt,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
      );

  String? get name => _name;

  String? get eventId => _eventId;

  String? get discount => _discount;

  String? get startDate => _startDate;

  String? get endDate => _endDate;

  String? get maxUse => _maxUse;

  String? get description => _description;

  num? get userId => _userId;

  num? get status => _status;

  String? get couponCode => _couponCode;

  String? get updatedAt => _updatedAt;

  String? get createdAt => _createdAt;

  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['event_id'] = _eventId;
    map['discount'] = _discount;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['max_use'] = _maxUse;
    map['description'] = _description;
    map['user_id'] = _userId;
    map['status'] = _status;
    map['coupon_code'] = _couponCode;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}
