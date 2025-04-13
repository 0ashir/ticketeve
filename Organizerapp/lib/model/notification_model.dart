class NotificationModel {
  bool? success;
  dynamic msg;
  List<NotificationData>? data;

  NotificationModel({this.success, this.msg, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(
          NotificationData.fromJson(v),
        );
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this
          .data!
          .map(
            (v) => v.toJson(),
          )
          .toList();
    }
    return data;
  }
}

class NotificationData {
  int? id;
  dynamic userId;
  int? organizerId;
  int? orderId;
  String? title;
  String? message;
  String? createdAt;
  String? updatedAt;
  Event? event;

  NotificationData(
      {this.id,
      this.userId,
      this.organizerId,
      this.orderId,
      this.title,
      this.message,
      this.createdAt,
      this.updatedAt,
      this.event});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    userId = json['user_id'];
    organizerId =int.parse( json['organizer_id']);
    orderId =int.parse( json['order_id']);
    title = json['title'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    event = json['event'] != null ? Event.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['organizer_id'] = organizerId;
    data['order_id'] = orderId;
    data['title'] = title;
    data['message'] = message;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (event != null) {
      data['event'] = event!.toJson();
    }
    return data;
  }
}

class Event {
  int? id;
  String? name;
  String? image;
  String? imagePath;

  Event({this.id, this.name, this.image, this.imagePath});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['imagePath'] = imagePath;
    return data;
  }
}
