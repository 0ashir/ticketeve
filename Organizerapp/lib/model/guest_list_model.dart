import 'package:eventright_organizer/utilities/extension_methods.dart';

class GuestListModel {
  GuestListModel({
    List<GuestData>? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  GuestListModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(
          GuestData.fromJson(v),
        );
      });
    }
    _success = json['success'];
  }

  List<GuestData>? _data;
  bool? _success;

  GuestListModel copyWith({
    List<GuestData>? data,
    bool? success,
  }) =>
      GuestListModel(
        data: data ?? _data,
        success: success ?? _success,
      );

  List<GuestData>? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data
          ?.map(
            (v) => v.toJson(),
          )
          .toList();
    }
    map['success'] = _success;
    return map;
  }
}

class GuestData {
  GuestData({
    num? id,
    String? orderId,
    num? customerId,
    num? organizationId,
    num? eventId,
    num? ticketId,
    num? quantity,
    num? tax,
    num? orgCommission,
    num? payment,
    num? paymentStatus,
    num? orgPayStatus,
    DateTime? createdAt,
    Customer? customer,
    Ticket? ticket,
  }) {
    _id = id;
    _orderId = orderId;
    _customerId = customerId;
    _organizationId = organizationId;
    _eventId = eventId;
    _ticketId = ticketId;
    _quantity = quantity;
    _tax = tax;
    _orgCommission = orgCommission;
    _payment = payment;
    _paymentStatus = paymentStatus;
    _orgPayStatus = orgPayStatus;
    _createdAt = createdAt;
    _customer = customer;
    _ticket = ticket;
  }

  GuestData.fromJson(dynamic json) {
    _id =  num.tryParse(json['id']);
    _orderId = json['order_id'];
    _customerId = num.tryParse( json['customer_id']);
    _organizationId = num.tryParse( json['organization_id']);
    _eventId = num.tryParse( json['event_id']);
    _ticketId = num.tryParse( json['ticket_id']);
    _quantity = num.tryParse( json['quantity']);
    _tax =  num.tryParse(json['tax']);
    _orgCommission =  num.tryParse(json['org_commission']);
    _payment = num.parse(json['payment'].toString());
    _paymentStatus = num.tryParse( json['payment_status']);
    _orgPayStatus =  num.tryParse(json['org_pay_status']);
    _createdAt = DateTime.parse(json['created_at']);
    _customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    _ticket = json['ticket'] != null ? Ticket.fromJson(json['ticket']) : null;
  }

  num? _id;
  String? _orderId;
  num? _customerId;
  num? _organizationId;
  num? _eventId;
  num? _ticketId;
  num? _quantity;
  num? _tax;
  num? _orgCommission;
  num? _payment;
  num? _paymentStatus;
  num? _orgPayStatus;
  DateTime? _createdAt;
  Customer? _customer;
  Ticket? _ticket;

  GuestData copyWith({
    num? id,
    String? orderId,
    num? customerId,
    num? organizationId,
    num? eventId,
    num? ticketId,
    num? quantity,
    num? tax,
    num? orgCommission,
    num? payment,
    num? paymentStatus,
    num? orgPayStatus,
    DateTime? createdAt,
    Customer? customer,
    Ticket? ticket,
  }) =>
      GuestData(
        id: id ?? _id,
        orderId: orderId ?? _orderId,
        customerId: customerId ?? _customerId,
        organizationId: organizationId ?? _organizationId,
        eventId: eventId ?? _eventId,
        ticketId: ticketId ?? _ticketId,
        quantity: quantity ?? _quantity,
        tax: tax ?? _tax,
        orgCommission: orgCommission ?? _orgCommission,
        payment: payment ?? _payment,
        paymentStatus: paymentStatus ?? _paymentStatus,
        orgPayStatus: orgPayStatus ?? _orgPayStatus,
        createdAt: createdAt ?? _createdAt,
        customer: customer ?? _customer,
        ticket: ticket ?? _ticket,
      );

  num? get id => _id;

  String? get orderId => _orderId;

  num? get customerId => _customerId;

  num? get organizationId => _organizationId;

  num? get eventId => _eventId;

  num? get ticketId => _ticketId;

  num? get quantity => _quantity;

  num? get tax => _tax;

  num? get orgCommission => _orgCommission;

  num? get payment => _payment;

  num? get paymentStatus => _paymentStatus;

  num? get orgPayStatus => _orgPayStatus;

  String get createdAt => _createdAt!.toDDMMMYYYY();

  Customer? get customer => _customer;

  Ticket? get ticket => _ticket;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['order_id'] = _orderId;
    map['customer_id'] = _customerId;
    map['organization_id'] = _organizationId;
    map['event_id'] = _eventId;
    map['ticket_id'] = _ticketId;
    map['quantity'] = _quantity;
    map['tax'] = _tax;
    map['org_commission'] = _orgCommission;
    map['payment'] = _payment;
    map['payment_status'] = _paymentStatus;
    map['org_pay_status'] = _orgPayStatus;
    map['created_at'] = _createdAt;
    if (_customer != null) {
      map['customer'] = _customer?.toJson();
    }
    if (_ticket != null) {
      map['ticket'] = _ticket?.toJson();
    }
    return map;
  }
}

class Ticket {
  Ticket({
    num? id,
    String? ticketNumber,
  }) {
    _id = id;
    _ticketNumber = ticketNumber;
  }

  Ticket.fromJson(dynamic json) {
    _id =  num.tryParse(json['id']);
    _ticketNumber = json['ticket_number'];
  }

  num? _id;
  String? _ticketNumber;

  Ticket copyWith({
    num? id,
    String? ticketNumber,
  }) =>
      Ticket(
        id: id ?? _id,
        ticketNumber: ticketNumber ?? _ticketNumber,
      );

  num? get id => _id;

  String? get ticketNumber => _ticketNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ticket_number'] = _ticketNumber;
    return map;
  }
}

class Customer {
  Customer({
    String? name,
    num? id,
    String? email,
    String? phone,
    String? imagePath,
  }) {
    _name = name;
    _id = id;
    _email = email;
    _phone = phone;
    _imagePath = imagePath;
  }

  Customer.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
    _email = json['email'];
    _phone = json['phone'];
    _imagePath = json['imagePath'];
  }

  String? _name;
  num? _id;
  String? _email;
  String? _phone;
  String? _imagePath;

  Customer copyWith({
    String? name,
    num? id,
    String? email,
    String? phone,
    String? imagePath,
  }) =>
      Customer(
        name: name ?? _name,
        id: id ?? _id,
        email: email ?? _email,
        phone: phone ?? _phone,
        imagePath: imagePath ?? _imagePath,
      );

  String? get name => _name;

  num? get id => _id;

  String? get email => _email;

  String? get phone => _phone;

  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    map['email'] = _email;
    map['phone'] = _phone;
    map['imagePath'] = _imagePath;
    return map;
  }
}
