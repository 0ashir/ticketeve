import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../constant/font_constant.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  late SettingProvider settingProvider;

  @override
  void initState() {
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      settingProvider.callApiForFaq();
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
        title:const Text(
          "FAQ's",
          style:  TextStyle(fontSize: 16, color: whiteColor, fontFamily: AppFontFamily.poppinsMedium)
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: settingProvider.faqLoader,
        progressIndicator: const SpinKitCircle(color: primaryColor),
        offset: Offset(MediaQuery.of(context).size.width * 0.43, MediaQuery.of(context).size.height * 0.35),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: settingProvider.faqs.isNotEmpty
              ? ListView.separated(
                  itemCount: settingProvider.faqs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Theme(
                      data: ThemeData(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        leading: const Icon(Icons.question_answer, color: primaryColor),
                        title: Text(
                          settingProvider.faqs[index].question!,
                          style: const TextStyle(fontSize: 15, color: blackColor),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              settingProvider.faqs[index].answer!,
                              style: const TextStyle(color: inputTextColor, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                )
              : Center(
                  child: Text(getTranslated(context, 'no_data_found').toString()),
                ),
        ),
      ),
    );
  }
}
