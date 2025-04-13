import 'package:eventright_organizer/constant/common_function.dart';
import 'package:eventright_organizer/model/add_tax_model.dart';
import 'package:eventright_organizer/model/change_tax_status_model.dart';
import 'package:eventright_organizer/model/delete_tax_model.dart';
import 'package:eventright_organizer/model/edit_tax_model.dart';
import 'package:eventright_organizer/model/tax_detail_model.dart';
import 'package:eventright_organizer/model/tax_model.dart';
import 'package:eventright_organizer/retrofit/api_client.dart';
import 'package:eventright_organizer/retrofit/api_header.dart';
import 'package:eventright_organizer/retrofit/base_model.dart';
import 'package:eventright_organizer/retrofit/error_handler.dart';
import 'package:flutter/cupertino.dart';

class TaxProvider extends ChangeNotifier {
  /// call api for tax ///

  bool _taxLoader = false;

  bool get taxLoader => _taxLoader;

  List<TaxData> tax = [];

  Future<BaseModel<TaxModel>> callApiForTax() async {
    TaxModel response;
    _taxLoader = true;
    notifyListeners();

    try {
      tax.clear();
      response = await RestClient(
        RetroApi().dioData(),
      ).tax();
      if (response.success == true) {
        _taxLoader = false;
        notifyListeners();

        if (response.data != null) {
          tax.addAll(response.data!);
        }
        notifyListeners();
      }
    } catch (error) {
      _taxLoader = false;
      notifyListeners();
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for addTax ///

  Future<BaseModel<AddTaxModel>> callApiForAddTax(body) async {
    AddTaxModel response;

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).addTax(body);

      if (response.success == true) {
        CommonFunction.toastMessage(response.msg!);
        notifyListeners();
      }
    } catch (error) {
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api fot delete tax ///

  Future<BaseModel<DeleteTaxModel>> callApiForDeleteTax(id) async {
    DeleteTaxModel response;

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).deleteTax(id);
      if (response.success == true) {
        CommonFunction.toastMessage(response.msg!);
        notifyListeners();
      }
    } catch (error) {
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();

    return BaseModel()..data = response;
  }

  /// call api for tax details ///

  String taxName = '';
  int taxPrice = 0;
  bool isChecked = false;
  int taxId = 0;
  String amountType = '';

  Future<BaseModel<TaxDetailModel>> callApiForTaxDetails(id) async {
    TaxDetailModel response;

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).taxDetails(id);

      if (response.success == true) {
        if (response.data != null) {
          taxId = response.data!.id!.toInt();
          taxName = response.data!.name!;
          taxPrice = response.data!.price!.toInt();
          isChecked = response.data!.allowAllBill == 1 ? true : false;
          amountType = response.data!.amountType!;
        }
        notifyListeners();
      }
    } catch (error) {
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for edit tax ///

  Future<BaseModel<EditTaxModel>> callApiForEditTax(body) async {
    EditTaxModel response;

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).editTax(body);

      if (response.success == true) {
        CommonFunction.toastMessage(response.msg!);
        notifyListeners();
      }
    } catch (error) {
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }

  /// call api for change tax status ///

  Future<BaseModel<ChangeTaxStatusModel>> callApiForChangeTaxStatus(id, status) async {
    ChangeTaxStatusModel response;

    try {
      response = await RestClient(
        RetroApi().dioData(),
      ).changeStatusTax(id, status);

      if (response.success == true) {
        notifyListeners();
      }
    } catch (error) {
      return BaseModel()
        ..setException(
          ErrorClass.withError(error: error),
        );
    }
    notifyListeners();
    return BaseModel()..data = response;
  }
}
