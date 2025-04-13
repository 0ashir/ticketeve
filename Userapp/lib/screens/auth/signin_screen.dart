import 'package:eventright_pro_user/screens/components/button.dart';
import 'package:eventright_pro_user/screens/components/field.dart';
import 'package:eventright_pro_user/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_const_image.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/lang_pref.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/model/setting_model.dart';
import 'package:eventright_pro_user/provider/auth_provider.dart';
import 'package:eventright_pro_user/retrofit/api_client.dart';
import 'package:eventright_pro_user/retrofit/api_header.dart';
import 'package:eventright_pro_user/retrofit/base_model.dart';
import 'package:eventright_pro_user/retrofit/server_error.dart';
import 'package:eventright_pro_user/screens/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AuthProvider authProvider;

  bool? isFirst;
  bool credentialsReadOnly = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _forgotEmailController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkeyForgot = GlobalKey<FormState>();
  bool _isHidden = true;

  AnimationController? _animationController;

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
    callApiForSetting();
  }

  Future<BaseModel<SettingModel>> callApiForSetting() async {
    SettingModel response;
    try {
      response = await RestClient(RetroApi().dioData()).setting();

      if (response.success == true) {
        if (response.data!.onesignalAppId != null) {
          getOneSingleToken(response.data!.onesignalAppId!);
        }
        if (response.data!.currencySymbol != null) {
          SharedPreferenceHelper.setString(
              Preferences.currencySymbol, response.data!.currencySymbol!);
        }

        if (response.data!.currency != null) {
          SharedPreferenceHelper.setString(
              Preferences.currencyCode, response.data!.currency!);
        }
      }
    } catch (error) {
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  @override
  void dispose() {
    if (_animationController != null) _animationController!.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _forgotEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
                isFirst = true;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  getTranslated(context, AppConstant.skipForNow).toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.whiteColor,
                    fontFamily: AppFontFamily.poppinsRegular,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: authProvider.loginLoader,
        progressIndicator: const SpinKitCircle(
          color: AppColors.primaryColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                width: 130,
                height: 130,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppConstantImage.loginLogo),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              const SizedBox(height: 20),
             const  Text('SignIn',
                  style:  TextStyle(
                      fontSize: 30,
                      color: AppColors.primaryColor,
                      fontFamily: AppFontFamily.poppinsMedium)),
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Field(
                          validator: (String? value) {
                            {
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
                            }
                          },
                          inputType: TextInputType.emailAddress,
                          controller: _emailController,
                          label: getTranslated(context, AppConstant.emailTitle)
                              .toString(),
                          icon: const Icon(Icons.email_outlined),
                          isPassword: credentialsReadOnly),
                      const SizedBox(height: 20),
                      Field(
                        controller: _passwordController,
                        label: getTranslated(context, AppConstant.password)
                            .toString(),
                        icon: Icon(
                          _isHidden ? Icons.visibility_off : Icons.visibility,
                        ),
                        isPassword: _isHidden,
                        inputType: TextInputType.name,
                        onIconClicked: () {
                          setState(() {
                            _isHidden = !_isHidden;
                          });
                        },
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9]'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: TextButton(
                    onPressed: () {
                      _animationController =
                          BottomSheet.createAnimationController(this);
                      showRemoveDecrementDialog();
                    },
                    child: Text(
                      getTranslated(context, AppConstant.forgotPassword)
                          .toString(),
                      style: const TextStyle(
                        color: AppColors.blueColor,
                        fontSize: 16,
                        fontFamily: AppFontFamily.poppinsMedium,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        Map<String, dynamic> body = {
                          "email": _emailController.text.trim(),
                          "password": _passwordController.text,
                          "provider": "LOCAL",
                          "device_token": SharedPreferenceHelperUtils.getString(
                              Preferences.onesignalPushToken)
                        };
                        authProvider.callApiForLogin(body, context);
                      }
                    },
                    child: Button(
                      text: getTranslated(context, AppConstant.signInButton)
                          .toString(),
                    )),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: AppColors.inputTextColor,
                      fontSize: 12,
                      fontFamily: AppFontFamily.poppinsMedium,
                    ),
                    text: getTranslated(context, AppConstant.donHaveAnAccount)
                        .toString(),
                    children: [
                      TextSpan(
                        style: const TextStyle(
                          color: AppColors.blueColor,
                          fontSize: 12,
                          fontFamily: AppFontFamily.poppinsBold,
                        ),
                        text: getTranslated(context, AppConstant.signUp)
                            .toString(),
                      ),
                    ],
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUp(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showRemoveDecrementDialog() {
    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        transitionAnimationController: _animationController,
        builder: (
          context,
        ) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: AppColors.primaryColor,
                  padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getTranslated(context, AppConstant.forgotPasswordTitle)
                            .toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.whiteColor,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Form(
                      key: _formkeyForgot,
                      child: Field(
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
                          controller: _forgotEmailController,
                          label: getTranslated(context, AppConstant.emailTitle)
                              .toString(),
                          icon: const Icon(Icons.email_outlined),
                          isPassword: false,
                          inputType: TextInputType.emailAddress)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    top: 20,
                  ),
                  child: InkWell(
                    onTap: () {
                      if (_formkeyForgot.currentState!.validate()) {
                        Map<String, String> body = {
                          "email": _forgotEmailController.text
                        };
                        authProvider.callForgotPassword(body).then((value) {
                          if (value.data!.success == true) {
                            _forgotEmailController.clear();
                            Navigator.of(context).pop();
                          }
                        });
                      }
                    },
                   
                    child: Button(text: getTranslated(context, AppConstant.resetPassword)
                          .toString(),)
                  ),
                ),
              ],
            ),
          );
        });
  }

  getOneSingleToken(String appId) async {
    String? userId = '';
    OneSignal.shared.consentGranted(true);
    await OneSignal.shared.setAppId(appId);
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
    OneSignal.shared.promptLocationPermission();
    var status = await (OneSignal.shared.getDeviceState());
    userId = status!.userId;
    if (kDebugMode) {
      print("One Signal Token :$userId");
    }
    if (SharedPreferenceHelperUtils.getString(Preferences.onesignalPushToken) ==
            "" ||
        SharedPreferenceHelperUtils.getString(Preferences.onesignalPushToken) ==
            "N/A") {
      if (userId != null) {
        SharedPreferenceHelperUtils.setString(
            Preferences.onesignalPushToken, userId);
      } else {
        SharedPreferenceHelperUtils.setString(
            Preferences.onesignalPushToken, '');
      }
    }
  }
}
