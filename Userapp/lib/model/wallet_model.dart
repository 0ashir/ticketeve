class WalletModel {
  bool? success;
  dynamic msg;
  Data? data;

  WalletModel({this.success, this.msg, this.data});

  WalletModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? balance;
  List<Transactions>? transactions;

  Data({this.balance, this.transactions});

  Data.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = balance;
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  int? id;
  int? payableId;
  int? walletId;
  String? type;
  String? amount;
  Meta? meta;

  Transactions({this.id, this.payableId, this.walletId, this.type, this.amount, this.meta});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    payableId = json['payable_id'];
    walletId = json['wallet_id'];
    type = json['type'];
    amount = json['amount'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['payable_id'] = payableId;
    data['wallet_id'] = walletId;
    data['type'] = type;
    data['amount'] = amount;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Meta {
  String? eventId;
  String? token;
  String? currency;
  String? paymentMode;

  Meta({this.eventId, this.token, this.currency, this.paymentMode});

  Meta.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    token = json['token'];
    currency = json['currency'];
    paymentMode = json['payment_mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['token'] = token;
    data['currency'] = currency;
    data['payment_mode'] = paymentMode;
    return data;
  }
}
