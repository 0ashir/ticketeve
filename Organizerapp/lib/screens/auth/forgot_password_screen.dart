import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/auth_provider.dart';
import 'package:eventright_organizer/screens/components/button.dart';
import 'package:eventright_organizer/screens/components/field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'sign_in_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late AuthProvider authProvider;

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          backgroundColor: primaryColor,
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ));
            },
            child: const Icon(Icons.arrow_back_ios, color: whiteColor),
          ),
          title: Text(
            getTranslated(context, 'forgot_password_heading').toString(),
            style: const TextStyle(
                fontSize: 16,
                color: whiteColor,
                fontFamily: AppFontFamily.poppinsMedium),
          )),
      body: ModalProgressHUD(
        inAsyncCall: authProvider.forgotLoader,
        progressIndicator: const SpinKitCircle(color: primaryColor),
        offset: Offset(MediaQuery.of(context).size.width * 0.43,
            MediaQuery.of(context).size.height * 0.35),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.1),
                  Center(
                    child: Icon(
                      Icons.lock_clock_outlined,
                      size: 120,
                      color: Colors.grey.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Field(
                      validator: (String? value) {
                        RegExp regex = RegExp(
                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

                        if (value!.isEmpty) {
                          return getTranslated(context, 'please_enter_email')
                              .toString();
                        }
                        if (!regex.hasMatch(value)) {
                          return getTranslated(
                                  context, 'please_enter_valid_email')
                              .toString();
                        }
                        return null;
                      },
                      controller: _emailController,
                      label: getTranslated(context, 'email_hint').toString(),
                      icon: const Icon(Icons.email_outlined),
                      isPassword: false,
                      inputType: TextInputType.emailAddress),
                  const SizedBox(height: 30),
                  InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> body = {
                            "email": _emailController.text,
                          };
                          authProvider.callApiForForgotPassword(body, context);
                        }
                      },
                      child: Button(
                        text:
                            getTranslated(context, 'verify_account').toString(),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Text(
          getTranslated(context, 'forgot_password_description').toString(),
          style: const TextStyle(fontSize: 14, color: inputTextColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
