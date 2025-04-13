class EventsDetailModel {
  dynamic msg;
  Data? data;
  bool? success;

  EventsDetailModel({this.msg, this.data, this.success});

  EventsDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? type;
  int? userId;
  String? scannerId;
  String? address;
  int? categoryId;
  String? image;
  List<String>? gallery;
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
  List<String>? hasTag;
  List<RecentEvent>? recentEvent;
  String? date;
  String? endDate;
  String? startTime;
  String? endTime;
  bool? isLike;
  bool? soldOut;
  String? imagePath;
  int? rate;
  dynamic totalTickets;
  dynamic soldTickets;
  List<Ticket>? ticket;
  Organization? organization;
  String? shareUrl;

  Data({
    this.id,
    this.name,
    this.type,
    this.userId,
    this.scannerId,
    this.address,
    this.categoryId,
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
    this.hasTag,
    this.recentEvent,
    this.date,
    this.endDate,
    this.startTime,
    this.endTime,
    this.isLike,
    this.soldOut,
    this.imagePath,
    this.rate,
    this.totalTickets,
    this.soldTickets,
    this.ticket,
    this.organization,
    this.shareUrl,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int
        ? json['id']
        : int.tryParse(json['id']?.toString() ?? '');
    name = json['name']?.toString();
    type = json['type']?.toString();
    userId = json['user_id'] is int
        ? json['user_id']
        : int.tryParse(json['user_id']?.toString() ?? '');
    scannerId = json['scanner_id']?.toString();
    address = json['address']?.toString();
    categoryId = json['category_id'] is int
        ? json['category_id']
        : int.tryParse(json['category_id']?.toString() ?? '');
    image = json['image']?.toString();

    gallery = json['gallery'] is List
        ? List<String>.from(json['gallery'].map((e) => e.toString()))
        : [];
    people = json['people'] is int
        ? json['people']
        : int.tryParse(json['people']?.toString() ?? '');

    lat = json['lat']?.toString();
    lang = json['lang']?.toString();
    description = json['description']?.toString();
    security = json['security'] is int
        ? json['security']
        : int.tryParse(json['security']?.toString() ?? '');
    tags = json['tags']?.toString();
    status = json['status'] is int
        ? json['status']
        : int.tryParse(json['status']?.toString() ?? '');
    eventStatus = json['event_status']?.toString();
    isDeleted = json['is_deleted'] is int
        ? json['is_deleted']
        : int.tryParse(json['is_deleted']?.toString() ?? '');
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();

    hasTag = json['hasTag'] is List
        ? List<String>.from(json['hasTag'].map((e) => e.toString()))
        : [];

    if (json['recent_event'] is List) {
      recentEvent = json['recent_event']
          .map<RecentEvent>((v) => RecentEvent.fromJson(v))
          .toList();
    }

    date = json['date']?.toString();
    endDate = json['endDate']?.toString();
    startTime = json['startTime']?.toString();
    endTime = json['endTime']?.toString();
    isLike = json['isLike'] is bool
        ? json['isLike']
        : (json['isLike']?.toString().toLowerCase() == 'true');
    soldOut = json['sold_out'] is bool
        ? json['sold_out']
        : (json['sold_out']?.toString().toLowerCase() == 'true');
    imagePath = json['imagePath']?.toString();
    rate = json['rate'] is int
        ? json['rate']
        : int.tryParse(json['rate']?.toString() ?? '');

    totalTickets = json['totalTickets'];
    soldTickets = json['soldTickets'];

    if (json['ticket'] is List) {
      ticket = json['ticket'].map<Ticket>((v) => Ticket.fromJson(v)).toList();
    }

    organization = json['organization'] != null
        ? Organization.fromJson(json['organization'])
        : null;
    shareUrl = json['share_url']?.toString();
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
    data['hasTag'] = hasTag;
    if (recentEvent != null) {
      data['recent_event'] = recentEvent!.map((v) => v.toJson()).toList();
    }
    data['date'] = date;
    data['endDate'] = endDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['isLike'] = isLike;
    data['sold_out'] = soldOut;
    data['imagePath'] = imagePath;
    data['rate'] = rate;
    data['totalTickets'] = totalTickets;
    data['soldTickets'] = soldTickets;
    data['share_url'] = shareUrl;
    if (ticket != null) {
      data['ticket'] = ticket!.map((v) => v.toJson()).toList();
    }
    if (organization != null) {
      data['organization'] = organization!.toJson();
    }
    return data;
  }
}

class RecentEvent {
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
  dynamic gallery;
  int? people;
  String? lat;
  String? lang;
  String? description;
  int? security;
  dynamic tags;
  int? status;
  String? eventStatus;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? time;
  bool? isLike;
  String? imagePath;
  int? rate;
  dynamic totalTickets;
  dynamic soldTickets;

  RecentEvent(
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
      this.time,
      this.isLike,
      this.imagePath,
      this.rate,
      this.totalTickets,
      this.soldTickets});

  RecentEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    userId = json['user_id'];
    scannerId = json['scanner_id'];
    address = json['address'];
    categoryId = json['category_id'];

    // Converting time fields to proper DateTime if necessary
    startTime = json['start_time'] is String
        ? json['start_time']
        : json['start_time']?.toString();
    endTime = json['end_time'] is String
        ? json['end_time']
        : json['end_time']?.toString();

    image = json['image'];
    gallery = json['gallery'];
    people = json['people'];
    lat = json['lat'];
    lang = json['lang'];
    description = json['description'];
    security = json['security'];

    // If 'tags' is a list, use it directly, if it's a string, parse it, otherwise leave it as is
    if (json['tags'] is List) {
      tags = json['tags'] as List<dynamic>;
    } else if (json['tags'] is String) {
      tags = json['tags']
          .split(','); // Assuming tags are comma-separated if they are a string
    } else {
      tags = json['tags'];
    }

    status = json['status'];
    eventStatus = json['event_status'];
    isDeleted = json['is_deleted'];

    // Handling DateTime parsing for 'createdAt' and 'updatedAt' if they are string
    createdAt = _parseDate(json['created_at']);
    updatedAt = _parseDate(json['updated_at']);

    time = json['time'];

    // Default to false if 'isLike' is missing or null
    isLike = json['isLike'] ?? false;

    imagePath = json['imagePath'];
    rate = json['rate'];

    // Converting totalTickets and soldTickets to int or double as needed
    totalTickets = _convertToIntOrDouble(json['totalTickets']);
    soldTickets = _convertToIntOrDouble(json['soldTickets']);
  }

// Helper method to parse dates (in case the date format is inconsistent)
  String? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is String) return value; // If it's already a string, return it
    return value.toString(); // Otherwise, convert it to a string
  }

// Helper method to handle dynamic conversion of totalTickets and soldTickets
  dynamic _convertToIntOrDouble(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? int.tryParse(value);
    }
    return value;
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
    data['time'] = time;
    data['isLike'] = isLike;
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
    // Parsing fields and handling possible conversions
    id = _parseInt(json['id']);
    eventId = _parseInt(json['event_id']);
    userId = _parseInt(json['user_id']);
    ticketNumber = json['ticket_number']?.toString();
    name = json['name']?.toString();
    type = json['type']?.toString();
    quantity = _parseInt(json['quantity']);
    ticketPerOrder = _parseInt(json['ticket_per_order']);
    startTime = json['start_time']?.toString();
    endTime = json['end_time']?.toString();
    price = _parseNum(json['price']);
    description = json['description']?.toString();
    status = _parseInt(json['status']);
    isDeleted = _parseInt(json['is_deleted']);
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  // Helper function to safely parse integer values
  int? _parseInt(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  // Helper function to safely parse numeric values
  num? _parseNum(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is num) {
      return value;
    }
    if (value is String) {
      return num.tryParse(value);
    }
    return null;
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

class Organization {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  String? email;
  bool? isFollow;
  List<int>? followers;
  String? imagePath;

  Organization(
      {this.id,
      this.firstName,
      this.lastName,
      this.image,
      this.email,
      this.isFollow,
      this.followers,
      this.imagePath});

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    email = json['email'];
    isFollow = json['isFollow'];
    followers = json['followers'].cast<int>();
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['image'] = image;
    data['email'] = email;
    data['isFollow'] = isFollow;
    data['followers'] = followers;
    data['imagePath'] = imagePath;
    return data;
  }
}
