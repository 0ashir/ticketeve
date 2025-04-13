import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:flutter/material.dart';

import '../../constant/font_constant.dart';

class Button extends StatelessWidget {
  final double? width;
  final String text;
  const Button({super.key, required this.text,this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      width:width?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: whiteColor,
          fontFamily: AppFontFamily.poppinsMedium,
        ),
      ),
    );
  }
}
