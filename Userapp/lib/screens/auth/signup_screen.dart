import 'package:country_code_picker/country_code_picker.dart';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/auth_provider.dart';
import 'package:eventright_pro_user/screens/components/button.dart';
import 'package:eventright_pro_user/screens/components/field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late AuthProvider authProvider;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCodePickerController =
      TextEditingController(text: "+92");

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isHidden = true;

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _countryCodePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    authProvider = Provider.of<AuthProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
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
        centerTitle: true,
        title: Text(
          getTranslated(context, AppConstant.signUp).toString(),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: authProvider.registerLoader,
        progressIndicator: const SpinKitCircle(
          color: AppColors.primaryColor,
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.1),
                Text(
                  getTranslated(context, AppConstant.signUpDescription)
                      .toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.inputTextColor,
                    fontFamily: AppFontFamily.poppinsRegular,
                  ),
                ),
                const SizedBox(height: 25),
                Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///email
                      Field(
                          validator: (String? value) {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = RegExp(pattern as String);

                            if (value!.isEmpty) {
                              return getTranslated(
                                  context, AppConstant.pleaseEnterEmail);
                            }
                            if (!regex.hasMatch(value)) {
                              return getTranslated(
                                  context, AppConstant.pleaseEnterValidEmail);
                            }
                            return null;
                          },
                          controller: _emailController,
                          label: getTranslated(context, AppConstant.emailTitle)
                              .toString(),
                          icon: const Icon(Icons.email_outlined),
                          isPassword: false,
                          inputType: TextInputType.emailAddress),

                      ///first name
                      const SizedBox(height: 15),
                      Field(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return getTranslated(
                                  context, AppConstant.pleaseEnterFirstName);
                            }
                            return null;
                          },
                          controller: _firstNameController,
                          label:
                              getTranslated(context, AppConstant.firstNameTitle)
                                  .toString(),
                          icon: const Icon(Icons.person_outline_outlined),
                          isPassword: false,
                          inputType: TextInputType.name),

                      ///last name
                      const SizedBox(height: 15),
                      Field(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return getTranslated(
                                  context, AppConstant.pleaseEnterLastName);
                            }
                            return null;
                          },
                          controller: _lastNameController,
                          label:
                              getTranslated(context, AppConstant.lastNameTitle)
                                  .toString(),
                          icon: const Icon(Icons.person_outline_outlined),
                          isPassword: false,
                          inputType: TextInputType.name),

                      ///password
                      const SizedBox(height: 15),
                      Field(
                          inputFormatter: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z0-9]'))
                          ],
                          onIconClicked: () {
                            setState(() {
                              _isHidden = !_isHidden;
                            });
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return getTranslated(
                                      context, AppConstant.pleaseEnterPassword)
                                  .toString();
                            } else if (value.length < 6) {
                              return getTranslated(
                                      context,
                                      AppConstant
                                          .passwordMustBeAtLeastSixLetter)
                                  .toString();
                            }
                            return null;
                          },
                          controller: _passwordController,
                          label: getTranslated(context, AppConstant.password)
                              .toString(),
                          icon: Icon(
                            _isHidden ? Icons.visibility_off : Icons.visibility,
                          ),
                          isPassword: _isHidden,
                          inputType: TextInputType.name),

                      ///phone
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.primaryColor.withOpacity(0.1),
                        ),
                        width: width * 0.9,
                        child: Row(
                          children: [
                            CountryCodePicker(
                              backgroundColor: AppColors.whiteColor,
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
                              initialSelection:
                                  _countryCodePickerController.text,
                              showFlag: false,
                              favorite: const ['+92', 'PK'],
                              alignLeft: false,
                              padding: EdgeInsets.zero,
                            ),
                            SizedBox(width: width * 0.02),
                            Container(
                              width: width * 0.7,
                              decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: TextFormField(
                                controller: _phoneController,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return getTranslated(context,
                                            AppConstant.pleaseEnterPhoneNumber)
                                        .toString();
                                  }
                                  return null;
                                },
                                cursorColor: AppColors.blackColor,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: AppColors.primaryColor)),
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Text(
                                      getTranslated(
                                              context, AppConstant.phoneTitle)
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.blackColor,
                                        fontFamily: AppFontFamily.poppinsMedium,
                                      ),
                                    ),
                                  ),
                                  suffixIcon: const Icon(Icons.phone_outlined,
                                      color: AppColors.blackColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                InkWell(
                  
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        Map<String, dynamic> body = {
                          "email": _emailController.text,
                          "first_name": _firstNameController.text,
                          "last_name": _lastNameController.text,
                          "password": _passwordController.text,
                          "phone": _phoneController.text,
                          "provider": "LOCAL",
                          "device_token": "",
                          'Countrycode': _countryCodePickerController.text
                        };
                        authProvider.callApiForRegister(body, context);
                      }
                    },
                    child: Button(
                      text:
                          getTranslated(context, AppConstant.signUp).toString(),
                    )),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
