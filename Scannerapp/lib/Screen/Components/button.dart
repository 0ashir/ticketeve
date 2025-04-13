import 'package:event_right_scanner/DeviceUtil/palette.dart';
import 'package:flutter/material.dart';

import '../../DeviceUtil/fonts.dart';
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
        color: Palette.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Palette.white,
          fontFamily: AppFontFamily.poppinsMedium,
        ),
      ),
    );
  }
}
