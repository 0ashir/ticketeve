import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constant/font_constant.dart';

class Field extends StatelessWidget {
  final bool? readOnly;
  final TextEditingController controller;
  final String label;
  final Icon icon;
  final bool isPassword;
  final FocusNode? focusNode;
  final VoidCallback? onIconClicked;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final List<TextInputFormatter>? inputFormatter;
  const Field(
      {super.key,
      this.readOnly,
      required this.controller,
      required this.label,
      required this.icon,
      required this.isPassword,
      required this.inputType,
      this.focusNode,
      this.onIconClicked,
      this.validator,
      this.inputFormatter});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.9,
      decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly??false,
        inputFormatters: inputFormatter,
        focusNode: focusNode,
        validator: validator,
        cursorColor: blackColor,
        obscureText: isPassword ? true : false,
        keyboardType: inputType,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primaryColor)),
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: blackColor,
                fontFamily: AppFontFamily.poppinsMedium,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          suffixIcon: InkWell(
              borderRadius: BorderRadius.circular(4),
              splashColor: inputTextColor,
              onTap: onIconClicked,
              child: icon),
        ),
      ),
    );
  }
}
