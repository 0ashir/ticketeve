import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_const_image.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EventImagePreview extends StatelessWidget {
  final String imageURL;
  final String eventName;

  const EventImagePreview({super.key, required this.imageURL, required this.eventName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          eventName,
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(double.infinity),
          child: CachedNetworkImage(
            imageUrl: imageURL,
            fit: BoxFit.cover,
            placeholder: (context, url) => SpinKitCircle(
              color: AppColors.primaryColor.withOpacity(0.4),
            ),
            errorWidget: (context, url, error) => Image.asset(AppConstantImage.noImage),
          ),
        ),
      ),
    );
  }
}
