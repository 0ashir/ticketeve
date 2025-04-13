class CouponsModel {
  CouponsModel({
    bool? success,
    dynamic msg,
    List<CouponData>? data,
  }) {
    _success = success;
    _msg = msg;
    _data = data;
  }

  CouponsModel.fromJson(dynamic json) {
    _success = json['success'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(
          CouponData.fromJson(v),
        );
      });
    }
  }

  bool? _success;
  dynamic _msg;
  List<CouponData>? _data;

  CouponsModel copyWith({
    bool? success,
    dynamic msg,
    List<CouponData>? data,
  }) =>
      CouponsModel(
        success: success ?? _success,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  bool? get success => _success;

  dynamic get msg => _msg;

  List<CouponData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data
          ?.map(
            (v) => v.toJson(),
          )
          .toList();
    }
    return map;
  }
}

class CouponData {
  CouponData({
    num? id,
    num? userId,
    num? eventId,
    String? couponCode,
    String? name,
    num? discount,
    String? description,
    String? startDate,
    String? endDate,
    num? maxUse,
    num? useCount,
    num? status,
    Event? event,
  }) {
    _id = id;
    _userId = userId;
    _eventId = eventId;
    _couponCode = couponCode;
    _name = name;
    _discount = discount;
    _description = description;
    _startDate = startDate;
    _endDate = endDate;
    _maxUse = maxUse;
    _useCount = useCount;
    _status = status;
    _event = event;
  }

  CouponData.fromJson(dynamic json) {
    _id =  num.tryParse(json['id']);
    _userId = num.tryParse( json['user_id']);
    _eventId = num.tryParse( json['event_id']);
    _couponCode = json['coupon_code'];
    _name = json['name'];
    _discount = num.parse(json['discount'].toString());
    _description = json['description'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _maxUse =  num.tryParse(json['max_use']);
    _useCount =  num.tryParse(json['use_count']);
    _status = num.tryParse( json['status']);
    _event = json['event'] != null ? Event.fromJson(json['event']) : null;
  }

  num? _id;
  num? _userId;
  num? _eventId;
  String? _couponCode;
  String? _name;
  num? _discount;
  String? _description;
  String? _startDate;
  String? _endDate;
  num? _maxUse;
  num? _useCount;
  num? _status;
  Event? _event;

  CouponData copyWith({
    num? id,
    num? userId,
    num? eventId,
    String? couponCode,
    String? name,
    num? discount,
    String? description,
    String? startDate,
    String? endDate,
    num? maxUse,
    num? useCount,
    num? status,
    Event? event,
  }) =>
      CouponData(
        id: id ?? _id,
        userId: userId ?? _userId,
        eventId: eventId ?? _eventId,
        couponCode: couponCode ?? _couponCode,
        name: name ?? _name,
        discount: discount ?? _discount,
        description: description ?? _description,
        startDate: startDate ?? _startDate,
        endDate: endDate ?? _endDate,
        maxUse: maxUse ?? _maxUse,
        useCount: useCount ?? _useCount,
        status: status ?? _status,
        event: event ?? _event,
      );

  num? get id => _id;

  num? get userId => _userId;

  num? get eventId => _eventId;

  String? get couponCode => _couponCode;

  String? get name => _name;

  num? get discount => _discount;

  String? get description => _description;

  String? get startDate => _startDate;

  String? get endDate => _endDate;

  num? get maxUse => _maxUse;

  num? get useCount => _useCount;

  num? get status => _status;

  Event? get event => _event;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['event_id'] = _eventId;
    map['coupon_code'] = _couponCode;
    map['name'] = _name;
    map['discount'] = _discount;
    map['description'] = _description;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['max_use'] = _maxUse;
    map['use_count'] = _useCount;
    map['status'] = _status;
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
    num? rate,
    dynamic totalTickets,
    dynamic soldTickets,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _imagePath = imagePath;
    _rate = rate;
    _totalTickets = totalTickets;
    _soldTickets = soldTickets;
  }

  Event.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _imagePath = json['imagePath'];
    _rate = json['rate'];
    _totalTickets = json['totalTickets'];
    _soldTickets = json['soldTickets'];
  }

  num? _id;
  String? _name;
  String? _image;
  String? _imagePath;
  num? _rate;
  dynamic _totalTickets;
  dynamic _soldTickets;

  Event copyWith({
    num? id,
    String? name,
    String? image,
    String? imagePath,
    num? rate,
    dynamic totalTickets,
    dynamic soldTickets,
  }) =>
      Event(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
        imagePath: imagePath ?? _imagePath,
        rate: rate ?? _rate,
        totalTickets: totalTickets ?? _totalTickets,
        soldTickets: soldTickets ?? _soldTickets,
      );

  num? get id => _id;

  String? get name => _name;

  String? get image => _image;

  String? get imagePath => _imagePath;

  num? get rate => _rate;

  dynamic get totalTickets => _totalTickets;

  dynamic get soldTickets => _soldTickets;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['imagePath'] = _imagePath;
    map['rate'] = _rate;
    map['totalTickets'] = _totalTickets;
    map['soldTickets'] = _soldTickets;
    return map;
  }
}
