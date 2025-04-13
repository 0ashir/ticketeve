class GalleryImageAddRemoveResponseModel {
  GalleryImageAddRemoveResponseModel({
    String? msg,
    bool? success,
    String? data,
  }) {
    _msg = msg;
    _success = success;
    _data = data;
  }

  GalleryImageAddRemoveResponseModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _success = json['success'];
    _data = json['data'];
  }

  String? _msg;
  bool? _success;
  String? _data;

  GalleryImageAddRemoveResponseModel copyWith({
    String? msg,
    bool? success,
    String? data,
  }) =>
      GalleryImageAddRemoveResponseModel(
        msg: msg ?? _msg,
        success: success ?? _success,
        data: data ?? _data,
      );

  String? get msg => _msg;

  bool? get success => _success;

  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['success'] = _success;
    map['data'] = _data;
    return map;
  }
}
