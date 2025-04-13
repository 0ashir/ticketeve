class LoginModel {
  String? msg;
  Data? data;
  bool? success;

  LoginModel({this.msg, this.data, this.success});

  LoginModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = success;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  dynamic emailVerifiedAt;
  String? deviceToken;
  String? image;
  String? phone;
  String? bio;
  dynamic country;
  dynamic orgId;
  int? status;
  String? language;
  String? createdAt;
  String? updatedAt;
  String? token;
  List<int>? followers;
  String? imagePath;
  List<Roles>? roles;
  num? isVerify;
  String? otp;
  Data({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.deviceToken,
    this.image,
    this.phone,
    this.bio,
    this.country,
    this.orgId,
    this.status,
    this.language,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.followers,
    this.imagePath,
    this.roles,
    this.isVerify,
    this.otp,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'] != null
        ? DateTime.tryParse(json['email_verified_at'].toString())
        : null;
    deviceToken = json['device_token'];
    image = json['image'];
    phone = json['phone']?.toString(); // Ensures phone is a String
    bio = json['bio'];
    country = json['country'];
    orgId = json['org_id'] == null ? json['ord_id'] : int.parse(json['org_id']);
    status =
        json['status'] == null ? json['status'] : int.parse(json['status']);
    language = json['language'];
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    token = json['token'];
    // Ensuring followers is a list of integers
    followers = json['followers'] != null
        ? List<int>.from(
            json['followers'].map((x) => int.tryParse(x.toString()) ?? 0))
        : [];
    imagePath = json['imagePath'];
    isVerify = num.tryParse(json['is_verify']);

    otp = json['otp']?.toString(); // Ensures OTP is a string

    if (json['roles'] != null) {
      roles = List<Roles>.from(json['roles'].map((x) => Roles.fromJson(x)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['device_token'] = deviceToken;
    data['image'] = image;
    data['phone'] = phone;
    data['bio'] = bio;
    data['country'] = country;
    data['org_id'] = orgId;
    data['status'] = status;
    data['language'] = language;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['token'] = token;
    data['followers'] = followers;
    data['imagePath'] = imagePath;
    data['is_verify'] = isVerify;
    data['otp'] = otp;
    if (roles != null) {
      data['roles'] = roles!
          .map(
            (v) => v.toJson(),
          )
          .toList();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  String? guardName;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Roles(
      {this.id,
      this.name,
      this.guardName,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
    name = json['name'];
    guardName = json['guard_name'];
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['guard_name'] = guardName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? modelId;
  int? roleId;
  String? modelType;

  Pivot({this.modelId, this.roleId, this.modelType});

  Pivot.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    roleId = json['role_id'];
    modelType = json['model_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model_id'] = modelId;
    data['role_id'] = roleId;
    data['model_type'] = modelType;
    return data;
  }
}
