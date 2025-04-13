class AllEventModel {
  AllEventModel({
    List<AllEventData>? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  AllEventModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AllEventData.fromJson(v));
      });
    }
    _success = json['success'];
  }

  List<AllEventData>? _data;
  bool? _success;

  AllEventModel copyWith({
    List<AllEventData>? data,
    bool? success,
  }) =>
      AllEventModel(
        data: data ?? _data,
        success: success ?? _success,
      );

  List<AllEventData>? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    return map;
  }
}

class AllEventData {
  AllEventData({
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
    int? status,
    String? eventStatus,
    int? isDeleted,
    int? scanTicket,
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
    _status = status;
    _eventStatus = eventStatus;
    _isDeleted = isDeleted;
    _scanTicket = scanTicket;
    _imagePath = imagePath;
    _rate = rate;
    _totalTickets = totalTickets;
    _soldTickets = soldTickets;
  }

  AllEventData.fromJson(dynamic json) {
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
  int? _status;
  String? _eventStatus;
  int? _isDeleted;
  int? _scanTicket;
  String? _imagePath;
  int? _rate;
  dynamic _totalTickets;
  dynamic _soldTickets;

  AllEventData copyWith({
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
    int? status,
    String? eventStatus,
    int? isDeleted,
    int? scanTicket,
    String? imagePath,
    int? rate,
    dynamic totalTickets,
    dynamic soldTickets,
  }) =>
      AllEventData(
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

  int? get status => _status;

  String? get eventStatus => _eventStatus;

  int? get isDeleted => _isDeleted;

  int? get scanTicket => _scanTicket;

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
