class RegisterModel {
  RegisterModel({
    dynamic msg,
    Data? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  RegisterModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  dynamic _msg;
  Data? _data;
  bool? _success;

  RegisterModel copyWith({
    dynamic msg,
    Data? data,
    bool? success,
  }) =>
      RegisterModel(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  dynamic get msg => _msg;

  Data? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    return map;
  }
}

class Data {
  Data({
    String? lastName,
    String? email,
    String? phone,
    String? provider,
    String? deviceToken,
    String? image,
    num? status,
    String? name,
    String? language,
    String? updatedAt,
    String? createdAt,
    num? id,
    String? token,
    String? imagePath,
    num? isVerify,
    String? otp,
  }) {
    _lastName = lastName;
    _email = email;
    _phone = phone;
    _provider = provider;
    _deviceToken = deviceToken;
    _image = image;
    _status = status;
    _name = name;
    _language = language;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
    _token = token;
    _imagePath = imagePath;
    _isVerify = isVerify;
    _otp = otp;
  }

    Data.fromJson(dynamic json) {
    _lastName = json['last_name'];
    _email = json['email'];
    _phone = json['phone'];
    _provider = json['provider'];
    _deviceToken = json['device_token'];
    _image = json['image'];
    _status = json['status'];
    _name = json['name'];
    _language = json['language'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
    _token = json['token'];
    _imagePath = json['imagePath'];
    _isVerify = json['is_verify'];
    _otp = json['otp'].toString(); // Ensure OTP is handled as a string
  }
  String? _lastName;
  String? _email;
  String? _phone;
  String? _provider;
  String? _deviceToken;
  String? _image;
  num? _status;
  String? _name;
  String? _language;
  String? _updatedAt;
  String? _createdAt;
  num? _id;
  String? _token;
  String? _imagePath;
  num? _isVerify;
  String? _otp;

  Data copyWith({
    String? lastName,
    String? email,
    String? phone,
    String? provider,
    String? deviceToken,
    String? image,
    num? status,
    String? name,
    String? language,
    String? updatedAt,
    String? createdAt,
    num? id,
    String? token,
    String? imagePath,
    num? isVerify,
    String? otp,
  }) =>
      Data(
        lastName: lastName ?? _lastName,
        email: email ?? _email,
        phone: phone ?? _phone,
        provider: provider ?? _provider,
        deviceToken: deviceToken ?? _deviceToken,
        image: image ?? _image,
        status: status ?? _status,
        name: name ?? _name,
        language: language ?? _language,
        updatedAt: updatedAt ?? _updatedAt,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
        token: token ?? _token,
        imagePath: imagePath ?? _imagePath,
        isVerify: isVerify ?? _isVerify,
        otp: otp ?? _otp,
      );

  String? get lastName => _lastName;

  String? get email => _email;

  String? get phone => _phone;

  String? get provider => _provider;

  String? get deviceToken => _deviceToken;

  String? get image => _image;

  num? get status => _status;

  String? get name => _name;

  String? get language => _language;

  String? get updatedAt => _updatedAt;

  String? get createdAt => _createdAt;

  num? get id => _id;

  String? get token => _token;

  String? get imagePath => _imagePath;

  num? get isVerify => _isVerify;

  String? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['provider'] = _provider;
    map['device_token'] = _deviceToken;
    map['image'] = _image;
    map['status'] = _status;
    map['name'] = _name;
    map['language'] = _language;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    map['token'] = _token;
    map['imagePath'] = _imagePath;
    map['is_verify'] = _isVerify;
    map['otp'] = _otp;
    return map;
  }
}
