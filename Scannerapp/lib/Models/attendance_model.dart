class AttendanceModel {
  AttendanceModel({
    List<AttendanceData>? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  AttendanceModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AttendanceData.fromJson(v));
      });
    }
    _success = json['success'];
  }

  List<AttendanceData>? _data;
  bool? _success;

  AttendanceModel copyWith({
    List<AttendanceData>? data,
    bool? success,
  }) =>
      AttendanceModel(
        data: data ?? _data,
        success: success ?? _success,
      );

  List<AttendanceData>? get data => _data;

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

class AttendanceData {
  AttendanceData({
    int? id,
    int? ticketId,
    int? orderId,
    int? customerId,
    String? ticketNumber,
    int? status,
    String? createdAt,
    String? updatedAt,
    String? name,
    dynamic address,
    String? startTime,
    String? endTime,
    String? ticketType,
  }) {
    _id = id;
    _ticketId = ticketId;
    _orderId = orderId;
    _customerId = customerId;
    _ticketNumber = ticketNumber;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _name = name;
    _address = address;
    _startTime = startTime;
    _endTime = endTime;
    _ticketType = ticketType;
  }

  AttendanceData.fromJson(dynamic json) {
    _id = json['id'];
    _ticketId = json['ticket_id'];
    _orderId = json['order_id'];
    _customerId = json['customer_id'];
    _ticketNumber = json['ticket_number'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _name = json['name'];
    _address = json['address'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _ticketType = json['ticket_type'];
  }

  int? _id;
  int? _ticketId;
  int? _orderId;
  int? _customerId;
  String? _ticketNumber;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _name;
  dynamic _address;
  String? _startTime;
  String? _endTime;
  String? _ticketType;

  AttendanceData copyWith({
    int? id,
    int? ticketId,
    int? orderId,
    int? customerId,
    String? ticketNumber,
    int? status,
    String? createdAt,
    String? updatedAt,
    String? name,
    dynamic address,
    String? startTime,
    String? endTime,
    String? ticketType,
  }) =>
      AttendanceData(
        id: id ?? _id,
        ticketId: ticketId ?? _ticketId,
        orderId: orderId ?? _orderId,
        customerId: customerId ?? _customerId,
        ticketNumber: ticketNumber ?? _ticketNumber,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        name: name ?? _name,
        address: address ?? _address,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        ticketType: ticketType ?? _ticketType,
      );

  int? get id => _id;

  int? get ticketId => _ticketId;

  int? get orderId => _orderId;

  int? get customerId => _customerId;

  String? get ticketNumber => _ticketNumber;

  int? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get name => _name;

  dynamic get address => _address;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  String? get ticketType => _ticketType;

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
    map['name'] = _name;
    map['address'] = _address;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['ticket_type'] = _ticketType;
    return map;
  }
}
