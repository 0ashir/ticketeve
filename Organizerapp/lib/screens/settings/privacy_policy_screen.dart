import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late SettingProvider settingProvider;

  @override
  void initState() {
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      settingProvider.callApiForSettings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of<SettingProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: whiteColor, size: 18),
        ),
        title: Text(
          getTranslated(context, 'privacy_policy').toString(),
          style: const TextStyle(fontSize: 16, color: whiteColor, fontFamily: AppFontFamily.poppinsMedium)
        ),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: settingProvider.settingLoader,
        progressIndicator: const SpinKitCircle(color: primaryColor),
        offset: Offset(MediaQuery.of(context).size.width * 0.43, MediaQuery.of(context).size.height * 0.35),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: HtmlWidget(
            settingProvider.privacy,
          ),
        ),
      ),
    );
  }
}
