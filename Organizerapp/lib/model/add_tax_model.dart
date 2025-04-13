class AddTaxModel {
  AddTaxModel({Data? data, bool? success, String? msg}) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  AddTaxModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  String? _msg;
  Data? _data;
  bool? _success;

  AddTaxModel copyWith({
    Data? data,
    bool? success,
  }) =>
      AddTaxModel(
        data: data ?? _data,
        success: success ?? _success,
      );

  String? get msg => _msg;

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
    String? name,
    String? price,
    String? allowAllBill,
    num? userId,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) {
    _name = name;
    _price = price;
    _allowAllBill = allowAllBill;
    _userId = userId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _price = json['price'];
    _allowAllBill = json['allow_all_bill'];
    _userId =num.tryParse( json['user_id']);
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id =num.tryParse( json['id']);
  }

  String? _name;
  String? _price;
  String? _allowAllBill;
  num? _userId;
  String? _updatedAt;
  String? _createdAt;
  num? _id;

  Data copyWith({
    String? name,
    String? price,
    String? allowAllBill,
    num? userId,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) =>
      Data(
        name: name ?? _name,
        price: price ?? _price,
        allowAllBill: allowAllBill ?? _allowAllBill,
        userId: userId ?? _userId,
        updatedAt: updatedAt ?? _updatedAt,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
      );

  String? get name => _name;

  String? get price => _price;

  String? get allowAllBill => _allowAllBill;

  num? get userId => _userId;

  String? get updatedAt => _updatedAt;

  String? get createdAt => _createdAt;

  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['price'] = _price;
    map['allow_all_bill'] = _allowAllBill;
    map['user_id'] = _userId;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}
