class OrderModel {
  bool? success;
  dynamic msg;
  Data? data;

  OrderModel({this.success, this.msg, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Upcoming>? upcoming;
  List<Past>? past;

  Data({this.upcoming, this.past});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['upcoming'] != null) {
      upcoming = <Upcoming>[];
      json['upcoming'].forEach((v) {
        // Safe parsing of each item in the 'upcoming' list
        upcoming!.add(Upcoming.fromJson(v));
      });
    }

    if (json['past'] != null) {
      past = <Past>[];
      json['past'].forEach((v) {
        // Safe parsing of each item in the 'past' list
        past!.add(Past.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (upcoming != null) {
      data['upcoming'] = upcoming!.map((v) => v.toJson()).toList();
    }
    if (past != null) {
      data['past'] = past!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Upcoming {
  int? id;
  String? orderId;
  int? customerId;
  int? organizationId;
  int? eventId;
  int? ticketId;
  int? couponId;
  int? quantity;
  num? couponDiscount;
  int? tax;
  int? orgCommission;
  num? payment;
  String? paymentType;
  int? paymentStatus;
  String? paymentToken;
  String? orderStatus;
  int? orgPayStatus;
  String? createdAt;
  String? updatedAt;
  List<OrderChild>? orderChild;
  Review? review;
  Event? event;
  Ticket? ticket;

  Upcoming(
      {this.id,
      this.orderId,
      this.customerId,
      this.organizationId,
      this.eventId,
      this.ticketId,
      this.couponId,
      this.quantity,
      this.couponDiscount,
      this.tax,
      this.orgCommission,
      this.payment,
      this.paymentType,
      this.paymentStatus,
      this.paymentToken,
      this.orderStatus,
      this.orgPayStatus,
      this.createdAt,
      this.updatedAt,
      this.orderChild,
      this.review,
      this.event,
      this.ticket});

  Upcoming.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
    orderId = json['order_id']?.toString();
    customerId = json['customer_id'] is int
        ? json['customer_id']
        : int.tryParse(json['customer_id'].toString());
    organizationId = json['organization_id'] is int
        ? json['organization_id']
        : int.tryParse(json['organization_id'].toString());
    eventId = json['event_id'] is int
        ? json['event_id']
        : int.tryParse(json['event_id'].toString());
    ticketId = json['ticket_id'] is int
        ? json['ticket_id']
        : int.tryParse(json['ticket_id'].toString());
    couponId = json['coupon_id'] is int
        ? json['coupon_id']
        : int.tryParse(json['coupon_id'].toString());
    quantity = json['quantity'] is int
        ? json['quantity']
        : int.tryParse(json['quantity'].toString());
    couponDiscount = json['coupon_discount'] is num
        ? json['coupon_discount']
        : num.tryParse(json['coupon_discount'].toString());
    tax =
        json['tax'] is int ? json['tax'] : int.tryParse(json['tax'].toString());
    orgCommission = json['org_commission'] is int
        ? json['org_commission']
        : int.tryParse(json['org_commission'].toString());
    payment = json['payment'] is num
        ? json['payment']
        : num.tryParse(json['payment'].toString());
    paymentType = json['payment_type']?.toString();
    paymentStatus = json['payment_status'] is int
        ? json['payment_status']
        : int.tryParse(json['payment_status'].toString());
    paymentToken = json['payment_token']?.toString();
    orderStatus = json['order_status']?.toString();
    orgPayStatus = json['org_pay_status'] is int
        ? json['org_pay_status']
        : int.tryParse(json['org_pay_status'].toString());
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();

    if (json['order_child'] is List) {
      orderChild = (json['order_child'] as List)
          .map((v) => OrderChild.fromJson(v))
          .toList();
    }

    review = json['review'] is Map<String, dynamic>
        ? Review.fromJson(json['review'])
        : null;
    event = json['event'] is Map<String, dynamic>
        ? Event.fromJson(json['event'])
        : null;
    ticket = json['ticket'] is Map<String, dynamic>
        ? Ticket.fromJson(json['ticket'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['customer_id'] = customerId;
    data['organization_id'] = organizationId;
    data['event_id'] = eventId;
    data['ticket_id'] = ticketId;
    data['coupon_id'] = couponId;
    data['quantity'] = quantity;
    data['coupon_discount'] = couponDiscount;
    data['tax'] = tax;
    data['org_commission'] = orgCommission;
    data['payment'] = payment;
    data['payment_type'] = paymentType;
    data['payment_status'] = paymentStatus;
    data['payment_token'] = paymentToken;
    data['order_status'] = orderStatus;
    data['org_pay_status'] = orgPayStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (orderChild != null) {
      data['order_child'] = orderChild!.map((v) => v.toJson()).toList();
    }
    if (review != null) {
      data['review'] = review!.toJson();
    }
    if (event != null) {
      data['event'] = event!.toJson();
    }
    if (ticket != null) {
      data['ticket'] = ticket!.toJson();
    }
    return data;
  }
}

class OrderChild {
  int? id;
  int? ticketId;
  int? orderId;
  int? customerId;
  String? ticketNumber;
  int? status;
  String? createdAt;
  String? updatedAt;

  OrderChild(
      {this.id,
      this.ticketId,
      this.orderId,
      this.customerId,
      this.ticketNumber,
      this.status,
      this.createdAt,
      this.updatedAt});

  OrderChild.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
    ticketId = json['ticket_id'] is int
        ? json['ticket_id']
        : int.tryParse(json['ticket_id'].toString());
    orderId = json['order_id'] is int
        ? json['order_id']
        : int.tryParse(json['order_id'].toString());
    customerId = json['customer_id'] is int
        ? json['customer_id']
        : int.tryParse(json['customer_id'].toString());
    ticketNumber = json['ticket_number']?.toString();
    status = json['status'] is int
        ? json['status']
        : int.tryParse(json['status'].toString());
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ticket_id'] = ticketId;
    data['order_id'] = orderId;
    data['customer_id'] = customerId;
    data['ticket_number'] = ticketNumber;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Review {
  int? id;
  int? userId;
  int? organizationId;
  int? orderId;
  int? eventId;
  String? message;
  int? rate;
  int? status;
  String? createdAt;
  String? updatedAt;
  User? user;
  Event? event;

  Review(
      {this.id,
      this.userId,
      this.organizationId,
      this.orderId,
      this.eventId,
      this.message,
      this.rate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.event});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
    userId = json['user_id'] is int
        ? json['user_id']
        : int.tryParse(json['user_id'].toString());
    organizationId = json['organization_id'] is int
        ? json['organization_id']
        : int.tryParse(json['organization_id'].toString());
    orderId = json['order_id'] is int
        ? json['order_id']
        : int.tryParse(json['order_id'].toString());
    eventId = json['event_id'] is int
        ? json['event_id']
        : int.tryParse(json['event_id'].toString());
    message = json['message']?.toString();
    rate = json['rate'] is int
        ? json['rate']
        : int.tryParse(json['rate'].toString());
    status = json['status'] is int
        ? json['status']
        : int.tryParse(json['status'].toString());
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    event = json['event'] != null ? Event.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['organization_id'] = organizationId;
    data['order_id'] = orderId;
    data['event_id'] = eventId;
    data['message'] = message;
    data['rate'] = rate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (event != null) {
      data['event'] = event!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? lastName;
  String? image;
  String? email;

  User({this.id, this.name, this.lastName, this.image, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
    name = json['name']?.toString();
    lastName = json['last_name']?.toString();
    image = json['image']?.toString();
    email = json['email']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['last_name'] = lastName;
    data['image'] = image;
    data['email'] = email;
    return data;
  }
}

class Event {
  int? id;
  String? name;
  String? type;
  int? userId;
  String? scannerId;
  String? address;
  int? categoryId;
  String? startTime;
  String? endTime;
  String? image;
  String? gallery;
  int? people;
  String? lat;
  String? lang;
  String? description;
  int? security;
  String? tags;
  int? status;
  String? eventStatus;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? imagePath;
  int? rate;
  dynamic totalTickets;
  dynamic soldTickets;

  Event(
      {this.id,
      this.name,
      this.type,
      this.userId,
      this.scannerId,
      this.address,
      this.categoryId,
      this.startTime,
      this.endTime,
      this.image,
      this.gallery,
      this.people,
      this.lat,
      this.lang,
      this.description,
      this.security,
      this.tags,
      this.status,
      this.eventStatus,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.imagePath,
      this.rate,
      this.totalTickets,
      this.soldTickets});
  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
    name = json['name']?.toString();
    type = json['type']?.toString();
    userId = json['user_id'] is int
        ? json['user_id']
        : int.tryParse(json['user_id'].toString());
    scannerId = json['scanner_id'] is int
        ? json['scanner_id'].toString() // Convert int to String
        : json['scanner_id'] is String
            ? json['scanner_id']
            : json['scanner_id']?.toString();
    address = json['address']?.toString();
    categoryId = json['category_id'] is int
        ? json['category_id']
        : int.tryParse(json['category_id'].toString());
    startTime = json['start_time']?.toString();
    endTime = json['end_time']?.toString();
    image = json['image']?.toString();
    gallery = json['gallery']?.toString();
    people = json['people'] is int
        ? json['people']
        : int.tryParse(json['people'].toString());
    lat = json['lat'].toString();
    lang = json['lang'].toString();
    description = json['description']?.toString();
    security = int.tryParse(json['security']?.toString() ?? '');
    tags = json['tags']?.toString();
    status = json['status'] is int
        ? json['status']
        : int.tryParse(json['status'].toString());
    eventStatus = json['event_status'] is int
        ? json['event_status']
        : int.tryParse(json['event_status'].toString());
    isDeleted = json['is_deleted'] is int
        ? json['is_deleted']
        : int.tryParse(json['is_deleted'].toString());
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    imagePath = json['imagePath']?.toString();
    rate = json['rate'] is num
        ? json['rate']
        : num.tryParse(json['rate'].toString());
    totalTickets = json['totalTickets'] is int
        ? json['totalTickets']
        : int.tryParse(json['totalTickets'].toString());
    soldTickets = json['soldTickets'] is int
        ? json['soldTickets']
        : int.tryParse(json['soldTickets'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['user_id'] = userId;
    data['scanner_id'] = scannerId;
    data['address'] = address;
    data['category_id'] = categoryId;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['image'] = image;
    data['gallery'] = gallery;
    data['people'] = people;
    data['lat'] = lat;
    data['lang'] = lang;
    data['description'] = description;
    data['security'] = security;
    data['tags'] = tags;
    data['status'] = status;
    data['event_status'] = eventStatus;
    data['is_deleted'] = isDeleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['imagePath'] = imagePath;
    data['rate'] = rate;
    data['totalTickets'] = totalTickets;
    data['soldTickets'] = soldTickets;
    return data;
  }
}

class Ticket {
  int? id;
  int? eventId;
  int? userId;
  String? ticketNumber;
  String? name;
  String? type;
  int? quantity;
  int? ticketPerOrder;
  String? startTime;
  String? endTime;
  num? price;
  String? description;
  int? status;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;

  Ticket(
      {this.id,
      this.eventId,
      this.userId,
      this.ticketNumber,
      this.name,
      this.type,
      this.quantity,
      this.ticketPerOrder,
      this.startTime,
      this.endTime,
      this.price,
      this.description,
      this.status,
      this.isDeleted,
      this.createdAt,
      this.updatedAt});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
    eventId = json['event_id'] is int
        ? json['event_id']
        : int.tryParse(json['event_id'].toString());
    userId = json['user_id'] is int
        ? json['user_id']
        : int.tryParse(json['user_id'].toString());
    ticketNumber = json['ticket_number']?.toString();
    name = json['name']?.toString();
    type = json['type']?.toString();
    quantity = json['quantity'] is int
        ? json['quantity']
        : int.tryParse(json['quantity'].toString());
    ticketPerOrder = json['ticket_per_order'] is int
        ? json['ticket_per_order']
        : int.tryParse(json['ticket_per_order'].toString());
    startTime = json['start_time']?.toString();
    endTime = json['end_time']?.toString();
    price =
        json['price'] != null ? num.tryParse(json['price'].toString()) ?? 0 : 0;
    description = json['description']?.toString();
    status = json['status'] is int
        ? json['status']
        : int.tryParse(json['status'].toString());
    isDeleted = json['is_deleted'] is int
        ? json['is_deleted']
        : int.tryParse(json['is_deleted'].toString());
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['event_id'] = eventId;
    data['user_id'] = userId;
    data['ticket_number'] = ticketNumber;
    data['name'] = name;
    data['type'] = type;
    data['quantity'] = quantity;
    data['ticket_per_order'] = ticketPerOrder;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['price'] = price;
    data['description'] = description;
    data['status'] = status;
    data['is_deleted'] = isDeleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Past {
  int? id;
  String? orderId;
  int? customerId;
  int? organizationId;
  int? eventId;
  int? ticketId;
  dynamic couponId;
  int? quantity;
  num? couponDiscount;
  num? tax;
  num? orgCommission;
  num? payment;
  String? paymentType;
  int? paymentStatus;
  String? paymentToken;
  String? orderStatus;
  int? orgPayStatus;
  String? createdAt;
  String? updatedAt;
  List<OrderChild>? orderChild;
  Review? review;
  Event? event;
  Ticket? ticket;

  Past(
      {this.id,
      this.orderId,
      this.customerId,
      this.organizationId,
      this.eventId,
      this.ticketId,
      this.couponId,
      this.quantity,
      this.couponDiscount,
      this.tax,
      this.orgCommission,
      this.payment,
      this.paymentType,
      this.paymentStatus,
      this.paymentToken,
      this.orderStatus,
      this.orgPayStatus,
      this.createdAt,
      this.updatedAt,
      this.orderChild,
      this.review,
      this.event,
      this.ticket});

  Past.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
    orderId = json['order_id'] is int
        ? json['order_id']
        : int.tryParse(json['order_id'].toString());
    customerId = json['customer_id'] is int
        ? json['customer_id']
        : int.tryParse(json['customer_id'].toString());
    organizationId = json['organization_id'] is int
        ? json['organization_id']
        : int.tryParse(json['organization_id'].toString());
    eventId = json['event_id'] is int
        ? json['event_id']
        : int.tryParse(json['event_id'].toString());
    ticketId = json['ticket_id'] is int
        ? json['ticket_id']
        : int.tryParse(json['ticket_id'].toString());
    couponId = json['coupon_id'] is int
        ? json['coupon_id']
        : int.tryParse(json['coupon_id'].toString());
    quantity = json['quantity'] is int
        ? json['quantity']
        : int.tryParse(json['quantity'].toString());
    couponDiscount = json['coupon_discount'] != null
        ? num.tryParse(json['coupon_discount'].toString()) ?? 0
        : 0;
    tax = json['tax'] != null ? num.tryParse(json['tax'].toString()) ?? 0 : 0;
    orgCommission = json['org_commission'] != null
        ? num.tryParse(json['org_commission'].toString()) ?? 0
        : 0;
    payment = json['payment'] != null
        ? num.tryParse(json['payment'].toString()) ?? 0
        : 0;
    paymentType = json['payment_type']?.toString();
    paymentStatus = json['payment_status'] is int
        ? json['payment_status']
        : int.tryParse(json['payment_status'].toString());
    paymentToken = json['payment_token']?.toString();
    orderStatus = json['order_status'] is int
        ? json['order_status']
        : int.tryParse(json['order_status'].toString());
    orgPayStatus = json['org_pay_status'] is int
        ? json['org_pay_status']
        : int.tryParse(json['org_pay_status'].toString());
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    orderChild = (json['order_child'] as List?)
            ?.map((v) => OrderChild.fromJson(v))
            .toList() ??
        [];
    review = json['review'] != null ? Review.fromJson(json['review']) : null;
    event = json['event'] != null ? Event.fromJson(json['event']) : null;
    ticket = json['ticket'] != null ? Ticket.fromJson(json['ticket']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['customer_id'] = customerId;
    data['organization_id'] = organizationId;
    data['event_id'] = eventId;
    data['ticket_id'] = ticketId;
    data['coupon_id'] = couponId;
    data['quantity'] = quantity;
    data['coupon_discount'] = couponDiscount;
    data['tax'] = tax;
    data['org_commission'] = orgCommission;
    data['payment'] = payment;
    data['payment_type'] = paymentType;
    data['payment_status'] = paymentStatus;
    data['payment_token'] = paymentToken;
    data['order_status'] = orderStatus;
    data['org_pay_status'] = orgPayStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (orderChild != null) {
      data['order_child'] = orderChild!.map((v) => v.toJson()).toList();
    }
    if (review != null) {
      data['review'] = review!.toJson();
    }
    if (event != null) {
      data['event'] = event!.toJson();
    }
    if (ticket != null) {
      data['ticket'] = ticket!.toJson();
    }
    return data;
  }
}
