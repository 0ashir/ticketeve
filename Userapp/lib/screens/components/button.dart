import 'package:flutter/material.dart';

import '../../constant/app_const_font.dart';
import '../../constant/color_constant.dart';

class Button extends StatelessWidget {
  final String text;
  const Button({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.whiteColor,
          fontFamily: AppFontFamily.poppinsMedium,
        ),
      ),
    );
  }
}
