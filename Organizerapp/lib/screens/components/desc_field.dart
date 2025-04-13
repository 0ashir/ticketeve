import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:flutter/material.dart';

class DescField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  const DescField(
      {super.key,
      required this.controller,
      required this.label,
      this.validator});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.9,
      decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        controller: controller,
        validator: validator,
        cursorColor: blackColor,
        maxLines: 5,
        minLines: 5,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color:primaryColor)),
          contentPadding: const EdgeInsets.all(12),
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              label,
             style: const TextStyle(
                fontSize: 16,
                color: blackColor,
                fontFamily: AppFontFamily.poppinsMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
