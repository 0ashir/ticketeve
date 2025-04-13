class DeleteTaxModel {
  DeleteTaxModel({
    String? msg,
    bool? success,
  }) {
    _msg = msg;
    _success = success;
  }

  DeleteTaxModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _success = json['success'];
  }

  String? _msg;
  bool? _success;

  DeleteTaxModel copyWith({
    String? msg,
    bool? success,
  }) =>
      DeleteTaxModel(
        msg: msg ?? _msg,
        success: success ?? _success,
      );

  String? get msg => _msg;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['success'] = _success;
    return map;
  }
}
