import 'package:eventright_pro_user/constant/lang_pref.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/localization/lanugaue.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import '/main.dart';
import 'package:flutter/material.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  int? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: AppColors.whiteColor,
          ),
        ),
        title: Text(
          getTranslated(context, AppConstant.changeLanguageTitle).toString(),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: ListView.separated(
        
        itemCount: Language.languageList().length,
        padding: const EdgeInsets.all(16),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemBuilder: (context, index) {
          value = 0;
          value = Language.languageList()[index].languageCode == SharedPreferenceHelperUtils.getString(Preferences.currentLanguageCode) ? index : null;
          if (SharedPreferenceHelperUtils.getString(Preferences.currentLanguageCode) == 'N/A') {
            value = 0;
          }
          return Card(
            elevation: 0.5,
            color: AppColors.whiteColor,
            margin: EdgeInsets.zero,
            child: Container(
              alignment: Alignment.center,
              child: RadioListTile(
                value: index,
                controlAffinity: ListTileControlAffinity.trailing,
                groupValue: value,
                activeColor: AppColors.primaryColor,
                onChanged: (dynamic value) async {
                  this.value = value;
                  Locale local = await setLocale(Language.languageList()[index].languageCode);
                  setState(() {
                    MyApp.setLocale(context, local);
                    SharedPreferenceHelperUtils.setString(Preferences.currentLanguageCode, Language.languageList()[index].languageCode);
                    Navigator.of(context).pop();
                  });
                },
                title: index == 0
                    ? Text.rich(
                        TextSpan(
                          text: Language.languageList()[index].name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                          children: const [
                            TextSpan(
                              text: ' (Default)',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        Language.languageList()[index].name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
