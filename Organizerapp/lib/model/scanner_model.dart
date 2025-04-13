import 'package:dropdown_textfield/dropdown_textfield.dart';

class ScannerModel {
  ScannerModel({
    List<ScannerData>? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  ScannerModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(
          ScannerData.fromJson(v),
        );
      });
    }
    _success = json['success'];
  }

  List<ScannerData>? _data;
  bool? _success;

  ScannerModel copyWith({
    List<ScannerData>? data,
    bool? success,
  }) =>
      ScannerModel(
        data: data ?? _data,
        success: success ?? _success,
      );

  List<ScannerData>? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data
          ?.map(
            (v) => v.toJson(),
          )
          .toList();
    }
    map['success'] = _success;
    return map;
  }
}

class ScannerData {
  ScannerData({
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
    List<num>? followers,
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
    _followers = followers;
    _imagePath = imagePath;
  }

  ScannerData.fromJson(dynamic json) {
    _id = num.tryParse( json['id']);
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
    _followers = json['followers'] != null ? json['followers'].cast<num>() : [];
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
  List<num>? _followers;
  String? _imagePath;

  ScannerData copyWith({
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
    List<num>? followers,
    String? imagePath,
  }) =>
      ScannerData(
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
        followers: followers ?? _followers,
        imagePath: imagePath ?? _imagePath,
      );

   DropDownValueModel toDropDown() {
    return DropDownValueModel(name: _name!, value: _name);
  }

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

  List<num>? get followers => _followers;

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
    map['followers'] = _followers;
    map['imagePath'] = _imagePath;
    return map;
  }
}
