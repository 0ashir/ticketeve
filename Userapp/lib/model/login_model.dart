class LoginModel {
  LoginModel({
    String? msg,
    Data? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  LoginModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  String? _msg;
  Data? _data;
  bool? _success;

  LoginModel copyWith({
    String? msg,
    Data? data,
    bool? success,
  }) =>
      LoginModel(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  String? get msg => _msg;

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
    num? id,
    String? name,
    String? lastName,
    String? email,
    dynamic emailVerifiedAt,
    String? image,
    dynamic address,
    String? phone,
    String? following,
    String? favorite,
    String? favoriteBlog,
    dynamic lat,
    dynamic lang,
    String? provider,
    dynamic providerToken,
    String? deviceToken,
    String? bio,
    String? language,
    num? status,
    String? createdAt,
    String? updatedAt,
    String? token,
    String? imagePath,
    num? isVerify,
    String? otp,
  }) {
    _id = id;
    _name = name;
    _lastName = lastName;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _image = image;
    _address = address;
    _phone = phone;
    _following = following;
    _favorite = favorite;
    _favoriteBlog = favoriteBlog;
    _lat = lat;
    _lang = lang;
    _provider = provider;
    _providerToken = providerToken;
    _deviceToken = deviceToken;
    _bio = bio;
    _language = language;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _token = token;
    _imagePath = imagePath;
    _isVerify = isVerify;
    _otp = otp;
  }

  Data.fromJson(dynamic json) {
    _id = _parseNum(json['id']);
    _name = json['name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _image = json['image'];
    _address = json['address'];
    _phone = json['phone'];
    _following = json['following'];
    _favorite = json['favorite'];
    _favoriteBlog = json['favorite_blog'];
    _lat = json['lat'];
    _lang = json['lang'];
    _provider = json['provider'];
    _providerToken = json['provider_token'];
    _deviceToken = json['device_token'];
    _bio = json['bio'];
    _language = json['language'];
    _status = _parseNum(json['status']);
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _token = json['token'];
    _imagePath = json['imagePath'];
    _isVerify = _parseNum(json['is_verify']);
    _otp = json['otp']?.toString();
  }

  /// Utility function to safely parse numerical values
  num? _parseNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
    return null;
  }

  num? _id;
  String? _name;
  String? _lastName;
  String? _email;
  dynamic _emailVerifiedAt;
  String? _image;
  dynamic _address;
  String? _phone;
  String? _following;
  String? _favorite;
  String? _favoriteBlog;
  dynamic _lat;
  dynamic _lang;
  String? _provider;
  dynamic _providerToken;
  String? _deviceToken;
  String? _bio;
  String? _language;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _token;
  String? _imagePath;
  num? _isVerify;
  String? _otp;

  Data copyWith({
    num? id,
    String? name,
    String? lastName,
    String? email,
    dynamic emailVerifiedAt,
    String? image,
    dynamic address,
    String? phone,
    String? following,
    String? favorite,
    String? favoriteBlog,
    dynamic lat,
    dynamic lang,
    String? provider,
    dynamic providerToken,
    String? deviceToken,
    String? bio,
    String? language,
    num? status,
    String? createdAt,
    String? updatedAt,
    String? token,
    String? imagePath,
    num? isVerify,
    String? otp,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        lastName: lastName ?? _lastName,
        email: email ?? _email,
        emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
        image: image ?? _image,
        address: address ?? _address,
        phone: phone ?? _phone,
        following: following ?? _following,
        favorite: favorite ?? _favorite,
        favoriteBlog: favoriteBlog ?? _favoriteBlog,
        lat: lat ?? _lat,
        lang: lang ?? _lang,
        provider: provider ?? _provider,
        providerToken: providerToken ?? _providerToken,
        deviceToken: deviceToken ?? _deviceToken,
        bio: bio ?? _bio,
        language: language ?? _language,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        token: token ?? _token,
        imagePath: imagePath ?? _imagePath,
        isVerify: isVerify ?? _isVerify,
        otp: otp ?? _otp,
      );

  num? get id => _id;

  String? get name => _name;

  String? get lastName => _lastName;

  String? get email => _email;

  dynamic get emailVerifiedAt => _emailVerifiedAt;

  String? get image => _image;

  dynamic get address => _address;

  String? get phone => _phone;

  String? get following => _following;

  String? get favorite => _favorite;

  String? get favoriteBlog => _favoriteBlog;

  dynamic get lat => _lat;

  dynamic get lang => _lang;

  String? get provider => _provider;

  dynamic get providerToken => _providerToken;

  String? get deviceToken => _deviceToken;

  String? get bio => _bio;

  String? get language => _language;

  num? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get token => _token;

  String? get imagePath => _imagePath;

  num? get isVerify => _isVerify;

  String? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['email_verified_at'] = _emailVerifiedAt;
    map['image'] = _image;
    map['address'] = _address;
    map['phone'] = _phone;
    map['following'] = _following;
    map['favorite'] = _favorite;
    map['favorite_blog'] = _favoriteBlog;
    map['lat'] = _lat;
    map['lang'] = _lang;
    map['provider'] = _provider;
    map['provider_token'] = _providerToken;
    map['device_token'] = _deviceToken;
    map['bio'] = _bio;
    map['language'] = _language;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['token'] = _token;
    map['imagePath'] = _imagePath;
    map['is_verify'] = _isVerify;
    map['otp'] = _otp;
    return map;
  }
}
