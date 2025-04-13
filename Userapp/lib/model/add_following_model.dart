class AddFollowingModel {
  AddFollowingModel({
    String? msg,
    dynamic data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  AddFollowingModel.fromJson(dynamic json) {
    _msg = json['msg'];
    
    if (json['data'] is Map<String, dynamic>) {
      _data = json['data']; // If data is a JSON object, store it as a Map
    } else if (json['data'] is List) {
      _data = List<dynamic>.from(json['data']); // If data is a List, cast it
    } else {
      _data = json['data']; // Otherwise, store it directly
    }

    _success = json['success'] is bool ? json['success'] : false; // Ensure it's a boolean
  }

  String? _msg;
  dynamic _data;
  bool? _success;

  AddFollowingModel copyWith({
    String? msg,
    dynamic data,
    bool? success,
  }) =>
      AddFollowingModel(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  String? get msg => _msg;

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
