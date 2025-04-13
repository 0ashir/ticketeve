class CouponModel {
  bool? success;
  dynamic msg;
  List<CouponData>? data;

  CouponModel({this.success, this.msg, this.data});

  CouponModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <CouponData>[];
      json['data'].forEach((v) {
        data!.add(CouponData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CouponData {
  int? id;
  int? userId;
  int? eventId;
  String? couponCode;
  String? name;
  num? discount;
  int? minimumAmount;
  int? maximumDiscount;
  String? description;
  String? startDate;
  String? endDate;
  int? maxUse;
  int? useCount;
  int? status;
  String? createdAt;
  String? updatedAt;

  CouponData(
      {this.id, this.userId, this.eventId, this.couponCode, this.name, this.discount, this.minimumAmount, this.maximumDiscount, this.description, this.startDate, this.endDate, this.maxUse, this.useCount, this.status, this.createdAt, this.updatedAt});

  CouponData.fromJson(Map<String, dynamic> json) {
  id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
  userId = json['user_id'] is int ? json['user_id'] : int.tryParse(json['user_id'].toString());
  eventId = json['event_id'] is int ? json['event_id'] : int.tryParse(json['event_id'].toString());
  couponCode = json['coupon_code'] as String?;
  name = json['name'] as String?;
  discount = json['discount'] is num ? json['discount'] : num.tryParse(json['discount'].toString());
  minimumAmount = json['minimum_amount'] is int ? json['minimum_amount'] : int.tryParse(json['minimum_amount'].toString());
  maximumDiscount = json['maximum_discount'] is int ? json['maximum_discount'] : int.tryParse(json['maximum_discount'].toString());
  description = json['description'] as String?;
  startDate = json['start_date'] as String?;
  endDate = json['end_date'] as String?;
  maxUse = json['max_use'] is int ? json['max_use'] : int.tryParse(json['max_use'].toString());
  useCount = json['use_count'] is int ? json['use_count'] : int.tryParse(json['use_count'].toString());
  status = json['status'] is int ? json['status'] : int.tryParse(json['status'].toString());
  createdAt = json['created_at'] as String?;
  updatedAt = json['updated_at'] as String?;
}


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['event_id'] = eventId;
    data['coupon_code'] = couponCode;
    data['name'] = name;
    data['discount'] = discount;
    data['minimum_amount'] = minimumAmount;
    data['maximum_discount'] = maximumDiscount;
    data['description'] = description;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['max_use'] = maxUse;
    data['use_count'] = useCount;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
