import 'package:eventright_pro_user/model/all_events_model.dart';

class FollowingModel {
  dynamic msg;
  List<FollowingData>? data;
  bool? success;

  FollowingModel({this.msg, this.data, this.success});

  FollowingModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <FollowingData>[];
      json['data'].forEach((v) {
        data!.add(FollowingData.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class FollowingData {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  dynamic emailVerifiedAt;
  dynamic deviceToken;
  String? image;
  String? phone;
  dynamic bio;
  String? country;
  dynamic orgId;
  int? status;
  String? language;
  String? createdAt;
  String? updatedAt;
  bool? isFollow;
  List<int>? followers;
  String? imagePath;
  List<Events>? events;

  FollowingData(
      {this.id,
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
      this.isFollow,
      this.followers,
      this.imagePath,
      this.events});
FollowingData.fromJson(Map<String, dynamic> json) {
  id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0;
  name = json['name'] ?? '';
  firstName = json['first_name'] ?? '';
  lastName = json['last_name'] ?? '';
  email = json['email'] ?? '';
  
  // Handling dynamic types for 'emailVerifiedAt' and 'deviceToken'
  emailVerifiedAt = _parseDate(json['email_verified_at']);
  deviceToken = json['device_token'] ?? '';
  
  image = json['image'] ?? '';
  phone = json['phone'] ?? '';
  bio = json['bio'] ?? '';
  country = json['country'] ?? '';
  
  orgId = json['org_id'] is int ? json['org_id'] : int.tryParse(json['org_id'].toString()) ?? 0;
  status = json['status'] is int ? json['status'] : int.tryParse(json['status'].toString()) ?? 0;
  language = json['language'] ?? '';
  
  // Handling date fields to ensure they are in string format if needed
  createdAt = _parseDate(json['created_at']);
  updatedAt = _parseDate(json['updated_at']);
  
  // Default to false if 'isFollow' is missing or null
  isFollow = json['isFollow'] ?? false;
  
  // Safely cast followers list to List<int> if it exists
  if (json['followers'] is List) {
    followers = List<int>.from(json['followers']);
  }
  
  imagePath = json['imagePath'] ?? '';
  
  // Parse the 'events' list, ensuring it's not null
  if (json['events'] != null) {
    events = <Events>[]; 
    json['events'].forEach((v) {
      events!.add(Events.fromJson(v));
    });
  }
}

// Helper method to parse date values (converts non-string values to strings)
String? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is String) return value; // If it's already a string, return it
  return value.toString(); // Otherwise, convert it to a string
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
    data['isFollow'] = isFollow;
    data['followers'] = followers;
    data['imagePath'] = imagePath;
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
