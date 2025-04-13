class FollowersModel {
  FollowersModel({
    bool? success,
    dynamic msg,
    List<FollowersData>? data,
  }) {
    _success = success;
    _msg = msg;
    _data = data;
  }

  FollowersModel.fromJson(dynamic json) {
    _success = json['success'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(
          FollowersData.fromJson(v),
        );
      });
    }
  }

  bool? _success;
  dynamic _msg;
  List<FollowersData>? _data;

  FollowersModel copyWith({
    bool? success,
    dynamic msg,
    List<FollowersData>? data,
  }) =>
      FollowersModel(
        success: success ?? _success,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  bool? get success => _success;

  dynamic get msg => _msg;

  List<FollowersData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data
          ?.map(
            (v) => v.toJson(),
          )
          .toList();
    }
    return map;
  }
}

class FollowersData {
  FollowersData({
    num? id,
    String? name,
    String? lastName,
    String? email,
    String? image,
    dynamic address,
    String? phone,
    String? following,
    String? favoriteBlog,
    String? deviceToken,
    String? bio,
    String? language,
    num? status,
    String? imagePath,
  }) {
    _id = id;
    _name = name;
    _lastName = lastName;
    _email = email;
    _image = image;
    _address = address;
    _phone = phone;
    _following = following;
    _favoriteBlog = favoriteBlog;
    _deviceToken = deviceToken;
    _bio = bio;
    _language = language;
    _status = status;
    _imagePath = imagePath;
  }

  FollowersData.fromJson(dynamic json) {
    _id = num.tryParse( json['id']);
    _name = json['name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _image = json['image'];
    _address = json['address'];
    _phone = json['phone'];
    _following = json['following'];
    _favoriteBlog = json['favorite_blog'];
    _deviceToken = json['device_token'];
    _bio = json['bio'];
    _language = json['language'];
    _status =  num.tryParse(json['status']);
    _imagePath = json['imagePath'];
  }

  num? _id;
  String? _name;
  String? _lastName;
  String? _email;
  String? _image;
  dynamic _address;
  String? _phone;
  String? _following;
  String? _favoriteBlog;
  String? _deviceToken;
  String? _bio;
  String? _language;
  num? _status;
  String? _imagePath;

  FollowersData copyWith({
    num? id,
    String? name,
    String? lastName,
    String? email,
    String? image,
    dynamic address,
    String? phone,
    String? following,
    String? favoriteBlog,
    String? deviceToken,
    String? bio,
    String? language,
    num? status,
    String? imagePath,
  }) =>
      FollowersData(
        id: id ?? _id,
        name: name ?? _name,
        lastName: lastName ?? _lastName,
        email: email ?? _email,
        image: image ?? _image,
        address: address ?? _address,
        phone: phone ?? _phone,
        following: following ?? _following,
        favoriteBlog: favoriteBlog ?? _favoriteBlog,
        deviceToken: deviceToken ?? _deviceToken,
        bio: bio ?? _bio,
        language: language ?? _language,
        status: status ?? _status,
        imagePath: imagePath ?? _imagePath,
      );

  num? get id => _id;

  String? get name => _name;

  String? get lastName => _lastName;

  String? get email => _email;

  String? get image => _image;

  dynamic get address => _address;

  String? get phone => _phone;

  String? get following => _following;

  String? get favoriteBlog => _favoriteBlog;

  String? get deviceToken => _deviceToken;

  String? get bio => _bio;

  String? get language => _language;

  num? get status => _status;

  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['image'] = _image;
    map['address'] = _address;
    map['phone'] = _phone;
    map['following'] = _following;
    map['favorite_blog'] = _favoriteBlog;
    map['device_token'] = _deviceToken;
    map['bio'] = _bio;
    map['language'] = _language;
    map['status'] = _status;
    map['imagePath'] = _imagePath;
    return map;
  }
}
