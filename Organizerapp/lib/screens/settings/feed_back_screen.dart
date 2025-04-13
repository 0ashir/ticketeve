import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/common_function.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/setting_provider.dart';
import 'package:eventright_organizer/screens/components/button.dart';
import 'package:eventright_organizer/screens/components/desc_field.dart';
import 'package:eventright_organizer/screens/components/field.dart';
import 'package:eventright_organizer/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  late SettingProvider settingProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double? rate;

  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _emailController.dispose();
    super.dispose();
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
          getTranslated(context, 'feed_back_support').toString(),
          style: const TextStyle(
              fontSize: 16,
              color: whiteColor,
              fontFamily: AppFontFamily.poppinsMedium),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: settingProvider.faqLoader,
        progressIndicator: const SpinKitCircle(color: primaryColor),
        offset: Offset(MediaQuery.of(context).size.width * 0.43,
            MediaQuery.of(context).size.height * 0.35),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: RatingBar.builder(
                      initialRating: 0,
                      glowColor: whiteColor,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return const Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: primaryColor,
                            );
                          case 1:
                            return const Icon(
                              Icons.sentiment_dissatisfied,
                              color: primaryColor,
                            );
                          case 2:
                            return const Icon(
                              Icons.sentiment_neutral,
                              color: primaryColor,
                            );
                          case 3:
                            return const Icon(
                              Icons.sentiment_satisfied,
                              color: primaryColor,
                            );
                          case 4:
                            return const Icon(
                              Icons.sentiment_very_satisfied,
                              color: primaryColor,
                            );
                        }
                        return Container();
                      },
                      onRatingUpdate: (rating) {
                        rate = rating;
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  DescField(
                      controller: _messageController,
                      label:
                          getTranslated(context, 'add_experience').toString()),
                  const SizedBox(height: 10),
                  Field(controller: _emailController, label: getTranslated(context, 'email_address').toString(), icon: const Icon(Icons.email_outlined), isPassword: false, inputType: TextInputType.emailAddress)
         ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          if (rate != null) {
            if (_formKey.currentState!.validate()) {
              Map<String, dynamic> body = {
                "email": _emailController.text,
                "message": _messageController.text,
                "rate": rate
              };
              settingProvider.callApiForAddFeedBack(body).then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ));
              });
            }
          } else {
            CommonFunction.toastMessage("Please Assign Rating");
          }
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: primaryColor),
          child: Button(text:  getTranslated(context, 'share_feed_back').toString()),
        ),
      ),
    );
  }
}
