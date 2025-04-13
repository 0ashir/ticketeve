class SingleTicketModel {
  SingleTicketModel({
    bool? success,
    Data? data,
  }) {
    _success = success;
    _data = data;
  }

  SingleTicketModel.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _success;
  Data? _data;
  SingleTicketModel copyWith({
    bool? success,
    Data? data,
  }) =>
      SingleTicketModel(
        success: success ?? _success,
        data: data ?? _data,
      );
  bool? get success => _success;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    int? id,
    int? ticketId,
    int? orderId,
    int? customerId,
    String? ticketNumber,
    int? status,
    String? name,
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
    _name = name;
    _startTime = startTime;
    _endTime = endTime;
    _ticketType = ticketType;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _ticketId = json['ticket_id'];
    _orderId = json['order_id'];
    _customerId = json['customer_id'];
    _ticketNumber = json['ticket_number'];
    _status = json['status'];
    _name = json['name'];
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
  String? _name;
  String? _startTime;
  String? _endTime;
  String? _ticketType;
  Data copyWith({
    int? id,
    int? ticketId,
    int? orderId,
    int? customerId,
    String? ticketNumber,
    int? status,
    String? name,
    String? startTime,
    String? endTime,
    String? ticketType,
  }) =>
      Data(
        id: id ?? _id,
        ticketId: ticketId ?? _ticketId,
        orderId: orderId ?? _orderId,
        customerId: customerId ?? _customerId,
        ticketNumber: ticketNumber ?? _ticketNumber,
        status: status ?? _status,
        name: name ?? _name,
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
  String? get name => _name;
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
    map['name'] = _name;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['ticket_type'] = _ticketType;
    return map;
  }
}
