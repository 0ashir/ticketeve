class FavoriteModel {
  FavoriteModel({
    dynamic msg,
    List<FavoriteData>? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  FavoriteModel.fromJson(dynamic json) {
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FavoriteData.fromJson(v));
      });
    }
    _success = json['success'];
  }

  dynamic _msg;
  List<FavoriteData>? _data;
  bool? _success;

  FavoriteModel copyWith({
    dynamic msg,
    List<FavoriteData>? data,
    bool? success,
  }) =>
      FavoriteModel(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  dynamic get msg => _msg;

  List<FavoriteData>? get data => _data;

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

class FavoriteData {
  FavoriteData({
    int? id,
    String? name,
    String? type,
    int? userId,
    String? scannerId,
    String? address,
    int? categoryId,
    String? startTime,
    String? endTime,
    String? image,
    dynamic gallery,
    int? people,
    String? lat,
    String? lang,
    String? description,
    int? security,
    dynamic tags,
    int? status,
    String? eventStatus,
    int? isDeleted,
    String? createdAt,
    String? updatedAt,
    String? time,
    String? imagePath,
    int? rate,
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
    _time = time;
    _imagePath = imagePath;
    _rate = rate;
    _totalTickets = totalTickets;
    _soldTickets = soldTickets;
  }

  
  FavoriteData.fromJson(dynamic json) {
    _id = _parseInt(json['id']);
    _name = json['name'];
    _type = json['type'];
    _userId = _parseInt(json['user_id']);
    _scannerId = json['scanner_id']?.toString();
    _address = json['address'];
    _categoryId = _parseInt(json['category_id']);
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _image = json['image'];
    _gallery = json['gallery'];
    _people = _parseInt(json['people']);
    _lat = json['lat']?.toString();
    _lang = json['lang']?.toString();
    _description = json['description'];
    _security = _parseInt(json['security']);
    _tags = json['tags'];
    _status = _parseInt(json['status']);
    _eventStatus = json['event_status'];
    _isDeleted = _parseInt(json['is_deleted']);
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _time = json['time'];
    _imagePath = json['imagePath'];
    _rate = _parseInt(json['rate']);
    _totalTickets = json['totalTickets'];
    _soldTickets = json['soldTickets'];
  }

  /// Helper function to safely parse integers
  int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
  int? _id;
  String? _name;
  String? _type;
  int? _userId;
  String? _scannerId;
  String? _address;
  int? _categoryId;
  String? _startTime;
  String? _endTime;
  String? _image;
  dynamic _gallery;
  int? _people;
  String? _lat;
  String? _lang;
  String? _description;
  int? _security;
  dynamic _tags;
  int? _status;
  String? _eventStatus;
  int? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  String? _time;
  String? _imagePath;
  int? _rate;
  dynamic _totalTickets;
  dynamic _soldTickets;

  FavoriteData copyWith({
    int? id,
    String? name,
    String? type,
    int? userId,
    String? scannerId,
    String? address,
    int? categoryId,
    String? startTime,
    String? endTime,
    String? image,
    dynamic gallery,
    int? people,
    String? lat,
    String? lang,
    String? description,
    int? security,
    dynamic tags,
    int? status,
    String? eventStatus,
    int? isDeleted,
    String? createdAt,
    String? updatedAt,
    String? time,
    String? imagePath,
    int? rate,
    dynamic totalTickets,
    dynamic soldTickets,
  }) =>
      FavoriteData(
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
        time: time ?? _time,
        imagePath: imagePath ?? _imagePath,
        rate: rate ?? _rate,
        totalTickets: totalTickets ?? _totalTickets,
        soldTickets: soldTickets ?? _soldTickets,
      );

  int? get id => _id;

  String? get name => _name;

  String? get type => _type;

  int? get userId => _userId;

  String? get scannerId => _scannerId;

  String? get address => _address;

  int? get categoryId => _categoryId;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  String? get image => _image;

  dynamic get gallery => _gallery;

  int? get people => _people;

  String? get lat => _lat;

  String? get lang => _lang;

  String? get description => _description;

  int? get security => _security;

  dynamic get tags => _tags;

  int? get status => _status;

  String? get eventStatus => _eventStatus;

  int? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get time => _time;

  String? get imagePath => _imagePath;

  int? get rate => _rate;

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
    map['time'] = _time;
    map['imagePath'] = _imagePath;
    map['rate'] = _rate;
    map['totalTickets'] = _totalTickets;
    map['soldTickets'] = _soldTickets;
    return map;
  }
}
