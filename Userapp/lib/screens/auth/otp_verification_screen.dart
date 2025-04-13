import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/auth_provider.dart';
import 'package:eventright_pro_user/screens/components/button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

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
    authProvider = Provider.of<AuthProvider>(context);
    if (kDebugMode) {
      print(widget.id);
    }
    return ModalProgressHUD(
      inAsyncCall: authProvider.loginLoader,
      progressIndicator: const SpinKitCircle(
        color: AppColors.primaryColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: const Text('Verify Email',
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.whiteColor,
                  fontFamily: AppFontFamily.poppinsMedium)),
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
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
               SizedBox(height: MediaQuery.of(context).size.height * 0.22),
              Text(
                getTranslated(context, AppConstant.verification).toString(),
                style: const TextStyle(
                  fontSize: 30,
                  color: AppColors.blackColor,
                  fontFamily: AppFontFamily.poppinsMedium,
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  // text: getTranslated(context,
                  //         AppConstant.weWillSendYouAOneTimePasswordOnThis)
                  //     .toString(),
                  text: 'We have sent you a verification link on Email',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                    fontFamily: AppFontFamily.poppinsRegular,
                    fontWeight: FontWeight.w300,
                  ),
                  children: [
                    TextSpan(
                      text: " ${widget.email}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontFamily: AppFontFamily.poppinsSemiBold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const Text('  Please click on the link before trying to SignIn',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                    fontFamily: AppFontFamily.poppinsRegular,
                    fontWeight: FontWeight.w300,
                  )),
              // OtpTextField(
              //   numberOfFields: 6,
              //   showFieldAsBox: false,
              //   autoFocus: true,
              //   borderRadius: BorderRadius.circular(4),
              //   cursorColor: AppColors.primaryColor,
              //   disabledBorderColor: AppColors.inputTextColor,
              //   focusedBorderColor: AppColors.primaryColor,
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
                        Map<String, String> body = {
                          "id": widget.id,
                          "otp": otpController.text,
                        };
                        authProvider.callApiVerify(body, context);
                      },
                      child: Button(text: 'OK'.toString()),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            //   InkWell(
            //     onTap: ()=>Navigator.pop,
            //     child: RichText(
            //       text:const  TextSpan(
            //         // text: getTranslated(context, AppConstant.doNotReceiveTheOTP)
            //         //     .toString(),
            //         text: "Didn't receive the Link?  ",
            //         style:  TextStyle(
            //           color: AppColors.blackColor,
            //           fontSize: 12,
            //           fontFamily: AppFontFamily.poppinsRegular,
            //         ),
            //         children: [
            //           TextSpan(
            //             // text:
            //             //     " ${getTranslated(context, AppConstant.resendOtp).toString()}",
            //             text: 'RESEND LINK',
            //             style: const TextStyle(
            //               color: AppColors.primaryColor,
            //               fontSize: 12,
            //               fontWeight: FontWeight.bold,
            //               fontFamily: AppFontFamily.poppinsMedium,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ],
          ]),
        ),
      ),
    );
  }
}
