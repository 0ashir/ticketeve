
class AddEventModel {
  AddEventModel({
    Data? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  AddEventModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  Data? _data;
  bool? _success;

  AddEventModel copyWith({
    Data? data,
    bool? success,
  }) =>
      AddEventModel(
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
    String? name,
    String? image,
    String? startTime,
    String? endTime,
    String? scannerId,
    String? categoryId,
    String? type,
    String? address,
    String? lat,
    String? lang,
    String? status,
    String? description,
    String? url,
    String? people,
    num? userId,
    String? updatedAt,
    String? createdAt,
    num? id,
    String? imagePath,
    num? rate,
    num? totalTickets,
    num? soldTickets,
  }) {
    _name = name;
    _image = image;
    _startTime = startTime;
    _endTime = endTime;
    _scannerId = scannerId;
    _categoryId = categoryId;
    _type = type;
    _address = address;
    _lat = lat;
    _lang = lang;
    _status = status;
    _description = description;
    _url = url;
    _people = people;
    _userId = userId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
    _imagePath = imagePath;
    _rate = rate;
    _totalTickets = totalTickets;
    _soldTickets = soldTickets;
  }

 Data.fromJson(dynamic json) {
  
  _name = json['name'];

  _image = json['image'];

  _startTime = json['start_time'];

  _endTime = json['end_time'];

  _scannerId = json['scanner_id'];

  _categoryId = json['category_id'];

  _type = json['type'];

  _address = json['address'];

  _lat = json['lat'];

  _lang = json['lang'];

  _status = json['status'];

  _description = json['description'];

  _url = json['url'];

  _people = json['people'];

  _userId = json['user_id'];

  _updatedAt = json['updated_at'];

  _createdAt = json['created_at'];

  _id = json['id'];

  _imagePath = json['imagePath'];

  _rate = num.tryParse(json['rate'].toString());

  _totalTickets = num.tryParse(json['totalTickets'].toString());

  _soldTickets = num.tryParse(json['soldTickets'].toString());

}


  String? _name;
  String? _image;
  String? _startTime;
  String? _endTime;
  String? _scannerId;
  String? _categoryId;
  String? _type;
  String? _address;
  String? _lat;
  String? _lang;
  String? _status;
  String? _description;
  String? _url;
  String? _people;
  num? _userId;
  String? _updatedAt;
  String? _createdAt;
  num? _id;
  String? _imagePath;
  num? _rate;
  num? _totalTickets;
  num? _soldTickets;

  Data copyWith({
    String? name,
    String? image,
    String? startTime,
    String? endTime,
    String? scannerId,
    String? categoryId,
    String? type,
    String? address,
    String? lat,
    String? lang,
    String? status,
    String? description,
    String? url,
    String? people,
    num? userId,
    String? updatedAt,
    String? createdAt,
    num? id,
    String? imagePath,
    num? rate,
    num? totalTickets,
    num? soldTickets,
  }) =>
      Data(
        name: name ?? _name,
        image: image ?? _image,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        scannerId: scannerId ?? _scannerId,
        categoryId: categoryId ?? _categoryId,
        type: type ?? _type,
        address: address ?? _address,
        lat: lat ?? _lat,
        lang: lang ?? _lang,
        status: status ?? _status,
        description: description ?? _description,
        url: url ?? _url,
        people: people ?? _people,
        userId: userId ?? _userId,
        updatedAt: updatedAt ?? _updatedAt,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
        imagePath: imagePath ?? _imagePath,
        rate: rate ?? _rate,
        totalTickets: totalTickets ?? _totalTickets,
        soldTickets: soldTickets ?? _soldTickets,
      );

  String? get name => _name;

  String? get image => _image;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  String? get scannerId => _scannerId;

  String? get categoryId => _categoryId;

  String? get type => _type;

  String? get address => _address;

  String? get lat => _lat;

  String? get lang => _lang;

  String? get status => _status;

  String? get description => _description;

  String? get url => _url;

  String? get people => _people;

  num? get userId => _userId;

  String? get updatedAt => _updatedAt;

  String? get createdAt => _createdAt;

  num? get id => _id;

  String? get imagePath => _imagePath;

  num? get rate => _rate;

  num? get totalTickets => _totalTickets;

  num? get soldTickets => _soldTickets;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['image'] = _image;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['scanner_id'] = _scannerId;
    map['category_id'] = _categoryId;
    map['type'] = _type;
    map['address'] = _address;
    map['lat'] = _lat;
    map['lang'] = _lang;
    map['status'] = _status;
    map['description'] = _description;
    map['url'] = _url;
    map['people'] = _people;
    map['user_id'] = _userId;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    map['imagePath'] = _imagePath;
    map['rate'] = _rate;
    map['totalTickets'] = _totalTickets;
    map['soldTickets'] = _soldTickets;
    return map;
  }
}
