import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/tax_provider.dart';
import 'package:eventright_organizer/screens/components/button.dart';
import 'package:eventright_organizer/screens/components/field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddOrEditTaxScreen extends StatefulWidget {
  final bool isEditing;
  const AddOrEditTaxScreen({super.key, this.isEditing = false});

  @override
  State<AddOrEditTaxScreen> createState() => _AddOrEditTaxScreenState();
}

class _AddOrEditTaxScreenState extends State<AddOrEditTaxScreen> {
  final TextEditingController _taxNameController = TextEditingController();
  final TextEditingController _taxChargeController = TextEditingController();
  late TaxProvider taxProvider;
  bool checkedValue = false;
  String selectedTax = '';
  List<String> taxType = ['Percentage', 'Amount'];
  int value = 0;

  Future<void> refresh() async {
    Future.delayed(
      const Duration(seconds: 0),
      () {
        taxProvider.callApiForTax();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    taxProvider = Provider.of<TaxProvider>(context, listen: false);

    if (widget.isEditing == false) {
      _taxNameController.text = '';
      _taxChargeController.text = '';
      checkedValue = false;
    } else {
      _taxNameController.text = taxProvider.taxName;
      _taxChargeController.text = taxProvider.taxPrice.toString();
      checkedValue = taxProvider.isChecked;
      selectedTax = taxProvider.amountType;
      if (selectedTax.toLowerCase() == 'percentage') {
        value = 0;
      } else {
        value = 1;
      }
    }
  }

  @override
  void dispose() {
    _taxNameController.dispose();
    _taxChargeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          getTranslated(context, 'tax').toString(),
          style: const TextStyle(
              fontSize: 16,
              color: whiteColor,
              fontFamily: AppFontFamily.poppinsMedium),
        ),
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Field(
                      controller: _taxNameController,
                      label: "Tax Name",
                      icon: const Icon(Icons.confirmation_num_outlined),
                      isPassword: false,
                      inputType: TextInputType.name),
                  const SizedBox(height: 10),
                  Field(controller: _taxChargeController, label: "Charges of Tax", icon:const  Icon(Icons.confirmation_num_outlined), isPassword: false, inputType: TextInputType.number)
                 ,
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: const Text("Allow this tax on all bills", style: TextStyle(color: blackColor, fontSize: 14, fontFamily: AppFontFamily.poppinsRegular),),
                    value: checkedValue,
                    activeColor: primaryColor,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue!;
                        setState(() {});
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: const Text(
                      "You can change enable disable options from the tax option section anytime in future",
                      style: TextStyle(fontSize: 12, color: inputTextColor),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Tax Type",
                    style: TextStyle(fontSize: 15, color: blackColor, fontFamily: AppFontFamily.poppinsMedium),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: taxType.length,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        selected: selectedTax.toLowerCase() ==
                                taxType[index].toLowerCase()
                            ? true
                            : false,
                        activeColor: primaryColor,
                        dense: true,
                        value: index,
                        groupValue: value,
                        onChanged: (int? reason) {
                          setState(() {
                            value = reason!.toInt();
                            selectedTax = taxType[index];
                          });
                        },
                        title: Text(
                          taxType[index],style: const TextStyle(color: blackColor, fontFamily: AppFontFamily.poppinsRegular),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  // Add Button
                  InkWell(
                    onTap: () {
                      if (widget.isEditing == false) {
                        Map<String, dynamic> body = {
                          "name": _taxNameController.text,
                          "price": _taxChargeController.text,
                          "allow_all_bill": checkedValue == true ? 1 : 0,
                          "amount_type": selectedTax.toLowerCase()
                        };
                        taxProvider.callApiForAddTax(body).then((value) {
                          refresh();
                          Navigator.pop(context);
                        });
                      } else if (widget.isEditing == true) {
                        Map<String, dynamic> body = {
                          "name": _taxNameController.text,
                          "id": taxProvider.taxId,
                          "price": _taxChargeController.text,
                          "allow_all_bill": checkedValue == true ? 1 : 0,
                          "amount_type": selectedTax.toLowerCase()
                        };
                        taxProvider.callApiForEditTax(body).then((value) {
                          refresh();
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Button(text: widget.isEditing == true
                              ? getTranslated(context, 'save').toString()
                              : getTranslated(context, 'add').toString(),)  ),

                  const SizedBox(height: 10),

                  // Cancel Button
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: primaryColor),
                      ),
                      child: Center(
                        child: Text(
                          getTranslated(context, 'cancel').toString(),
                          style: const TextStyle(
                              fontSize: 14, color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
