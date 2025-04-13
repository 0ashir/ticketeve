import 'package:eventright_organizer/model/enums.dart';

class EventDetailsModel {
  EventDetailsModel({
    Data? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  EventDetailsModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  Data? _data;
  bool? _success;

  EventDetailsModel copyWith({
    Data? data,
    bool? success,
  }) =>
      EventDetailsModel(
        data: data ?? _data,
        success: success ?? _success,
      );

  Data? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    return map;
  }
}

class Data {
  Data({
    num? id,
    String? name,
    EventTypes? type,
    num? userId,
    String? scannerId,
    String? address,
    num? categoryId,
    String? startTime,
    String? endTime,
    String? image,
    List<String>? gallery,
    num? people,
    String? lat,
    String? lang,
    String? description,
    num? security,
    List<String>? tags,
    num? status,
    String? eventStatus,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
    num? rate,
    dynamic totalTickets,
    dynamic soldTickets,
    Category? category,
    String? url,
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
    _category = category;
    _url = url;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _type = getEventTypesFromString(json['type']);
    _userId = num.tryParse(json['user_id']);
    _scannerId = json['scanner_id'];
    _address = json['address'];

    _categoryId = num.tryParse(json['category_id']);
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _image = json['image'];
    _gallery = json['gallery'].cast<String>() ?? [];

    _people = num.tryParse(json['people']);
    _lat = json['lat'];
    _lang = json['lang'];
    _description = json['description'];
    _security = num.tryParse(json['security']);
    _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    _status = num.tryParse(json['status']);
    _eventStatus = json['event_status'];
    _isDeleted = num.tryParse(json['is_deleted']);
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imagePath = json['imagePath'];
    _rate = num.tryParse(json['rate'].toString());

    _totalTickets = json['totalTickets'];
    _soldTickets = json['soldTickets'];
    _category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    _url = json['url'];
    
  }

  num? _id;
  String? _name;
  EventTypes? _type;
  num? _userId;
  String? _scannerId;
  String? _address;
  num? _categoryId;
  String? _startTime;
  String? _endTime;
  String? _image;
  List<String>? _gallery;
  num? _people;
  String? _lat;
  String? _lang;
  String? _description;
  num? _security;
  List<String>? _tags;
  num? _status;
  String? _eventStatus;
  num? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  String? _imagePath;
  num? _rate;
  dynamic _totalTickets;
  dynamic _soldTickets;
  Category? _category;
  String? _url;

  Data copyWith({
    num? id,
    String? name,
    EventTypes? type,
    num? userId,
    String? scannerId,
    String? address,
    num? categoryId,
    String? startTime,
    String? endTime,
    String? image,
    List<String>? gallery,
    num? people,
    String? lat,
    String? lang,
    String? description,
    num? security,
    List<String>? tags,
    num? status,
    String? eventStatus,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
    num? rate,
    dynamic totalTickets,
    dynamic soldTickets,
    Category? category,
    String? url,
  }) =>
      Data(
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
        category: category ?? _category,
        url: url ?? _url,
      );

  num? get id => _id;

  String? get name => _name;

  EventTypes? get type => _type;

  num? get userId => _userId;

  String? get scannerId => _scannerId;

  String? get address => _address;

  num? get categoryId => _categoryId;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  String? get image => _image;

  List<String>? get gallery => _gallery;

  num? get people => _people;

  String? get lat => _lat;

  String? get lang => _lang;

  String? get description => _description;

  num? get security => _security;

  List<String>? get tags => _tags;

  num? get status => _status;

  String? get eventStatus => _eventStatus;

  num? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get imagePath => _imagePath;

  num? get rate => _rate;

  dynamic get totalTickets => _totalTickets;

  dynamic get soldTickets => _soldTickets;

  Category? get category => _category;
  String? get url => _url;
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
    map['imagePath'] = _imagePath;
    map['rate'] = _rate;
    map['totalTickets'] = _totalTickets;
    map['soldTickets'] = _soldTickets;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    map['url'] = _url;
    return map;
  }
}

class Category {
  Category({
    num? id,
    String? name,
    String? imagePath,
  }) {
    _id = id;
    _name = name;
    _imagePath = imagePath;
  }

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imagePath = json['imagePath'];
  }

  num? _id;
  String? _name;
  String? _imagePath;

  Category copyWith({
    num? id,
    String? name,
    String? imagePath,
  }) =>
      Category(
        id: id ?? _id,
        name: name ?? _name,
        imagePath: imagePath ?? _imagePath,
      );

  num? get id => _id;

  String? get name => _name;

  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['imagePath'] = _imagePath;
    return map;
  }
}
