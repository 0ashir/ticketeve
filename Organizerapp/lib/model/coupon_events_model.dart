class CouponEventsModel {
  CouponEventsModel({
    bool? success,
    dynamic msg,
    List<CouponEventsData>? data,
  }) {
    _success = success;
    _msg = msg;
    _data = data;
  }

  CouponEventsModel.fromJson(dynamic json) {
    _success = json['success'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(
          CouponEventsData.fromJson(v),
        );
      });
    }
  }

  bool? _success;
  dynamic _msg;
  List<CouponEventsData>? _data;

  CouponEventsModel copyWith({
    bool? success,
    dynamic msg,
    List<CouponEventsData>? data,
  }) =>
      CouponEventsModel(
        success: success ?? _success,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  bool? get success => _success;

  dynamic get msg => _msg;

  List<CouponEventsData>? get data => _data;

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

class CouponEventsData {
  CouponEventsData({
    num? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  CouponEventsData.fromJson(dynamic json) {
    _id = num.tryParse( json['id']);
    _name = json['name'];
  }

  num? _id;
  String? _name;

  CouponEventsData copyWith({
    num? id,
    String? name,
  }) =>
      CouponEventsData(
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
