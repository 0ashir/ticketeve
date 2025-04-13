import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../DeviceUtil/palette.dart';

class Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon icon;
  final bool isPassword;
  final FocusNode? focusNode;
  final VoidCallback? onIconClicked;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final List<TextInputFormatter>? inputFormatter;
  final Function(String)? onChange;
  const Field(
      {super.key,
      required this.controller,
      required this.label,
      required this.icon,
      required this.isPassword,
      required this.inputType,
      this.focusNode,
      this.onIconClicked,
      this.validator,
      this.onChange,
      this.inputFormatter});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.9,
      decoration: BoxDecoration(
          color: Palette.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        controller: controller,
        onChanged: onChange??(value){},
        inputFormatters: inputFormatter,
        focusNode: focusNode,
        validator: validator,
        cursorColor: Palette.black,
        obscureText: isPassword ? true : false,
        keyboardType: inputType,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Palette.primary)),
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Palette.black,
                  ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          suffixIcon: InkWell(
              borderRadius: BorderRadius.circular(4),
              splashColor: Palette.grey,
              onTap: onIconClicked,
              child: icon),
        ),
      ),
    );
  }
}
