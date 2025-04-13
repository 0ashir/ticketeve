
import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/setting_provider.dart';
import 'package:eventright_organizer/screens/settings/change_password_screen.dart';
import 'package:eventright_organizer/screens/settings/faqs_screen.dart';
import 'package:eventright_organizer/screens/settings/feed_back_screen.dart';
import 'package:eventright_organizer/screens/settings/privacy_policy_screen.dart';
import 'package:eventright_organizer/screens/settings/terms_use_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late SettingProvider settingProvider;
  @override
  void initState() {
    super.initState();
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    init();
  }

  init() async {
    await settingProvider.callApiForSettings();
  }

  @override
  Widget build(BuildContext context) {
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
          getTranslated(context, 'settings').toString(),
          style: const TextStyle(
              color: whiteColor,
              fontSize: 16,
              fontFamily: AppFontFamily.poppinsMedium),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: MediaQuery.of(context).size.height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePassword(),
                      ));
                },
                child: NormalEntry(
                  text: getTranslated(context, 'change_password').toString(),
                )),
            InkWell(
              child: NormalEntry(
                text: getTranslated(context, 'language').toString(),
              ),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: whiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      title: Text(
                        getTranslated(context, 'language').toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            color: blackColor,
                            fontFamily: AppFontFamily.poppinsSemiBold),
                      ),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            InkWell(
                              onTap: () async {
                                changeLanguage(context, 'en');
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                  msg: getTranslated(context,
                                          'restart_app_to_see_the_change')
                                      .toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: primaryColor,
                                  textColor: whiteColor,
                                  fontSize: 16.0,
                                );
                              },
                              child: Text(
                                getTranslated(context, 'english').toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: blackColor,
                                    fontFamily: AppFontFamily.poppinsMedium),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                changeLanguage(context, 'es');
                              },
                              child: Text(
                                getTranslated(context, 'spanish').toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: AppFontFamily.poppinsMedium,
                                    color: blackColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            InkWell(
                onTap: () {
                  settingProvider.privacy.isEmpty
                      ? Fluttertoast.showToast(
                          msg: getTranslated(context, 'no_data_found')
                              .toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: primaryColor,
                          textColor: whiteColor,
                          fontSize: 16.0,
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicy(),
                          ));
                },
                child: NormalEntry(
                    text: getTranslated(context, 'privacy_policy').toString())),
            InkWell(
                onTap: () {
                  settingProvider.terms.isEmpty
                      ? Fluttertoast.showToast(
                          msg: getTranslated(context, 'no_data_found')
                              .toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: primaryColor,
                          textColor: whiteColor,
                          fontSize: 16.0,
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermsOfUse(),
                          ));
                },
                child: NormalEntry(
                  text: getTranslated(context, 'terms_of_use').toString(),
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeedBackScreen(),
                      ));
                },
                child: NormalEntry(
                  text: getTranslated(context, 'feed_back_support').toString(),
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FaqScreen(),
                      ));
                },
                child: NormalEntry(
                  text: getTranslated(context, 'faqs').toString(),
                )),
          ],
        ),
      ),
    );
  }

  void changeLanguage(BuildContext context, String languageCode) {
    setLocale(languageCode);
  }
}

class NormalEntry extends StatelessWidget {
  final String text;
  const NormalEntry({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: const TextStyle(
                  fontSize: 16,
                  color: blackColor,
                  fontFamily: AppFontFamily.poppinsMedium)),
          const Icon(
            Icons.chevron_right_outlined,
            color: inputTextColor,
          )
        ],
      ),
    );
  }
}
