class AuthModel {
  AuthModel({String? msg, Data? data, bool? success, String? message}) {
    _msg = msg;
    _data = data;
    _success = success;
    _message = message;
  }

  AuthModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  String? _msg;
  Data? _data;
  bool? _success;
  String? _message;
  AuthModel copyWith({
    String? msg,
    Data? data,
    bool? success,
    String? message,
  }) =>
      AuthModel(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
        message: message ?? _message,
      );
  String? get msg => _msg;
  Data? get data => _data;
  bool? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    return map;
  }
}

class Data {
  Data({
    int? id,
    String? name,
    String? firstName,
    String? lastName,
    String? email,
    dynamic emailVerifiedAt,
    String? deviceToken,
    String? image,
    String? phone,
    dynamic bio,
    dynamic country,
    int? orgId,
    int? status,
    String? language,
    String? createdAt,
    String? updatedAt,
    String? token,
    List<num>? followers,
    String? imagePath,
    List<Roles>? roles,
  }) {
    _id = id;
    _name = name;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _deviceToken = deviceToken;
    _image = image;
    _phone = phone;
    _bio = bio;
    _country = country;
    _orgId = orgId;
    _status = status;
    _language = language;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _token = token;
    _followers = followers;
    _imagePath = imagePath;
    _roles = roles;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _deviceToken = json['device_token'];
    _image = json['image'];
    _phone = json['phone'];
    _bio = json['bio'];
    _country = json['country'];
    _orgId = json['org_id'];
    _status = json['status'];
    _language = json['language'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _token = json['token'];
    _followers = json['followers'] != null ? json['followers'].cast<num>() : [];
    _imagePath = json['imagePath'];
    if (json['roles'] != null) {
      _roles = [];
      json['roles'].forEach((v) {
        _roles?.add(Roles.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  String? _firstName;
  String? _lastName;
  String? _email;
  dynamic _emailVerifiedAt;
  String? _deviceToken;
  String? _image;
  String? _phone;
  dynamic _bio;
  dynamic _country;
  int? _orgId;
  int? _status;
  String? _language;
  String? _createdAt;
  String? _updatedAt;
  String? _token;
  List<num>? _followers;
  String? _imagePath;
  List<Roles>? _roles;
  Data copyWith({
    int? id,
    String? name,
    String? firstName,
    String? lastName,
    String? email,
    dynamic emailVerifiedAt,
    String? deviceToken,
    String? image,
    String? phone,
    dynamic bio,
    dynamic country,
    int? orgId,
    int? status,
    String? language,
    String? createdAt,
    String? updatedAt,
    String? token,
    List<num>? followers,
    String? imagePath,
    List<Roles>? roles,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        email: email ?? _email,
        emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
        deviceToken: deviceToken ?? _deviceToken,
        image: image ?? _image,
        phone: phone ?? _phone,
        bio: bio ?? _bio,
        country: country ?? _country,
        orgId: orgId ?? _orgId,
        status: status ?? _status,
        language: language ?? _language,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        token: token ?? _token,
        followers: followers ?? _followers,
        imagePath: imagePath ?? _imagePath,
        roles: roles ?? _roles,
      );
  int? get id => _id;
  String? get name => _name;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  String? get deviceToken => _deviceToken;
  String? get image => _image;
  String? get phone => _phone;
  dynamic get bio => _bio;
  dynamic get country => _country;
  int? get orgId => _orgId;
  int? get status => _status;
  String? get language => _language;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get token => _token;
  List<num>? get followers => _followers;
  String? get imagePath => _imagePath;
  List<Roles>? get roles => _roles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['email_verified_at'] = _emailVerifiedAt;
    map['device_token'] = _deviceToken;
    map['image'] = _image;
    map['phone'] = _phone;
    map['bio'] = _bio;
    map['country'] = _country;
    map['org_id'] = _orgId;
    map['status'] = _status;
    map['language'] = _language;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['token'] = _token;
    map['followers'] = _followers;
    map['imagePath'] = _imagePath;
    if (_roles != null) {
      map['roles'] = _roles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Roles {
  Roles({
    int? id,
    String? name,
    String? guardName,
    String? createdAt,
    String? updatedAt,
    Pivot? pivot,
  }) {
    _id = id;
    _name = name;
    _guardName = guardName;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _pivot = pivot;
  }

  Roles.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _guardName = json['guard_name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
  int? _id;
  String? _name;
  String? _guardName;
  String? _createdAt;
  String? _updatedAt;
  Pivot? _pivot;
  Roles copyWith({
    int? id,
    String? name,
    String? guardName,
    String? createdAt,
    String? updatedAt,
    Pivot? pivot,
  }) =>
      Roles(
        id: id ?? _id,
        name: name ?? _name,
        guardName: guardName ?? _guardName,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        pivot: pivot ?? _pivot,
      );
  int? get id => _id;
  String? get name => _name;
  String? get guardName => _guardName;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Pivot? get pivot => _pivot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['guard_name'] = _guardName;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_pivot != null) {
      map['pivot'] = _pivot?.toJson();
    }
    return map;
  }
}

class Pivot {
  Pivot({
    int? modelId,
    int? roleId,
    String? modelType,
  }) {
    _modelId = modelId;
    _roleId = roleId;
    _modelType = modelType;
  }

  Pivot.fromJson(dynamic json) {
    _modelId = json['model_id'];
    _roleId = json['role_id'];
    _modelType = json['model_type'];
  }
  int? _modelId;
  int? _roleId;
  String? _modelType;
  Pivot copyWith({
    int? modelId,
    int? roleId,
    String? modelType,
  }) =>
      Pivot(
        modelId: modelId ?? _modelId,
        roleId: roleId ?? _roleId,
        modelType: modelType ?? _modelType,
      );
  int? get modelId => _modelId;
  int? get roleId => _roleId;
  String? get modelType => _modelType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['model_id'] = _modelId;
    map['role_id'] = _roleId;
    map['model_type'] = _modelType;
    return map;
  }
}
