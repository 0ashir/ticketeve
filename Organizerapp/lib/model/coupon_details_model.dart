class CouponDetailsModel {
  CouponDetailsModel({
    bool? success,
    Data? data,
  }) {
    _success = success;
    _data = data;
  }

  CouponDetailsModel.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _success;
  Data? _data;

  CouponDetailsModel copyWith({
    bool? success,
    Data? data,
  }) =>
      CouponDetailsModel(
        success: success ?? _success,
        data: data ?? _data,
      );

  bool? get success => _success;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    num? id,
    num? userId,
    num? eventId,
    String? couponCode,
    String? name,
    num? discountType,
    num? discount,
    num? minimumAmount,
    num? maximumDiscount,
    String? description,
    String? startDate,
    String? endDate,
    num? maxUse,
    num? useCount,
    num? status,
    String? eventName,
  }) {
    _id = id;
    _userId = userId;
    _eventId = eventId;
    _couponCode = couponCode;
    _name = name;
    _discountType = discountType;
    _discount = discount;
    _minimumAmount = minimumAmount;
    _maximumDiscount = maximumDiscount;
    _description = description;
    _startDate = startDate;
    _endDate = endDate;
    _maxUse = maxUse;
    _useCount = useCount;
    _status = status;
    _eventName = eventName;
  }

  Data.fromJson(dynamic json) {
    _id = num.tryParse( json['id']);
    _userId = num.tryParse( json['user_id']);
    _eventId = num.tryParse( json['event_id']);
    _couponCode = json['coupon_code'];
    _name = json['name'];
    _discountType = num.tryParse( json['discount_type']);
    _discount = num.parse(json['discount'].toString());
    _minimumAmount =  num.tryParse(json['minimum_amount']);
    _maximumDiscount =  num.tryParse(json['maximum_discount']);
    _description = json['description'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _maxUse = num.tryParse( json['max_use']);
    _useCount = num.tryParse( json['use_count']);
    _status =  num.tryParse(json['status']);
    _eventName = json['event_name'];
  }

  num? _id;
  num? _userId;
  num? _eventId;
  String? _couponCode;
  String? _name;
  num? _discountType;
  num? _discount;
  num? _minimumAmount;
  num? _maximumDiscount;
  String? _description;
  String? _startDate;
  String? _endDate;
  num? _maxUse;
  num? _useCount;
  num? _status;
  String? _eventName;

  Data copyWith({
    num? id,
    num? userId,
    num? eventId,
    String? couponCode,
    String? name,
    num? discountType,
    num? discount,
    num? minimumAmount,
    num? maximumDiscount,
    String? description,
    String? startDate,
    String? endDate,
    num? maxUse,
    num? useCount,
    num? status,
    String? eventName,
  }) =>
      Data(
        id: id ?? _id,
        userId: userId ?? _userId,
        eventId: eventId ?? _eventId,
        couponCode: couponCode ?? _couponCode,
        name: name ?? _name,
        discountType: discountType ?? _discountType,
        discount: discount ?? _discount,
        minimumAmount: minimumAmount ?? _minimumAmount,
        maximumDiscount: maximumDiscount ?? _maximumDiscount,
        description: description ?? _description,
        startDate: startDate ?? _startDate,
        endDate: endDate ?? _endDate,
        maxUse: maxUse ?? _maxUse,
        useCount: useCount ?? _useCount,
        status: status ?? _status,
        eventName: eventName ?? _eventName,
      );

  num? get id => _id;

  num? get userId => _userId;

  num? get eventId => _eventId;

  String? get couponCode => _couponCode;

  String? get name => _name;

  num? get discountType => _discountType;

  num? get discount => _discount;

  num? get minimumAmount => _minimumAmount;

  num? get maximumDiscount => _maximumDiscount;

  String? get description => _description;

  String? get startDate => _startDate;

  String? get endDate => _endDate;

  num? get maxUse => _maxUse;

  num? get useCount => _useCount;

  num? get status => _status;

  String? get eventName => _eventName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['event_id'] = _eventId;
    map['coupon_code'] = _couponCode;
    map['name'] = _name;
    map['discount_type'] = _discountType;
    map['discount'] = _discount;
    map['minimum_amount'] = _minimumAmount;
    map['maximum_discount'] = _maximumDiscount;
    map['description'] = _description;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['max_use'] = _maxUse;
    map['use_count'] = _useCount;
    map['status'] = _status;
    map['event_name'] = _eventName;
    return map;
  }
}
