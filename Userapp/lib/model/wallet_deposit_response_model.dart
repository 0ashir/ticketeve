import 'package:eventright_pro_user/model/wallet_model.dart';

class WalletDepositResponseModel {
  bool? success;
  Transactions? data;
  String? balance;

  WalletDepositResponseModel({this.success, this.data, this.balance});

  WalletDepositResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Transactions.fromJson(json['data']) : null;
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['balance'] = balance;
    return data;
  }
}
