class SingleOrderDetailsModel {
  SingleOrderDetailsModel({
    bool? success,
    dynamic msg,
    Data? data,
  }) {
    _success = success;
    _msg = msg;
    _data = data;
  }

  SingleOrderDetailsModel.fromJson(dynamic json) {
    _success = json['success'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _success;
  dynamic _msg;
  Data? _data;

  SingleOrderDetailsModel copyWith({
    bool? success,
    dynamic msg,
    Data? data,
  }) =>
      SingleOrderDetailsModel(
        success: success ?? _success,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  bool? get success => _success;

  dynamic get msg => _msg;

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
    String? orderId,
    num? customerId,
    num? organizationId,
    num? eventId,
    num? ticketId,
    dynamic couponId,
    num? quantity,
    num? couponDiscount,
    num? tax,
    num? orgCommission,
    num? payment,
    String? paymentType,
    num? paymentStatus,
    dynamic paymentToken,
    String? orderStatus,
    num? orgPayStatus,
    String? createdAt,
    String? updatedAt,
    List<Tickets>? orderChild,
    Review? review,
    Event? event,
    Ticket? ticket,
    Organization? organization,
  }) {
    _id = id;
    _orderId = orderId;
    _customerId = customerId;
    _organizationId = organizationId;
    _eventId = eventId;
    _ticketId = ticketId;
    _couponId = couponId;
    _quantity = quantity;
    _couponDiscount = couponDiscount;
    _tax = tax;
    _orgCommission = orgCommission;
    _payment = payment;
    _paymentType = paymentType;
    _paymentStatus = paymentStatus;
    _paymentToken = paymentToken;
    _orderStatus = orderStatus;
    _orgPayStatus = orgPayStatus;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _orderChild = orderChild;
    _review = review;
    _event = event;
    _ticket = ticket;
    _organization = organization;
  }

  Data.fromJson(dynamic json) {
  _id = json['id'] is num ? json['id'] : num.tryParse(json['id'].toString()) ?? 0;
  _orderId = json['order_id']?.toString() ?? '';
  _customerId = json['customer_id'] is num ? json['customer_id'] : num.tryParse(json['customer_id'].toString()) ?? 0;
  _organizationId = json['organization_id'] is num ? json['organization_id'] : num.tryParse(json['organization_id'].toString()) ?? 0;
  _eventId = json['event_id'] is num ? json['event_id'] : num.tryParse(json['event_id'].toString()) ?? 0;
  _ticketId = json['ticket_id'] is num ? json['ticket_id'] : num.tryParse(json['ticket_id'].toString()) ?? 0;
  
  _couponId = json['coupon_id'] ?? '';
  _quantity = json['quantity'] is num ? json['quantity'] : num.tryParse(json['quantity'].toString()) ?? 0;
  _couponDiscount = json['coupon_discount'] is num ? json['coupon_discount'] : num.tryParse(json['coupon_discount'].toString()) ?? 0;
  _tax = json['tax'] is num ? json['tax'] : num.tryParse(json['tax'].toString()) ?? 0;
  _orgCommission = json['org_commission'] is num ? json['org_commission'] : num.tryParse(json['org_commission'].toString()) ?? 0;
  _payment = json['payment'] is num ? json['payment'] : num.tryParse(json['payment'].toString()) ?? 0;
  _paymentType = json['payment_type']?.toString() ?? '';
  _paymentStatus = json['payment_status'] is num ? json['payment_status'] : num.tryParse(json['payment_status'].toString()) ?? 0;
  _paymentToken = json['payment_token'] ?? '';
  _orderStatus = json['order_status']?.toString() ?? '';
  _orgPayStatus = json['org_pay_status'] is num ? json['org_pay_status'] : num.tryParse(json['org_pay_status'].toString()) ?? 0;
  _createdAt = json['created_at']?.toString() ?? '';
  _updatedAt = json['updated_at']?.toString() ?? '';

  if (json['order_child'] != null) {
    _orderChild = [];
    json['order_child'].forEach((v) {
      _orderChild?.add(Tickets.fromJson(v));
    });
  }

  _review = json['review'] != null ? Review.fromJson(json['review']) : null;
  _event = json['event'] != null ? Event.fromJson(json['event']) : null;
  _ticket = json['ticket'] != null ? Ticket.fromJson(json['ticket']) : null;
  _organization = json['organization'] != null ? Organization.fromJson(json['organization']) : null;
}


  num? _id;
  String? _orderId;
  num? _customerId;
  num? _organizationId;
  num? _eventId;
  num? _ticketId;
  dynamic _couponId;
  num? _quantity;
  num? _couponDiscount;
  num? _tax;
  num? _orgCommission;
  num? _payment;
  String? _paymentType;
  num? _paymentStatus;
  dynamic _paymentToken;
  String? _orderStatus;
  num? _orgPayStatus;
  String? _createdAt;
  String? _updatedAt;
  List<Tickets>? _orderChild;
  Review? _review;
  Event? _event;
  Ticket? _ticket;
  Organization? _organization;

  Data copyWith({
    num? id,
    String? orderId,
    num? customerId,
    num? organizationId,
    num? eventId,
    num? ticketId,
    dynamic couponId,
    num? quantity,
    num? couponDiscount,
    num? tax,
    num? orgCommission,
    num? payment,
    String? paymentType,
    num? paymentStatus,
    dynamic paymentToken,
    String? orderStatus,
    num? orgPayStatus,
    String? createdAt,
    String? updatedAt,
    List<Tickets>? orderChild,
    Review? review,
    Event? event,
    Ticket? ticket,
    Organization? organization,
  }) =>
      Data(
        id: id ?? _id,
        orderId: orderId ?? _orderId,
        customerId: customerId ?? _customerId,
        organizationId: organizationId ?? _organizationId,
        eventId: eventId ?? _eventId,
        ticketId: ticketId ?? _ticketId,
        couponId: couponId ?? _couponId,
        quantity: quantity ?? _quantity,
        couponDiscount: couponDiscount ?? _couponDiscount,
        tax: tax ?? _tax,
        orgCommission: orgCommission ?? _orgCommission,
        payment: payment ?? _payment,
        paymentType: paymentType ?? _paymentType,
        paymentStatus: paymentStatus ?? _paymentStatus,
        paymentToken: paymentToken ?? _paymentToken,
        orderStatus: orderStatus ?? _orderStatus,
        orgPayStatus: orgPayStatus ?? _orgPayStatus,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        orderChild: orderChild ?? _orderChild,
        review: review ?? _review,
        event: event ?? _event,
        ticket: ticket ?? _ticket,
        organization: organization ?? _organization,
      );

  num? get id => _id;

  String? get orderId => _orderId;

  num? get customerId => _customerId;

  num? get organizationId => _organizationId;

  num? get eventId => _eventId;

  num? get ticketId => _ticketId;

  dynamic get couponId => _couponId;

  num? get quantity => _quantity;

  num? get couponDiscount => _couponDiscount;

  num? get tax => _tax;

  num? get orgCommission => _orgCommission;

  num? get payment => _payment;

  String? get paymentType => _paymentType;

  num? get paymentStatus => _paymentStatus;

  dynamic get paymentToken => _paymentToken;

  String? get orderStatus => _orderStatus;

  num? get orgPayStatus => _orgPayStatus;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<Tickets>? get orderChild => _orderChild;

  Review? get review => _review;

  Event? get event => _event;

  Ticket? get ticket => _ticket;

  Organization? get organization => _organization;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['order_id'] = _orderId;
    map['customer_id'] = _customerId;
    map['organization_id'] = _organizationId;
    map['event_id'] = _eventId;
    map['ticket_id'] = _ticketId;
    map['coupon_id'] = _couponId;
    map['quantity'] = _quantity;
    map['coupon_discount'] = _couponDiscount;
    map['tax'] = _tax;
    map['org_commission'] = _orgCommission;
    map['payment'] = _payment;
    map['payment_type'] = _paymentType;
    map['payment_status'] = _paymentStatus;
    map['payment_token'] = _paymentToken;
    map['order_status'] = _orderStatus;
    map['org_pay_status'] = _orgPayStatus;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_orderChild != null) {
      map['order_child'] = _orderChild?.map((v) => v.toJson()).toList();
    }
    if (_review != null) {
      map['review'] = _review?.toJson();
    }
    if (_event != null) {
      map['event'] = _event?.toJson();
    }
    if (_ticket != null) {
      map['ticket'] = _ticket?.toJson();
    }
    if (_organization != null) {
      map['organization'] = _organization?.toJson();
    }
    return map;
  }
}

class Organization {
  Organization({
    num? id,
    String? name,
    String? firstName,
    String? lastName,
    String? email,
    dynamic emailVerifiedAt,
    String? deviceToken,
    String? image,
    String? phone,
    String? bio,
    dynamic country,
    dynamic orgId,
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

  Organization.fromJson(dynamic json) {
  _id = json['id'] is num ? json['id'] : num.tryParse(json['id']?.toString() ?? '') ?? 0;
  _name = json['name'] ?? '';
  _firstName = json['first_name'] ?? '';
  _lastName = json['last_name'] ?? '';
  _email = json['email'] ?? '';
  _emailVerifiedAt = json['email_verified_at'] ?? '';
  _deviceToken = json['device_token'] ?? '';
  _image = json['image'] ?? '';
  _phone = json['phone'] ?? '';
  _bio = json['bio'] ?? '';
  _country = json['country'] ?? '';
  _orgId = json['org_id'] ?? '';
  _status = json['status'] is num ? json['status'] : num.tryParse(json['status']?.toString() ?? '') ?? 0;
  _language = json['language'] ?? '';
  _createdAt = json['created_at'] ?? '';
  _updatedAt = json['updated_at'] ?? '';
  _followers = json['followers'] != null
      ? List<num>.from(json['followers'].map((x) => x is num ? x : num.tryParse(x?.toString() ?? '') ?? 0))
      : [];
  _imagePath = json['imagePath'] ?? '';
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
  String? _bio;
  dynamic _country;
  dynamic _orgId;
  num? _status;
  String? _language;
  String? _createdAt;
  String? _updatedAt;
  List<num>? _followers;
  String? _imagePath;

  Organization copyWith({
    num? id,
    String? name,
    String? firstName,
    String? lastName,
    String? email,
    dynamic emailVerifiedAt,
    String? deviceToken,
    String? image,
    String? phone,
    String? bio,
    dynamic country,
    dynamic orgId,
    num? status,
    String? language,
    String? createdAt,
    String? updatedAt,
    List<num>? followers,
    String? imagePath,
  }) =>
      Organization(
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

  num? get id => _id;

  String? get name => _name;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get email => _email;

  dynamic get emailVerifiedAt => _emailVerifiedAt;

  String? get deviceToken => _deviceToken;

  String? get image => _image;

  String? get phone => _phone;

  String? get bio => _bio;

  dynamic get country => _country;

  dynamic get orgId => _orgId;

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

class Ticket {
  Ticket({
    num? id,
    num? eventId,
    num? userId,
    String? ticketNumber,
    String? name,
    String? type,
    num? quantity,
    num? ticketPerOrder,
    String? startTime,
    String? endTime,
    num? price,
    String? description,
    num? status,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _eventId = eventId;
    _userId = userId;
    _ticketNumber = ticketNumber;
    _name = name;
    _type = type;
    _quantity = quantity;
    _ticketPerOrder = ticketPerOrder;
    _startTime = startTime;
    _endTime = endTime;
    _price = price;
    _description = description;
    _status = status;
    _isDeleted = isDeleted;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }
Ticket.fromJson(dynamic json) {
  _id = json['id'] is num ? json['id'] : num.tryParse(json['id']?.toString() ?? '') ?? 0;
  _eventId = json['event_id'] is num ? json['event_id'] : num.tryParse(json['event_id']?.toString() ?? '') ?? 0;
  _userId = json['user_id'] is num ? json['user_id'] : num.tryParse(json['user_id']?.toString() ?? '') ?? 0;
  _ticketNumber = json['ticket_number'] ?? '';
  _name = json['name'] ?? '';
  _type = json['type'] ?? '';
  _quantity = json['quantity'] is num ? json['quantity'] : num.tryParse(json['quantity']?.toString() ?? '') ?? 0;
  _ticketPerOrder = json['ticket_per_order'] is num ? json['ticket_per_order'] : num.tryParse(json['ticket_per_order']?.toString() ?? '') ?? 0;
  _startTime = json['start_time'] ?? '';
  _endTime = json['end_time'] ?? '';
  _price = json['price'] is num ? json['price'] : num.tryParse(json['price']?.toString() ?? '') ?? 0;
  _description = json['description'] ?? '';
  _status = json['status'] is num ? json['status'] : num.tryParse(json['status']?.toString() ?? '') ?? 0;
  _isDeleted = json['is_deleted'] is num ? json['is_deleted'] : num.tryParse(json['is_deleted']?.toString() ?? '') ?? 0;
  _createdAt = json['created_at'] ?? '';
  _updatedAt = json['updated_at'] ?? '';

}

  num? _id;
  num? _eventId;
  num? _userId;
  String? _ticketNumber;
  String? _name;
  String? _type;
  num? _quantity;
  num? _ticketPerOrder;
  String? _startTime;
  String? _endTime;
  num? _price;
  String? _description;
  num? _status;
  num? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  Ticket copyWith({
    num? id,
    num? eventId,
    num? userId,
    String? ticketNumber,
    String? name,
    String? type,
    num? quantity,
    num? ticketPerOrder,
    String? startTime,
    String? endTime,
    num? price,
    String? description,
    num? status,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) =>
      Ticket(
        id: id ?? _id,
        eventId: eventId ?? _eventId,
        userId: userId ?? _userId,
        ticketNumber: ticketNumber ?? _ticketNumber,
        name: name ?? _name,
        type: type ?? _type,
        quantity: quantity ?? _quantity,
        ticketPerOrder: ticketPerOrder ?? _ticketPerOrder,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        price: price ?? _price,
        description: description ?? _description,
        status: status ?? _status,
        isDeleted: isDeleted ?? _isDeleted,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get eventId => _eventId;

  num? get userId => _userId;

  String? get ticketNumber => _ticketNumber;

  String? get name => _name;

  String? get type => _type;

  num? get quantity => _quantity;

  num? get ticketPerOrder => _ticketPerOrder;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  num? get price => _price;

  String? get description => _description;

  num? get status => _status;

  num? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['event_id'] = _eventId;
    map['user_id'] = _userId;
    map['ticket_number'] = _ticketNumber;
    map['name'] = _name;
    map['type'] = _type;
    map['quantity'] = _quantity;
    map['ticket_per_order'] = _ticketPerOrder;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['price'] = _price;
    map['description'] = _description;
    map['status'] = _status;
    map['is_deleted'] = _isDeleted;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Event {
  Event({
    num? id,
    String? name,
    String? type,
    num? userId,
    String? scannerId,
    dynamic address,
    num? categoryId,
    String? startTime,
    String? endTime,
    String? image,
    String? gallery,
    num? people,
    dynamic lat,
    dynamic lang,
    String? description,
    num? security,
    String? tags,
    num? status,
    String? eventStatus,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
    num? rate,
    dynamic totalTickets,
    dynamic soldTickets,
  }) {
    _id = id;
    _name = name;
    _type = type;
    _userId = userId;
    _scannerId = scannerId;
    _address = address;
    _categoryId = categoryId;
    _startTime = startTime;
    _endTime = endTime;
    _image = image;
    _gallery = gallery;
    _people = people;
    _lat = lat;
    _lang = lang;
    _description = description;
    _security = security;
    _tags = tags;
    _status = status;
    _eventStatus = eventStatus;
    _isDeleted = isDeleted;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imagePath = imagePath;
    _rate = rate;
    _totalTickets = totalTickets;
    _soldTickets = soldTickets;
  }
Event.fromJson(dynamic json) {
  _id = json['id'] is num ? json['id'] : num.tryParse(json['id']?.toString() ?? '') ?? 0;
  _name = json['name'] ?? '';
  _type = json['type'] ?? '';
  _userId = json['user_id'] is num ? json['user_id'] : num.tryParse(json['user_id']?.toString() ?? '') ?? 0;
  _scannerId = json['scanner_id'] ?? '';
  _address = json['address'] ?? '';
  _categoryId = json['category_id'] is num ? json['category_id'] : num.tryParse(json['category_id']?.toString() ?? '') ?? 0;
  _startTime = json['start_time'] ?? '';
  _endTime = json['end_time'] ?? '';
  _image = json['image'] ?? '';
  _gallery = json['gallery'] ?? '';
  _people = json['people'] is num ? json['people'] : num.tryParse(json['people']?.toString() ?? '') ?? 0;
  _lat = json['lat'] ?? 0.0;
  _lang = json['lang'] ?? '';
  _description = json['description'] ?? '';
  _security = json['security'] is num ? json['security'] : num.tryParse(json['security']?.toString() ?? '') ?? 0;
  _tags = json['tags'] ?? '';
  _status = json['status'] is num ? json['status'] : num.tryParse(json['status']?.toString() ?? '') ?? 0;
  _eventStatus = json['event_status'] ?? '';
  _isDeleted = json['is_deleted'] is num ? json['is_deleted'] : num.tryParse(json['is_deleted']?.toString() ?? '') ?? 0;
  _createdAt = json['created_at'] ?? '';
  _updatedAt = json['updated_at'] ?? '';
  _imagePath = json['imagePath'] ?? '';
  _rate = json['rate'] is num ? json['rate'] : num.tryParse(json['rate']?.toString() ?? '') ?? 0;
  _totalTickets = json['totalTickets'] ?? 0;
  _soldTickets = json['soldTickets'] ?? 0;
}

  num? _id;
  String? _name;
  String? _type;
  num? _userId;
  String? _scannerId;
  dynamic _address;
  num? _categoryId;
  String? _startTime;
  String? _endTime;
  String? _image;
  String? _gallery;
  num? _people;
  dynamic _lat;
  dynamic _lang;
  String? _description;
  num? _security;
  String? _tags;
  num? _status;
  String? _eventStatus;
  num? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  String? _imagePath;
  num? _rate;
  dynamic _totalTickets;
  dynamic _soldTickets;

  Event copyWith({
    num? id,
    String? name,
    String? type,
    num? userId,
    String? scannerId,
    dynamic address,
    num? categoryId,
    String? startTime,
    String? endTime,
    String? image,
    String? gallery,
    num? people,
    dynamic lat,
    dynamic lang,
    String? description,
    num? security,
    String? tags,
    num? status,
    String? eventStatus,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
    num? rate,
    dynamic totalTickets,
    dynamic soldTickets,
  }) =>
      Event(
        id: id ?? _id,
        name: name ?? _name,
        type: type ?? _type,
        userId: userId ?? _userId,
        scannerId: scannerId ?? _scannerId,
        address: address ?? _address,
        categoryId: categoryId ?? _categoryId,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        image: image ?? _image,
        gallery: gallery ?? _gallery,
        people: people ?? _people,
        lat: lat ?? _lat,
        lang: lang ?? _lang,
        description: description ?? _description,
        security: security ?? _security,
        tags: tags ?? _tags,
        status: status ?? _status,
        eventStatus: eventStatus ?? _eventStatus,
        isDeleted: isDeleted ?? _isDeleted,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        imagePath: imagePath ?? _imagePath,
        rate: rate ?? _rate,
        totalTickets: totalTickets ?? _totalTickets,
        soldTickets: soldTickets ?? _soldTickets,
      );

  num? get id => _id;

  String? get name => _name;

  String? get type => _type;

  num? get userId => _userId;

  String? get scannerId => _scannerId;

  dynamic get address => _address;

  num? get categoryId => _categoryId;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  String? get image => _image;

  String? get gallery => _gallery;

  num? get people => _people;

  dynamic get lat => _lat;

  dynamic get lang => _lang;

  String? get description => _description;

  num? get security => _security;

  String? get tags => _tags;

  num? get status => _status;

  String? get eventStatus => _eventStatus;

  num? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get imagePath => _imagePath;

  num? get rate => _rate;

  dynamic get totalTickets => _totalTickets;

  dynamic get soldTickets => _soldTickets;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['type'] = _type;
    map['user_id'] = _userId;
    map['scanner_id'] = _scannerId;
    map['address'] = _address;
    map['category_id'] = _categoryId;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['image'] = _image;
    map['gallery'] = _gallery;
    map['people'] = _people;
    map['lat'] = _lat;
    map['lang'] = _lang;
    map['description'] = _description;
    map['security'] = _security;
    map['tags'] = _tags;
    map['status'] = _status;
    map['event_status'] = _eventStatus;
    map['is_deleted'] = _isDeleted;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['imagePath'] = _imagePath;
    map['rate'] = _rate;
    map['totalTickets'] = _totalTickets;
    map['soldTickets'] = _soldTickets;
    return map;
  }
}

class Review {
  Review({
    num? id,
    num? userId,
    num? organizationId,
    num? orderId,
    num? eventId,
    String? message,
    num? rate,
    num? status,
    String? createdAt,
    String? updatedAt,
    User? user,
    Event? event,
  }) {
    _id = id;
    _userId = userId;
    _organizationId = organizationId;
    _orderId = orderId;
    _eventId = eventId;
    _message = message;
    _rate = rate;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
    _event = event;
  }
Review.fromJson(dynamic json) {
  _id = json['id'] is num ? json['id'] : num.tryParse(json['id']?.toString() ?? '') ?? 0;
  _userId = json['user_id'] is num ? json['user_id'] : num.tryParse(json['user_id']?.toString() ?? '') ?? 0;
  _organizationId = json['organization_id'] is num ? json['organization_id'] : num.tryParse(json['organization_id']?.toString() ?? '') ?? 0;
  _orderId = json['order_id'] is num ? json['order_id'] : num.tryParse(json['order_id']?.toString() ?? '') ?? 0;
  _eventId = json['event_id'] is num ? json['event_id'] : num.tryParse(json['event_id']?.toString() ?? '') ?? 0;
  _message = json['message'] ?? '';
  _rate = json['rate'] is num ? json['rate'] : num.tryParse(json['rate']?.toString() ?? '') ?? 0;
  _status = json['status'] is num ? json['status'] : num.tryParse(json['status']?.toString() ?? '') ?? 0;
  _createdAt = json['created_at'] ?? '';
  _updatedAt = json['updated_at'] ?? '';

  _user = json['user'] != null ? User.fromJson(json['user']) : null;
  _event = json['event'] != null ? Event.fromJson(json['event']) : null;
}




  num? _id;
  num? _userId;
  num? _organizationId;
  num? _orderId;
  num? _eventId;
  String? _message;
  num? _rate;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  User? _user;
  Event? _event;

  Review copyWith({
    num? id,
    num? userId,
    num? organizationId,
    num? orderId,
    num? eventId,
    String? message,
    num? rate,
    num? status,
    String? createdAt,
    String? updatedAt,
    User? user,
    Event? event,
  }) =>
      Review(
        id: id ?? _id,
        userId: userId ?? _userId,
        organizationId: organizationId ?? _organizationId,
        orderId: orderId ?? _orderId,
        eventId: eventId ?? _eventId,
        message: message ?? _message,
        rate: rate ?? _rate,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        user: user ?? _user,
        event: event ?? _event,
      );

  num? get id => _id;

  num? get userId => _userId;

  num? get organizationId => _organizationId;

  num? get orderId => _orderId;

  num? get eventId => _eventId;

  String? get message => _message;

  num? get rate => _rate;

  num? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  User? get user => _user;

  Event? get event => _event;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['organization_id'] = _organizationId;
    map['order_id'] = _orderId;
    map['event_id'] = _eventId;
    map['message'] = _message;
    map['rate'] = _rate;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_event != null) {
      map['event'] = _event?.toJson();
    }
    return map;
  }
}

class User {
  User({
    num? id,
    String? name,
    String? lastName,
    String? image,
    String? email,
  }) {
    _id = id;
    _name = name;
    _lastName = lastName;
    _image = image;
    _email = email;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _lastName = json['last_name'];
    _image = json['image'];
    _email = json['email'];
  }

  num? _id;
  String? _name;
  String? _lastName;
  String? _image;
  String? _email;

  User copyWith({
    num? id,
    String? name,
    String? lastName,
    String? image,
    String? email,
  }) =>
      User(
        id: id ?? _id,
        name: name ?? _name,
        lastName: lastName ?? _lastName,
        image: image ?? _image,
        email: email ?? _email,
      );

  num? get id => _id;

  String? get name => _name;

  String? get lastName => _lastName;

  String? get image => _image;

  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['last_name'] = _lastName;
    map['image'] = _image;
    map['email'] = _email;
    return map;
  }
}

class Tickets {
  Tickets({
    num? id,
    num? ticketId,
    num? orderId,
    num? customerId,
    String? ticketNumber,
    num? status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _ticketId = ticketId;
    _orderId = orderId;
    _customerId = customerId;
    _ticketNumber = ticketNumber;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Tickets.fromJson(dynamic json) {
    _id = json['id'] is num ? json['id'] : num.tryParse(json['id'].toString());
    _ticketId = json['ticket_id'] is num
        ? json['ticket_id']
        : num.tryParse(json['ticket_id'].toString());
    _orderId = json['order_id'] is num
        ? json['order_id']
        : num.tryParse(json['order_id'].toString());
    _customerId = json['customer_id'] is num
        ? json['customer_id']
        : num.tryParse(json['customer_id'].toString());

    _ticketNumber = json['ticket_number']?.toString();

    _status = json['status'] is num
        ? json['status']
        : num.tryParse(json['status'].toString());

    _createdAt = json['created_at']?.toString();
    _updatedAt = json['updated_at']?.toString();
  }

  num? _id;
  num? _ticketId;
  num? _orderId;
  num? _customerId;
  String? _ticketNumber;
  num? _status;
  String? _createdAt;
  String? _updatedAt;

  Tickets copyWith({
    num? id,
    num? ticketId,
    num? orderId,
    num? customerId,
    String? ticketNumber,
    num? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      Tickets(
        id: id ?? _id,
        ticketId: ticketId ?? _ticketId,
        orderId: orderId ?? _orderId,
        customerId: customerId ?? _customerId,
        ticketNumber: ticketNumber ?? _ticketNumber,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get ticketId => _ticketId;

  num? get orderId => _orderId;

  num? get customerId => _customerId;

  String? get ticketNumber => _ticketNumber;

  num? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ticket_id'] = _ticketId;
    map['order_id'] = _orderId;
    map['customer_id'] = _customerId;
    map['ticket_number'] = _ticketNumber;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
