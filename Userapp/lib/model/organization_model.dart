class OrganizationModel {
  OrganizationModel({
    dynamic msg,
    List<OrganizationData>? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  OrganizationModel.fromJson(dynamic json) {
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(OrganizationData.fromJson(v));
      });
    }
    _success = json['success'];
  }

  dynamic _msg;
  List<OrganizationData>? _data;
  bool? _success;

  OrganizationModel copyWith({
    dynamic msg,
    List<OrganizationData>? data,
    bool? success,
  }) =>
      OrganizationModel(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  dynamic get msg => _msg;

  List<OrganizationData>? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    return map;
  }
}

class OrganizationData {
  OrganizationData({
    num? id,
    dynamic name,
    String? firstName,
    String? lastName,
    String? email,
    dynamic emailVerifiedAt,
    String? deviceToken,
    String? image,
    String? phone,
    dynamic bio,
    dynamic country,
    dynamic orgId,
    num? status,
    String? language,
    bool? isFollow,
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
    _isFollow = isFollow;
    _imagePath = imagePath;
  }
OrganizationData.fromJson(dynamic json) {
  _id = json['id'] is num ? json['id'] : num.tryParse(json['id'].toString()) ?? 0;
  _name = json['name'] ?? '';
  _firstName = json['first_name'] ?? '';
  _lastName = json['last_name'] ?? '';
  _email = json['email'] ?? '';
  
  // Handling emailVerifiedAt and converting it to string if needed
  _emailVerifiedAt = _parseDate(json['email_verified_at']);
  
  _deviceToken = json['device_token'] ?? '';
  _image = json['image'] ?? '';
  _phone = json['phone'] ?? '';
  
  // Handling bio and country with default values if missing
  _bio = json['bio'] ?? '';
  _country = json['country'] ?? 'Unknown';
  
  // Handling orgId and status by safely casting to the correct type
  _orgId = json['org_id'] is num ? json['org_id'] : num.tryParse(json['org_id'].toString()) ?? 0;
  _status = json['status'] is num ? json['status'] : num.tryParse(json['status'].toString()) ?? 0;
  
  _language = json['language'] ?? '';
  
  // Default to false if isFollow is missing or null
  _isFollow = json['isFollow'] ?? false;
  
  _imagePath = json['imagePath'] ?? '';
}

// Helper method to parse date values (converts non-string values to strings)
String? _parseDate(dynamic value) {
  if (value == null) return 'N/A';
  if (value is String) return value;
  return value.toString();
}



  num? _id;
  dynamic _name;
  String? _firstName;
  String? _lastName;
  String? _email;
  dynamic _emailVerifiedAt;
  String? _deviceToken;
  String? _image;
  String? _phone;
  dynamic _bio;
  dynamic _country;
  dynamic _orgId;
  num? _status;
  String? _language;
  bool? _isFollow;
  String? _imagePath;

  OrganizationData copyWith({
    num? id,
    dynamic name,
    String? firstName,
    String? lastName,
    String? email,
    dynamic emailVerifiedAt,
    String? deviceToken,
    String? image,
    String? phone,
    dynamic bio,
    dynamic country,
    dynamic orgId,
    num? status,
    String? language,
    bool? isFollow,
    String? imagePath,
  }) =>
      OrganizationData(
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
        isFollow: isFollow ?? _isFollow,
        imagePath: imagePath ?? _imagePath,
      );

  num? get id => _id;

  dynamic get name => _name;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get email => _email;

  dynamic get emailVerifiedAt => _emailVerifiedAt;

  String? get deviceToken => _deviceToken;

  String? get image => _image;

  String? get phone => _phone;

  dynamic get bio => _bio;

  dynamic get country => _country;

  dynamic get orgId => _orgId;

  num? get status => _status;

  String? get language => _language;

  bool? get isFollow => _isFollow;

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
    map['isFollow'] = _isFollow;
    map['imagePath'] = _imagePath;
    return map;
  }
}
