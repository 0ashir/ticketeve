import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../constant/font_constant.dart';
import '../components/button.dart';
import 'sign_in_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final String id;
  final String otp;
  const OtpVerificationScreen(
      {super.key, required this.email, required this.id, required this.otp});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController otpController = TextEditingController();

  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(
      context,
    );
    if (kDebugMode) {
      print(widget.id);
    }
    return ModalProgressHUD(
      inAsyncCall: authProvider.loginLoader,
      progressIndicator: const SpinKitCircle(
        color: primaryColor,
      ),
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: const Text('Verify Email',
              style: TextStyle(
                  fontSize: 16,
                  color: whiteColor,
                  fontFamily: AppFontFamily.poppinsMedium)),
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
              size: 18,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              Text(
                getTranslated(context, 'verification').toString(),
                style: const TextStyle(
                  fontSize: 26,
                  fontFamily: AppFontFamily.poppinsMedium,
                  color: blackColor,
                ),
              ),
              RichText(
                text: TextSpan(
                  text:
                      'We have sent you a Verification link on this Email. Please click on the verification link before trying to SignIn',
                  style: const TextStyle(
                    fontSize: 12,
                    color: blackColor,
                    fontWeight: FontWeight.w300,
                  ),
                  children: [
                    TextSpan(
                      text: " ${widget.email}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              widget.otp.isNotEmpty && widget.otp != "null"
                  ? Text("Your OTP is :${widget.otp}")
                  : const SizedBox(),
              // OtpTextField(
              //   numberOfFields: 6,
              //   showFieldAsBox: false,
              //   autoFocus: true,
              //   borderRadius: BorderRadius.circular(4),
              //   cursorColor: primaryColor,
              //   disabledBorderColor: inputTextColor,
              //   focusedBorderColor: primaryColor,
              //   onCodeChanged: (String code) {},
              //   onSubmit: (String verificationCode) {
              //     otpController.text = verificationCode;
              //   }, // end onSubmit
              // ),

              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // Map<String, String> body = {
                        //   "id": widget.id,
                        //   "otp": otpController.text,
                        // };
                        // authProvider.callApiVerify(body, context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      },
                      child: const Button(text: 'OK'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
