class EditTicketModel {
  EditTicketModel({
    Data? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  EditTicketModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  Data? _data;
  bool? _success;

  EditTicketModel copyWith({
    Data? data,
    bool? success,
  }) =>
      EditTicketModel(
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
    String? eventId,
    String? quantity,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? startTime,
    DateTime? endTime,
    String? type,
    String? ticketPerOrder,
    String? description,
    num? price,
    String? status,
    num? id,
  }) {
    _name = name;
    _eventId = eventId;
    _quantity = quantity;
    _startDate = startDate;
    _endDate = endDate;
    _startTime = startTime;
    _endTime = endTime;
    _type = type;
    _ticketPerOrder = ticketPerOrder;
    _description = description;
    _price = price;
    _status = status;
    _id = id;
  }
// name:"design"
// event_id:1
// id:10
// quantity:10
// start_date:2023-12-10
// end_date:2022-12-10
// start_time:12:00PM
// end_time:12:00PM
// type:Paid
// ticket_per_order:5
// description:"fgdg d f bsfghsdkfksdghfksdgfksdgfjk "
// status:1
// price:100

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _eventId = json['event_id'];
    _quantity = json['quantity'];
    _startDate = DateTime.parse(json['start_date']);
    _endDate = DateTime.parse(json['end_date']);
    _startTime = DateTime.parse(json['start_time']);
    _endTime = DateTime.parse(json['end_time']);
    _type = json['type'];
    _ticketPerOrder = json['ticket_per_order'];
    _description = json['description'];
    _price = num.parse(json['price']);
    _status = json['status'];
    _id =  num.tryParse(json['id']);
  }

  String? _name;
  String? _eventId;
  String? _quantity;
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _startTime;
  DateTime? _endTime;
  String? _type;
  String? _ticketPerOrder;
  String? _description;
  num? _price;
  String? _status;
  num? _id;

  Data copyWith({
    String? name,
    String? eventId,
    String? quantity,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? startTime,
    DateTime? endTime,
    String? type,
    String? ticketPerOrder,
    String? description,
    num? price,
    String? status,
    num? id,
  }) =>
      Data(
        name: name ?? _name,
        eventId: eventId ?? _eventId,
        quantity: quantity ?? _quantity,
        startDate: startDate ?? _startDate,
        endDate: endDate ?? _endDate,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        type: type ?? _type,
        ticketPerOrder: ticketPerOrder ?? _ticketPerOrder,
        description: description ?? _description,
        price: price ?? _price,
        status: status ?? _status,
        id: id ?? _id,
      );

  String? get name => _name;

  String? get eventId => _eventId;

  String? get quantity => _quantity;

  DateTime? get startDate => _startDate;

  DateTime? get endDate => _endDate;

  DateTime? get startTime => _startTime;

  DateTime? get endTime => _endTime;

  String? get type => _type;

  String? get ticketPerOrder => _ticketPerOrder;

  String? get description => _description;

  num? get price => _price;

  String? get status => _status;

  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['event_id'] = _eventId;
    map['quantity'] = _quantity;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['type'] = _type;
    map['ticket_per_order'] = _ticketPerOrder;
    map['description'] = _description;
    map['price'] = _price;
    map['status'] = _status;
    map['id'] = _id;
    return map;
  }
}
