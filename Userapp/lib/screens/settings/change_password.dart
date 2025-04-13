import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/auth_provider.dart';
import 'package:eventright_pro_user/screens/components/button.dart';
import 'package:eventright_pro_user/screens/components/field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late AuthProvider authProvider;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isHidden = true;
  bool _isHidden1 = true;
  bool _isHidden2 = true;

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);

    return ModalProgressHUD(
      inAsyncCall: authProvider.changePasswordLoader,
      progressIndicator: const SpinKitCircle(
        color: AppColors.primaryColor,
      ),
      child: Scaffold(
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
            getTranslated(context, AppConstant.changePassword).toString(),
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.whiteColor,
              fontFamily: AppFontFamily.poppinsMedium,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
                      Map<String, dynamic> body = {"old_password": _oldPasswordController.text, "password": _newPasswordController.text, "password_confirmation": _confirmPasswordController.text};
                      if (kDebugMode) {
                        print(body);
                      }
                      authProvider.callApiForChangePassword(body).then((value) {
                        if (value.data!.success == true) {
                          Navigator.of(context).pop();
                        }
                      });
                    }
                  });
                },
                
               
                child: Button(text:  getTranslated(context,AppConstant.changePassword).toString(),)
               
              ),
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
                return getTranslated(context, AppConstant.pleaseEnterOldPassword).toString();
              } else if (value.length < 6) {
                return getTranslated(context, AppConstant.passwordMustBeAtLeastSixLetter).toString();
              }
              return null;
            },
            controller: _oldPasswordController, label: getTranslated(context, AppConstant.enterYourOldPassword).toString(), icon: Icon(
                  _isHidden ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.blackColor,
                ), isPassword: _isHidden, inputType: TextInputType.text, onIconClicked: () {
                  setState(() {
                    _isHidden=!_isHidden;
                  });
                },)
    ,  const SizedBox(height: 15),
    Field(
       validator: (value) {
              if (value!.isEmpty) {
                return getTranslated(context, AppConstant.pleaseEnterNewPassword).toString();
              } else if (value.length < 6) {
                return getTranslated(context, AppConstant.passwordMustBeAtLeastSixLetter).toString();
              }
              return null;
            },
      controller: _newPasswordController, label: getTranslated(context, AppConstant.enterYourNewPassword).toString(), icon: Icon(
                  _isHidden1  ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.blackColor,
                ),onIconClicked: (){
                  setState(() {
                    _isHidden1 = !_isHidden1;
                  });
                }, isPassword: _isHidden1, inputType: TextInputType.text),
   const SizedBox(height: 15),
   Field(
        validator: (value) {
              if (value!.isEmpty) {
                return getTranslated(context, AppConstant.pleaseEnterConfirmPassword).toString();
              } else if (value.length < 6) {
                return getTranslated(context, AppConstant.passwordMustBeAtLeastSixLetter).toString();
              } else if (_newPasswordController.text != _confirmPasswordController.text) {
                return getTranslated(context, AppConstant.newPasswordAndConfirmPasswordDoesNotMatch).toString();
              }
              return null;
            },
    controller: _confirmPasswordController, label: getTranslated(context, AppConstant.enterYourConfirmPassword).toString(), icon: Icon(
                  _isHidden2   ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.blackColor,
                ), isPassword: _isHidden2, inputType: TextInputType.text,onIconClicked: () {
                   setState(() {
                    _isHidden2 = !_isHidden2;
                  });
                },)
],
      ),
    );
  }
}
