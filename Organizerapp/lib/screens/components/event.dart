import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constant/color_constant.dart';
import '../../constant/font_constant.dart';
import '../../localization/localization_constant.dart';
import 'package:intl/src/intl/date_format.dart';

class Event extends StatelessWidget {
  final VoidCallback onMainTap;
  final VoidCallback guestList;
  final String image;
  final String tickets;
  final String title;
  final String description;
  final String startTime;
  final Widget? trailingIcon;
  final VoidCallback? trailingClick;
  const Event(
      {super.key,
      required this.onMainTap,
      required this.image,
      required this.tickets,
      required this.title,
      required this.description,
      required this.startTime,
       this.trailingIcon,
       this.trailingClick,
      required this.guestList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onMainTap,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: image,
              errorWidget: (context, url, error) => Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                height: 190,
                width: MediaQuery.of(context).size.width,
                child:
                    Image.asset("assets/images/NoImage.png", fit: BoxFit.cover),
              ),
              imageBuilder: (context, imageProvider) => Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                height: 190,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                    ),
                    color: Colors.black87.withOpacity(0.6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tickets,
                          style:
                              const TextStyle(fontSize: 12, color: whiteColor, fontFamily: AppFontFamily
                                                            .poppinsRegular),
                        ),
                        InkWell(
                          onTap: guestList,
                          child: Row(
                            children: [
                              Text(
                                getTranslated(context, 'see_guest_list')
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 12, color: blueColor ,fontFamily: AppFontFamily
                                                            .poppinsRegular),
                              ),
                              const Icon(Icons.arrow_forward_ios,
                                  color: blueColor, size: 14)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Container(
                alignment: Alignment.center,
                width: 32,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: const TextStyle(color: primaryColor, fontSize: 16, fontFamily: AppFontFamily
                                                        .poppinsSemiBold,),
                      text: DateFormat('MMM').format(
                        DateTime.parse(startTime),
                      ),
                      children: [
                        TextSpan(
                          style: const TextStyle(
                            color: blackColor,
                            fontSize: 16,
                          ),
                          text: DateFormat('dd').format(
                            DateTime.parse(startTime),
                          ),
                        )
                      ]),
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(
                    color: blackColor,
                    fontFamily: AppFontFamily.poppinsSemiBold,
                    letterSpacing: 0,
                    fontSize: 18),
              ),
              subtitle: Text(
                description,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: blackColor.withOpacity(0.6),
                    fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing:trailingIcon!=null? InkWell(
                onTap: trailingClick,
                
                borderRadius: BorderRadius.circular(8),
                child: trailingIcon):const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
