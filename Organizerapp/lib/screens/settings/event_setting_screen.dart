import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/screens/settings/tax_options_screen.dart';
import 'package:flutter/material.dart';

class EventSetting extends StatefulWidget {
  const EventSetting({super.key});

  @override
  State<EventSetting> createState() => _EventSettingState();
}

class _EventSettingState extends State<EventSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(getTranslated(context, 'event_settings').toString(),
            style: const TextStyle(
                fontSize: 16,
                color: whiteColor,
                fontFamily: AppFontFamily.poppinsMedium)),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TaxOptions(),
                  ),
                );
              },
              title: Text(
                getTranslated(context, 'tax').toString(),
                style: const TextStyle(fontSize: 18, color: blackColor, fontFamily: AppFontFamily.poppinsMedium),
              ),
              subtitle: Text(
                getTranslated(context, 'tax_options').toString(),
                style: const TextStyle(fontSize: 14, color: inputTextColor, fontFamily: AppFontFamily.poppinsRegular),
              ),
              trailing: const Icon(Icons.chevron_right_outlined,
                  color: inputTextColor),
            )
          ],
        ),
      ),
    );
  }
}
