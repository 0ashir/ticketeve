import 'package:country_code_picker/country_code_picker.dart';
import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/auth_provider.dart';
import 'package:eventright_organizer/screens/components/button.dart';
import 'package:eventright_organizer/screens/components/field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late AuthProvider authProvider;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isHidden = true;
  bool _isHidden1 = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCodePickerController =
      TextEditingController(text: "+92");

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _confirmEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fNameController.dispose();
    _lNameController.dispose();
    _phoneController.dispose();
    _countryCodePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);

    double width = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: authProvider.registerLoader,
      progressIndicator: const SpinKitCircle(color: primaryColor),
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primaryColor,
          title: const Text(
            'Sign Up',
            style: TextStyle(
                fontSize: 16,
                fontFamily: AppFontFamily.poppinsMedium,
                color: whiteColor),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: whiteColor),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      getTranslated(context, 'who_are_you').toString(),
                      style: const TextStyle(
                          fontSize: 30,
                          color: blackColor,
                          fontFamily: AppFontFamily.poppinsSemiBold),
                    ),
                  ),
                  Center(
                    child: Text(
                      getTranslated(context, 'tell_us_about').toString(),
                      style: const TextStyle(
                          fontSize: 16,
                          letterSpacing: 0,
                          color: inputTextColor),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Field(
                      validator: (String? value) {
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"),)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = RegExp(pattern as String);

                        if (value!.isEmpty) {
                          return getTranslated(context, 'please_enter_email')
                              .toString();
                        }
                        if (!regex.hasMatch(value)) {
                          return getTranslated(
                                  context, "please_enter_valid_email")
                              .toString();
                        }
                        return null;
                      },
                      controller: _emailController,
                      label: getTranslated(context, 'email_title').toString(),
                      icon: const Icon(Icons.email_outlined),
                      isPassword: false,
                      inputType: TextInputType.emailAddress),
                  const SizedBox(height: 15),
                  Field(
                      validator: (String? value) {
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = RegExp(pattern as String);

                        if (value!.isEmpty) {
                          return getTranslated(
                                  context, 'please_enter_confirm_email')
                              .toString();
                        }
                        if (!regex.hasMatch(value)) {
                          return getTranslated(
                                  context, 'please_enter_valid_email')
                              .toString();
                        } else if (_emailController.text !=
                            _confirmEmailController.text) {
                          return getTranslated(context, 'email_not_match')
                              .toString();
                        }
                        return null;
                      },
                      controller: _confirmEmailController,
                      label: getTranslated(context, 'confirm_email').toString(),
                      icon: const Icon(Icons.email_outlined),
                      isPassword: false,
                      inputType: TextInputType.emailAddress),
                  const SizedBox(height: 15),
                  Field(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return getTranslated(
                                  context, 'please_enter_first_name')
                              .toString();
                        }
                        return null;
                      },
                      controller: _fNameController,
                      label: getTranslated(context, 'first_name').toString(),
                      icon: const Icon(Icons.person_outlined),
                      isPassword: false,
                      inputType: TextInputType.name),
                  const SizedBox(height: 15),
                  Field(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return getTranslated(
                                  context, 'please_enter_last_name')
                              .toString();
                        }
                        return null;
                      },
                      controller: _lNameController,
                      label: getTranslated(context, 'last_name').toString(),
                      icon: const Icon(Icons.person_outlined),
                      isPassword: false,
                      inputType: TextInputType.name),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: primaryColor.withOpacity(0.1),
                    ),
                    width: width * 0.9,
                    child: Row(
                      children: [
                        CountryCodePicker(
                          backgroundColor: whiteColor,
                          showFlagDialog: true,
                          onChanged: (CountryCode countryCode) {
                            if (kDebugMode) {
                              print(countryCode.dialCode);
                            }
                            setState(() {
                              _countryCodePickerController.text =
                                  countryCode.dialCode!;
                            });
                          },
                          initialSelection: _countryCodePickerController.text,
                          showFlag: false,
                          favorite: const ['+92', 'PK'],
                          alignLeft: false,
                          padding: EdgeInsets.zero,
                        ),
                        SizedBox(width: width * 0.02),
                        Container(
                          width: width * 0.7,
                          decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12)),
                          child: TextFormField(
                            controller: _phoneController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return getTranslated(
                                        context, 'please_enter_your_phone')
                                    .toString();
                              }
                              return null;
                            },
                            cursorColor: blackColor,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: primaryColor)),
                              label: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  getTranslated(context, 'phone').toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: blackColor,
                                    fontFamily: AppFontFamily.poppinsMedium,
                                  ),
                                ),
                              ),
                              suffixIcon: const Icon(Icons.phone_outlined,
                                  color: blackColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Field(
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-Z0-9]'),
                      )
                    ],
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
                    controller: _passwordController,
                    label: getTranslated(context, 'password_title').toString(),
                    icon: Icon(
                      _isHidden ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    isPassword: _isHidden,
                    inputType: TextInputType.name,
                    onIconClicked: () {
                      setState(() {
                        _isHidden = !_isHidden;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  Field(
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(
                          RegExp('[a-zA-Z0-9]'),
                        )
                      ],
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return getTranslated(
                                  context, 'please_enter_confirm_password')
                              .toString();
                        } else if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          return getTranslated(
                                  context, 'password_and_confirm_password')
                              .toString();
                        }
                        return null;
                      },
                      controller: _confirmPasswordController,
                      label:
                          getTranslated(context, 'confirm_password').toString(),
                      icon: Icon(
                        _isHidden1 ? Icons.visibility_off : Icons.visibility,
                      ),
                      isPassword: _isHidden1,
                      inputType: TextInputType.name,
                      onIconClicked: () {
                        setState(() {
                          _isHidden1 = !_isHidden1;
                        });
                      }),
                  const SizedBox(height: 35),
                  InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> body = {
                            "email": _emailController.text,
                            "confirm_email": _confirmEmailController.text,
                            "first_name": _fNameController.text,
                            "last_name": _lNameController.text,
                            "phone": _phoneController.text,
                            "password": _passwordController.text,
                            'Countrycode': _countryCodePickerController.text,
                          };
                          authProvider.callApiForRegister(body, context);
                        }
                      },
                      child: Button(
                        text: getTranslated(context, 'get_started_button')
                            .toString(),
                      )),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: width,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                          text:
                              getTranslated(context, 'by_creating_event_right')
                                  .toString(),
                          children: [
                            TextSpan(
                              style: const TextStyle(
                                color: blueColor,
                                fontSize: 11,
                              ),
                              text: getTranslated(context, 'terms_of_service')
                                  .toString(),
                            ),
                            TextSpan(
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                              text: getTranslated(context, 'and').toString(),
                            ),
                            TextSpan(
                              style: const TextStyle(
                                color: blueColor,
                                fontSize: 11,
                              ),
                              text:
                                  getTranslated(context, 'community_guidelines')
                                      .toString(),
                            ),
                            TextSpan(
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                              text: getTranslated(context, 'and_read_the')
                                  .toString(),
                            ),
                            TextSpan(
                              style: const TextStyle(
                                color: blueColor,
                                fontSize: 11,
                              ),
                              text: getTranslated(context, 'privacy_policy')
                                  .toString(),
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
