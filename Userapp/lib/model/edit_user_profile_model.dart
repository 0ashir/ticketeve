class EditUserProfileModel {
  EditUserProfileModel({
    dynamic msg,
    Data? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  EditUserProfileModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  dynamic _msg;
  Data? _data;
  bool? _success;

  EditUserProfileModel copyWith({
    dynamic msg,
    Data? data,
    bool? success,
  }) =>
      EditUserProfileModel(
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
    dynamic favoriteBlog,
    dynamic lat,
    dynamic lang,
    String? provider,
    dynamic providerToken,
    String? deviceToken,
    dynamic bio,
    String? language,
    num? status,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
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
    _imagePath = imagePath;
  }

Data.fromJson(Map<String, dynamic> json) {
  _id = json['id'] is num ? json['id'] : num.tryParse(json['id'].toString());
  _name = json['name'] as String?;
  _lastName = json['last_name'] as String?;
  _email = json['email'] as String?;
  _emailVerifiedAt = json['email_verified_at'];
  _image = json['image'] as String?;
  _address = json['address'];
  _phone = json['phone'] as String?;
  _following = json['following'] as String?;
  _favorite = json['favorite'] as String?;
  _favoriteBlog = json['favorite_blog'];
  _lat = json['lat'];
  _lang = json['lang'];
  _provider = json['provider'] as String?;
  _providerToken = json['provider_token'];
  _deviceToken = json['device_token'] as String?;
  _bio = json['bio'];
  _language = json['language'] as String?;
  _status = json['status'] is num ? json['status'] : num.tryParse(json['status'].toString());
  _createdAt = json['created_at'] as String?;
  _updatedAt = json['updated_at'] as String?;
  _imagePath = json['imagePath'] as String?;
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
  dynamic _favoriteBlog;
  dynamic _lat;
  dynamic _lang;
  String? _provider;
  dynamic _providerToken;
  String? _deviceToken;
  dynamic _bio;
  String? _language;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _imagePath;

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
    dynamic favoriteBlog,
    dynamic lat,
    dynamic lang,
    String? provider,
    dynamic providerToken,
    String? deviceToken,
    dynamic bio,
    String? language,
    num? status,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
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
        imagePath: imagePath ?? _imagePath,
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

  dynamic get favoriteBlog => _favoriteBlog;

  dynamic get lat => _lat;

  dynamic get lang => _lang;

  String? get provider => _provider;

  dynamic get providerToken => _providerToken;

  String? get deviceToken => _deviceToken;

  dynamic get bio => _bio;

  String? get language => _language;

  num? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get imagePath => _imagePath;

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
    map['imagePath'] = _imagePath;
    return map;
  }
}
