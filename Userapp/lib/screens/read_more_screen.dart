import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:flutter/material.dart';

class ReadMore extends StatefulWidget {
  final String? allText;

  const ReadMore({super.key, this.allText});

  @override
  State<ReadMore> createState() => _ReadMoreState();
}

class _ReadMoreState extends State<ReadMore> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
            size: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 05),
          child: Text(
            widget.allText!,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.blackColor,
              fontFamily: AppFontFamily.poppinsRegular,
            ),
          ),
        ),
      ),
    );
  }
}
