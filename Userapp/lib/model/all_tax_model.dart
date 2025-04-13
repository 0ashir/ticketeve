class AllTaxModel {
  AllTaxModel({
    bool? success,
    dynamic msg,
    List<TaxData>? data,
  }) {
    _success = success;
    _msg = msg;
    _data = data;
  }

  AllTaxModel.fromJson(dynamic json) {
    _success = json['success'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TaxData.fromJson(v));
      });
    }
  }

  bool? _success;
  dynamic _msg;
  List<TaxData>? _data;

  AllTaxModel copyWith({
    bool? success,
    dynamic msg,
    List<TaxData>? data,
  }) =>
      AllTaxModel(
        success: success ?? _success,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  bool? get success => _success;

  dynamic get msg => _msg;

  List<TaxData>? get data => _data;

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

class TaxData {
  TaxData({
    num? id,
    num? userId,
    String? name,
    num? price,
    num? allowAllBill,
    num? status,
  }) {
    _id = id;
    _userId = userId;
    _name = name;
    _price = price;
    _allowAllBill = allowAllBill;
    _status = status;
  }
TaxData.fromJson(dynamic json) {
    _id = (json['id'] is num) ? json['id'] : num.tryParse(json['id'].toString());
    _userId = (json['user_id'] is num) ? json['user_id'] : num.tryParse(json['user_id'].toString());
    _name = json['name'] as String?;
    _price = (json['price'] is num) ? json['price'] : num.tryParse(json['price'].toString());
    _allowAllBill = (json['allow_all_bill'] is num) ? json['allow_all_bill'] : num.tryParse(json['allow_all_bill'].toString());
    _status = (json['status'] is num) ? json['status'] : num.tryParse(json['status'].toString());
  }

  num? _id;
  num? _userId;
  String? _name;
  num? _price;
  num? _allowAllBill;
  num? _status;

  TaxData copyWith({
    num? id,
    num? userId,
    String? name,
    num? price,
    num? allowAllBill,
    num? status,
  }) =>
      TaxData(
        id: id ?? _id,
        userId: userId ?? _userId,
        name: name ?? _name,
        price: price ?? _price,
        allowAllBill: allowAllBill ?? _allowAllBill,
        status: status ?? _status,
      );

  num? get id => _id;

  num? get userId => _userId;

  String? get name => _name;

  num? get price => _price;

  num? get allowAllBill => _allowAllBill;

  num? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['price'] = _price;
    map['allow_all_bill'] = _allowAllBill;
    map['status'] = _status;
    return map;
  }
}
