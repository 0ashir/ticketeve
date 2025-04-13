class DeleteEventModel {
  DeleteEventModel({
    String? msg,
    bool? success,
  }) {
    _msg = msg;
    _success = success;
  }

  DeleteEventModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _success = json['success'];
  }

  String? _msg;
  bool? _success;

  DeleteEventModel copyWith({
    String? msg,
    bool? success,
  }) =>
      DeleteEventModel(
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
