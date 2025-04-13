class EventDetailModel {
  EventDetailModel({
    Data? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  EventDetailModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  Data? _data;
  bool? _success;

  EventDetailModel copyWith({
    Data? data,
    bool? success,
  }) =>
      EventDetailModel(
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
    List<String>? gallery,
    int? people,
    String? lat,
    String? lang,
    String? description,
    int? security,
    String? tags,
    int? status,
    String? eventStatus,
    int? isDeleted,
    int? scanTicket,
    String? imagePath,
    int? rate,
    int? totalTickets,
    int? soldTickets,
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
    _scanTicket = scanTicket;
    _imagePath = imagePath;
    _rate = rate;
    _totalTickets = totalTickets;
    _soldTickets = soldTickets;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _type = json['type'];
    _userId = json['user_id'];
    _scannerId = json['scanner_id'].toString();
    _address = json['address'];
    _categoryId = json['category_id'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _image = json['image'];
    _gallery = json['gallery'] != null ? json['gallery'].cast<String>() : [];
    _people = json['people'];
    _lat = json['lat'];
    _lang = json['lang'];
    _description = json['description'];
    _security = json['security'];
    _tags = json['tags'];
    _status = json['status'];
    _eventStatus = json['event_status'];
    _isDeleted = json['is_deleted'];
    _scanTicket = json['scanTicket'];
    _imagePath = json['imagePath'];
    _rate = json['rate'];
    _totalTickets = json['totalTickets'];
    _soldTickets = json['soldTickets'];
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
  List<String>? _gallery;
  int? _people;
  String? _lat;
  String? _lang;
  String? _description;
  int? _security;
  String? _tags;
  int? _status;
  String? _eventStatus;
  int? _isDeleted;
  int? _scanTicket;
  String? _imagePath;
  int? _rate;
  int? _totalTickets;
  int? _soldTickets;

  Data copyWith({
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
    List<String>? gallery,
    int? people,
    String? lat,
    String? lang,
    String? description,
    int? security,
    String? tags,
    int? status,
    String? eventStatus,
    int? isDeleted,
    int? scanTicket,
    String? imagePath,
    int? rate,
    int? totalTickets,
    int? soldTickets,
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
        scanTicket: scanTicket ?? _scanTicket,
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

  List<String>? get gallery => _gallery;

  int? get people => _people;

  String? get lat => _lat;

  String? get lang => _lang;

  String? get description => _description;

  int? get security => _security;

  String? get tags => _tags;

  int? get status => _status;

  String? get eventStatus => _eventStatus;

  int? get isDeleted => _isDeleted;

  int? get scanTicket => _scanTicket;

  String? get imagePath => _imagePath;

  int? get rate => _rate;

  int? get totalTickets => _totalTickets;

  int? get soldTickets => _soldTickets;

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
    map['scanTicket'] = _scanTicket;
    map['imagePath'] = _imagePath;
    map['rate'] = _rate;
    map['totalTickets'] = _totalTickets;
    map['soldTickets'] = _soldTickets;
    return map;
  }
}
