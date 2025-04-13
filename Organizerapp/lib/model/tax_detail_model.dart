class TaxDetailModel {
  TaxDetailModel({
    Data? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  TaxDetailModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  Data? _data;
  bool? _success;

  TaxDetailModel copyWith({
    Data? data,
    bool? success,
  }) =>
      TaxDetailModel(
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
    num? id,
    num? userId,
    String? name,
    num? price,
    String? amountType,
    num? allowAllBill,
    num? status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _name = name;
    _price = price;
    _amountType = amountType;
    _allowAllBill = allowAllBill;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id =num.tryParse( json['id']);
    _userId = num.tryParse(json['user_id']);
    _name = json['name'];
    _price = num.parse(json['price'].toString());
    _amountType = json['amount_type'];
    _allowAllBill =num.tryParse( json['allow_all_bill']);
    _status = num.tryParse(json['status']);
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _userId;
  String? _name;
  num? _price;
  String? _amountType;
  num? _allowAllBill;
  num? _status;
  String? _createdAt;
  String? _updatedAt;

  Data copyWith({
    num? id,
    num? userId,
    String? name,
    num? price,
    String? amountType,
    num? allowAllBill,
    num? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        userId: userId ?? _userId,
        name: name ?? _name,
        price: price ?? _price,
        amountType: amountType ?? _amountType,
        allowAllBill: allowAllBill ?? _allowAllBill,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get userId => _userId;

  String? get name => _name;

  num? get price => _price;

  String? get amountType => _amountType;

  num? get allowAllBill => _allowAllBill;

  num? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['price'] = _price;
    map['amount_type'] = _amountType;
    map['allow_all_bill'] = _allowAllBill;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
