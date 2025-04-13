import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

import '../../constant/font_constant.dart';

class SelectionField extends StatelessWidget {
  final SingleValueDropDownController controller;
  final String label;
  final List<DropDownValueModel> dropDownList;

  const SelectionField(
      {super.key,
      required this.controller,
      required this.label,
      required this.dropDownList});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.85,
      height: 48,
      decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)),
      child: DropDownTextField(
        controller: controller,
        listBorderColor: primaryColor,
        listBgColor: primaryColor.withOpacity(0.1),
        clearOption: true,
        clearIconProperty: IconProperty(color: primaryColor),
        searchTextStyle: const TextStyle(color: Colors.red),
        searchDecoration: const InputDecoration(hintText: "Search by Type"),
        listTextStyle: const TextStyle(
          fontSize: 16,
          color: blackColor,
          fontFamily: AppFontFamily.poppinsMedium,
        ),
        textStyle: const TextStyle(fontSize: 16),
        textFieldDecoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            label: Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 4),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: blackColor,
                  fontFamily: AppFontFamily.poppinsMedium,
                ),
              ),
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: primaryColor))),
        validator: (value) {
          if (value == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        dropDownItemCount: 5,
        dropDownList: dropDownList,
        onChanged: (val) {
          try {
            DropDownValueModel model = val as DropDownValueModel;
            debugPrint("Value is ${model.value}");
          } catch (e) {
            debugPrint(e.toString());
          }
        },
      ),
    );
  }
}
