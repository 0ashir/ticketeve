import 'dart:developer';

class RegisterModel {
  RegisterModel({
    String? msg,
    Data? data,
    bool? success,
    String? countryCode,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
    _countryCode = countryCode;
  }

  RegisterModel.fromJson(dynamic json) {
    log('FORM JSON CALLED');
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
    _countryCode = json['Countrycode'];
  }

  String? _msg;
  Data? _data;
  bool? _success;
  String? _countryCode;

  RegisterModel copyWith({
    String? msg,
    Data? data,
    bool? success,
    String? countryCode,
  }) =>
      RegisterModel(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
        countryCode: countryCode ?? _countryCode,
      );

  Data? get data => _data;

  bool? get success => _success;

  String? get countryCode => _countryCode;

  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    map['Countrycode'] = _countryCode;
    return map;
  }
}

class Data {
  Data({
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    String? image,
    String? language,
    String? updatedAt,
    String? createdAt,
    num? id,
    String? token,
    List<dynamic>? followers,
    String? imagePath,
    List<Roles>? roles,
    num? isVerify,
    String? otp,
  }) {
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _phone = phone;
    _image = image;
    _language = language;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
    _token = token;
    _imagePath = imagePath;
    _roles = roles;
    _isVerify = isVerify;
    _otp = otp;
  }

 Data.fromJson(dynamic json) {

  _email = json['email'] as String?;
  _firstName = json['first_name'] as String?;
  _lastName = json['last_name'] as String?;
  _phone = json['phone']?.toString(); // Ensure phone is always a string
  _image = json['image'] as String?;
  _language = json['language'] as String?;
  _updatedAt = json['updated_at'] as String?;
  _createdAt = json['created_at'] as String?;
  _id = json['id'] != null ? num.tryParse(json['id'].toString()) : null; // Convert ID safely
  _token = json['token'] as String?;
  _isVerify = json['is_verify'] != null ? num.tryParse(json['is_verify'].toString()) : null; // Convert is_verify safely
  _otp = json['otp']?.toString(); // Convert otp to String
  _imagePath = json['imagePath'] as String?;

  _roles = [];
  if (json['roles'] != null && json['roles'] is List) {
    for (var v in json['roles']) {
      _roles?.add(Roles.fromJson(v));
    }
  }

}



  String? _email;
  String? _firstName;
  String? _lastName;
  String? _phone;
  String? _image;
  String? _language;
  String? _updatedAt;
  String? _createdAt;
  num? _id;
  String? _token;
  String? _imagePath;
  List<Roles>? _roles;
  num? _isVerify;
  String? _otp;

  Data copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    String? image,
    String? language,
    String? updatedAt,
    String? createdAt,
    num? id,
    String? token,
    String? imagePath,
    List<Roles>? roles,
    num? isVerify,
    String? otp,
  }) =>
      Data(
        email: email ?? _email,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        phone: phone ?? _phone,
        image: image ?? _image,
        language: language ?? _language,
        updatedAt: updatedAt ?? _updatedAt,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
        token: token ?? _token,
        imagePath: imagePath ?? _imagePath,
        roles: roles ?? _roles,
        isVerify: isVerify ?? _isVerify,
        otp: otp ?? _otp,
      );

  String? get email => _email;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get phone => _phone;

  String? get image => _image;

  String? get language => _language;

  String? get updatedAt => _updatedAt;

  String? get createdAt => _createdAt;

  num? get id => _id;

  String? get token => _token;

  String? get imagePath => _imagePath;

  List<Roles>? get roles => _roles;

  num? get isVerify => _isVerify;

  String? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['phone'] = _phone;
    map['image'] = _image;
    map['language'] = _language;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    map['token'] = _token;
    map['imagePath'] = _imagePath;
    map['is_verify'] = _isVerify;
    map['otp'] = _otp;
    if (_roles != null) {
      map['roles'] = _roles
          ?.map(
            (v) => v.toJson(),
          )
          .toList();
    }
    return map;
  }
}

class Roles {
  Roles({
    num? id,
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
  _id = json['id'] != null ? num.tryParse(json['id'].toString()) : null; // Convert ID safely
  _name = json['name'] as String?;
  _guardName = json['guard_name'] as String?;
  _createdAt = json['created_at']?.toString();
  _updatedAt = json['updated_at']?.toString();
  _pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
}



  num? _id;
  String? _name;
  String? _guardName;
  String? _createdAt;
  String? _updatedAt;
  Pivot? _pivot;

  Roles copyWith({
    num? id,
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

  num? get id => _id;

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
    num? modelId,
    num? roleId,
    String? modelType,
  }) {
    _modelId = modelId;
    _roleId = roleId;
    _modelType = modelType;
  }

 Pivot.fromJson(dynamic json) {
  _modelId = json['model_id'] != null ? num.tryParse(json['model_id'].toString()) : null; // Convert modelId safely
  _roleId = json['role_id'] != null ? num.tryParse(json['role_id'].toString()) : null; // Convert roleId safely
  _modelType = json['model_type'] as String?;
}



  num? _modelId;
  num? _roleId;
  String? _modelType;

  Pivot copyWith({
    num? modelId,
    num? roleId,
    String? modelType,
  }) =>
      Pivot(
        modelId: modelId ?? _modelId,
        roleId: roleId ?? _roleId,
        modelType: modelType ?? _modelType,
      );

  num? get modelId => _modelId;

  num? get roleId => _roleId;

  String? get modelType => _modelType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['model_id'] = _modelId;
    map['role_id'] = _roleId;
    map['model_type'] = _modelType;
    return map;
  }
}
