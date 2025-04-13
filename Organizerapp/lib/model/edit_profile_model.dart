class EditProfileModel {
  EditProfileModel({
    bool? success,
    String? msg,
    Data? data,
  }) {
    _success = success;
    _msg = msg;
    _data = data;
  }

  EditProfileModel.fromJson(dynamic json) {
    _success = json['success'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _success;
  String? _msg;
  Data? _data;

  EditProfileModel copyWith({
    bool? success,
    String? msg,
    Data? data,
  }) =>
      EditProfileModel(
        success: success ?? _success,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  bool? get success => _success;

  String? get msg => _msg;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    num? id,
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
    num? orgId,
    num? status,
    String? language,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
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
    _imagePath = imagePath;
  }

  Data.fromJson(dynamic json) {
    _id =  num.tryParse(json['id']);
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
    _orgId =  num.tryParse(json['org_id']);
    _status = num.tryParse( json['status']);
    _language = json['language'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imagePath = json['imagePath'];
  }

  num? _id;
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
  num? _orgId;
  num? _status;
  String? _language;
  String? _createdAt;
  String? _updatedAt;
  String? _imagePath;

  Data copyWith({
    num? id,
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
    num? orgId,
    num? status,
    String? language,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
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
        imagePath: imagePath ?? _imagePath,
      );

  num? get id => _id;

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

  num? get orgId => _orgId;

  num? get status => _status;

  String? get language => _language;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get imagePath => _imagePath;

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
    map['imagePath'] = _imagePath;
    return map;
  }
}
