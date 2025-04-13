import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/auth_provider.dart';
import 'package:eventright_organizer/screens/auth/forgot_password_screen.dart';
import 'package:eventright_organizer/screens/auth/sign_up_screen.dart';
import 'package:eventright_organizer/screens/components/button.dart';
import 'package:eventright_organizer/screens/components/field.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../constant/font_constant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late AuthProvider authProvider;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  final bool _isCredentialReadOnly = false;

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);


    return Scaffold(
       backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text(
          'Sign In',
          style:  TextStyle(
              fontFamily: AppFontFamily.poppinsMedium,
              fontSize: 16,
              color: whiteColor),
        ),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: authProvider.loginLoader,
          progressIndicator: const SpinKitCircle(color: primaryColor),
          offset: Offset(MediaQuery.of(context).size.width * 0.43,
              MediaQuery.of(context).size.height * 0.35),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    Center(
                      child: Text(
                        "${getTranslated(context, 'hello')}, ${getTranslated(context, 'organizer')}!",
                        style: const TextStyle(
                            fontSize: 30,
                            color: blackColor,
                            fontFamily: AppFontFamily.poppinsSemiBold),
                      ),
                    ),
                    Center(
                      child: Text(
                        getTranslated(context, 'sign_in_description_login')
                            .toString(),
                        style: const TextStyle(
                            fontSize: 16,
                            letterSpacing: 0,
                            color: inputTextColor),
                      ),
                    ),
                     SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    Field(
                      inputType: TextInputType.emailAddress,
                      readOnly: _isCredentialReadOnly,
                      validator: (String? value) {
                        RegExp emailRegex = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                        if (value!.isEmpty) {
                          return getTranslated(context, 'please_enter_email')
                              .toString();
                        }
                        if (!emailRegex.hasMatch(value)) {
                          return getTranslated(
                                  context, 'please_enter_valid_email')
                              .toString();
                        }
                        return null;
                      },
                      controller: _emailController,
                      label: getTranslated(context, 'email_title').toString(),
                      isPassword: false,
                      icon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 15),
                    Field(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return getTranslated(context, 'please_enter_password')
                              .toString();
                        } else if (value.length < 6) {
                          return getTranslated(
                                  context, 'please_enter_valid_password')
                              .toString();
                        }
                        return null;
                      },
                      readOnly: _isCredentialReadOnly,
                      controller: _passwordController,
                      label:
                          getTranslated(context, 'password_title').toString(),
                      icon: Icon(
                        _isHidden ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      isPassword: _isHidden,
                      inputType: TextInputType.text,
                      onIconClicked: () {
                        setState(() {
                          _isHidden = !_isHidden;
                        });
                      },
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(
                          RegExp('[a-zA-Z0-9]'),
                        )
                      ],
                    ),
                    const SizedBox(height: 05),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ));
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          getTranslated(context, 'forgot_password').toString(),
                          style:
                              const TextStyle(color: blueColor, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    InkWell(
                        onTap: () async{
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> body = {
                              "email": _emailController.text,
                              "password": _passwordController.text,
                              "device_token": await FirebaseMessaging.instance.getToken()
                            };
                            authProvider.callApiForLogin(body, context);
                          }
                        },
                        child: Button(
                          text: getTranslated(context, 'get_started_button')
                              .toString(),
                        )),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ));
                      },
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                              text: getTranslated(context, 'don_t_have_account')
                                  .toString(),
                              children: [
                                TextSpan(
                                  style: const TextStyle(
                                    color: blueColor,
                                    fontSize: 12,
                                  ),
                                  text: getTranslated(context, 'sign_up')
                                      .toString(),
                                )
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
