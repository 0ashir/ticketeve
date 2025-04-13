import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/setting_provider.dart';
import 'package:eventright_organizer/screens/components/button.dart';
import 'package:eventright_organizer/screens/components/field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late SettingProvider settingProvider;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isHidden = true;
  bool _isHidden1 = true;
  bool _isHidden2 = true;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
          getTranslated(context, 'change_password').toString(),
          style: const TextStyle(
              color: whiteColor,
              fontSize: 16,
              fontFamily: AppFontFamily.poppinsMedium),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildForm(context),
                  const SizedBox(height: 15),
                ],
              ),
              const SizedBox(height: 30),
              InkWell(
                  onTap: () {
                    setState(() {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> body = {
                          "old_password": _passwordController.text,
                          "password": _newPasswordController.text,
                          "password_confirmation":
                              _confirmPasswordController.text
                        };
                        settingProvider.callApiForChangePassword(body);
                      }
                    });
                  },
                  child: Button(
                    text: getTranslated(context, 'change_password').toString(),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Field(
            validator: (value) {
              if (value!.isEmpty) {
                return getTranslated(context, 'please_enter_old_password')
                    .toString();
              } else if (value.length < 6) {
                return getTranslated(context, 'password_must_be_at_least')
                    .toString();
              }
              return null;
            },
            controller: _passwordController,
            label: getTranslated(context, 'enter_old_password').toString(),
            icon: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
              color: blackColor,
            ),
            isPassword: _isHidden,
            inputType: TextInputType.text,
            onIconClicked: () {
              setState(() {
                _isHidden = !_isHidden;
              });
            },
          ),
          const SizedBox(height: 15),
          Field(
            validator: (value) {
              if (value!.isEmpty) {
                return getTranslated(context, 'please_enter_new_password')
                    .toString();
              } else if (value.length < 6) {
                return getTranslated(context, 'password_must_be_at_least')
                    .toString();
              }
              return null;
            },
            controller: _newPasswordController,
            label: getTranslated(context, 'enter_new_password').toString(),
            icon: Icon(
              _isHidden1 ? Icons.visibility : Icons.visibility_off,
              color: blackColor,
            ),
            isPassword: _isHidden1,
            inputType: TextInputType.text,
            onIconClicked: () {
              setState(() {
                _isHidden1 = !_isHidden1;
              });
            },
          ),
          const SizedBox(height: 15),
          Field(
            validator: (value) {
              if (value!.isEmpty) {
                return getTranslated(context, 'please_enter_confirm_password')
                    .toString();
              } else if (value.length < 6) {
                return getTranslated(context, 'password_must_be_at_least')
                    .toString();
              } else if (_newPasswordController.text !=
                  _confirmPasswordController.text) {
                return getTranslated(context, 'new_and_confirm_not_match')
                    .toString();
              }
              return null;
            },
            controller: _confirmPasswordController,
            label: getTranslated(context, 'enter_confirm_password').toString(),
            icon: Icon(
              _isHidden2 ? Icons.visibility : Icons.visibility_off,
              color: blackColor,
            ),
            isPassword: _isHidden2,
            inputType: TextInputType.text,
            onIconClicked: () {
              setState(() {
                _isHidden2 = !_isHidden2;
              });
            },
          )
        ],
      ),
    );
  }
}
