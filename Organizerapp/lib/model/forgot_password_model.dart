class ForgotPasswordModel {
  ForgotPasswordModel({
    bool? success,
    String? msg,
  }) {
    _success = success;
    _msg = msg;
  }

  ForgotPasswordModel.fromJson(dynamic json) {
    _success = json['success'];
    _msg = json['msg'];
  }

  bool? _success;
  String? _msg;

  ForgotPasswordModel copyWith({
    bool? success,
    String? msg,
  }) =>
      ForgotPasswordModel(
        success: success ?? _success,
        msg: msg ?? _msg,
      );

  bool? get success => _success;

  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['msg'] = _msg;
    return map;
  }
}
