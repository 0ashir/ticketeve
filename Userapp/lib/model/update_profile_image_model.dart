class UpdateProfileImageModel {
  UpdateProfileImageModel({
    dynamic msg,
    dynamic data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  UpdateProfileImageModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'];
    _success = json['success'];
  }

  dynamic _msg;
  dynamic _data;
  bool? _success;

  UpdateProfileImageModel copyWith({
    dynamic msg,
    dynamic data,
    bool? success,
  }) =>
      UpdateProfileImageModel(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  dynamic get msg => _msg;

  dynamic get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['data'] = _data;
    map['success'] = _success;
    return map;
  }
}
