class EditProfileImageModel {
  EditProfileImageModel({
    String? msg,
    String? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  EditProfileImageModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'];
    _success = json['success'];
  }

  String? _msg;
  String? _data;
  bool? _success;

  EditProfileImageModel copyWith({
    String? msg,
    String? data,
    bool? success,
  }) =>
      EditProfileImageModel(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  String? get msg => _msg;

  String? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['data'] = _data;
    map['success'] = _success;
    return map;
  }
}
