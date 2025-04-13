class SearchEventModel {
  SearchEventModel({
    bool? success,
    dynamic msg,
    List<SearchData>? data,
  }) {
    _success = success;
    _msg = msg;
    _data = data;
  }

  SearchEventModel.fromJson(dynamic json) {
    _success = json['success'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SearchData.fromJson(v));
      });
    }
  }

  bool? _success;
  dynamic _msg;
  List<SearchData>? _data;

  SearchEventModel copyWith({
    bool? success,
    dynamic msg,
    List<SearchData>? data,
  }) =>
      SearchEventModel(
        success: success ?? _success,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  bool? get success => _success;

  dynamic get msg => _msg;

  List<SearchData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SearchData {
  SearchData({
    num? id,
    String? name,
    String? type,
    num? userId,
    String? scannerId,
    String? address,
    num? categoryId,
    String? startTime,
    String? endTime,
    String? image,
    String? gallery,
    num? people,
    String? lat,
    String? lang,
    String? description,
    num? security,
    String? tags,
    num? status,
    String? eventStatus,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
    String? time,
    bool? isLike,
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
    _time = time;
    _isLike = isLike;
    _imagePath = imagePath;
    _rate = rate;
    _totalTickets = totalTickets;
    _soldTickets = soldTickets;
  }

 
  SearchData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _type = json['type'];
    _userId = json['user_id'];
    _scannerId = json['scanner_id'];
    _address = json['address'];
    _categoryId = json['category_id'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _image = json['image'];
    _gallery = json['gallery'];
    _people = json['people'];
    _lat = json['lat'];
    _lang = json['lang'];
    _description = json['description'];
    _security = json['security'];
    _tags = json['tags'];
    _status = json['status'];
    _eventStatus = json['event_status'];
    _isDeleted = json['is_deleted'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _time = json['time'];
    _isLike = json['isLike'];
    _imagePath = json['imagePath'];
    _rate = json['rate'];
    _totalTickets = json['totalTickets'];
    _soldTickets = json['soldTickets'];
  }
  num? _id;
  String? _name;
  String? _type;
  num? _userId;
  String? _scannerId;
  String? _address;
  num? _categoryId;
  String? _startTime;
  String? _endTime;
  String? _image;
  String? _gallery;
  num? _people;
  String? _lat;
  String? _lang;
  String? _description;
  num? _security;
  String? _tags;
  num? _status;
  String? _eventStatus;
  num? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  String? _time;
  bool? _isLike;
  String? _imagePath;
  num? _rate;
  dynamic _totalTickets;
  dynamic _soldTickets;

  SearchData copyWith({
    num? id,
    String? name,
    String? type,
    num? userId,
    String? scannerId,
    String? address,
    num? categoryId,
    String? startTime,
    String? endTime,
    String? image,
    String? gallery,
    num? people,
    String? lat,
    String? lang,
    String? description,
    num? security,
    String? tags,
    num? status,
    String? eventStatus,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
    String? time,
    bool? isLike,
    String? imagePath,
    num? rate,
    dynamic totalTickets,
    dynamic soldTickets,
  }) =>
      SearchData(
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
        isLike: isLike ?? _isLike,
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

  String? get address => _address;

  num? get categoryId => _categoryId;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  String? get image => _image;

  String? get gallery => _gallery;

  num? get people => _people;

  String? get lat => _lat;

  String? get lang => _lang;

  String? get description => _description;

  num? get security => _security;

  String? get tags => _tags;

  num? get status => _status;

  String? get eventStatus => _eventStatus;

  num? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get time => _time;

  bool? get isLike => _isLike;

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
    map['time'] = _time;
    map['isLike'] = _isLike;
    map['imagePath'] = _imagePath;
    map['rate'] = _rate;
    map['totalTickets'] = _totalTickets;
    map['soldTickets'] = _soldTickets;
    return map;
  }
}
