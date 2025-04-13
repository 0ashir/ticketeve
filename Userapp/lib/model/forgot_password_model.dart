class ForgotPasswordModel {
  ForgotPasswordModel({
    bool? success,
    String? msg,
    dynamic data,
  }) {
    _success = success;
    _msg = msg;
    _data = data;
  }

  ForgotPasswordModel.fromJson(dynamic json) {
    _success = json['success'];
    _msg = json['msg'];
    _data = json['data'];
  }

  bool? _success;
  String? _msg;
  dynamic _data;

  ForgotPasswordModel copyWith({
    bool? success,
    String? msg,
    dynamic data,
  }) =>
      ForgotPasswordModel(
        success: success ?? _success,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  bool? get success => _success;

  String? get msg => _msg;

  dynamic get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['msg'] = _msg;
    map['data'] = _data;
    return map;
  }
}
