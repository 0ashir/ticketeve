import 'package:event_right_scanner/DeviceUtil/fonts.dart';
import 'package:event_right_scanner/Screen/Components/button.dart';
import 'package:event_right_scanner/Screen/Components/field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:event_right_scanner/DeviceUtil/palette.dart';
import 'package:flutter/material.dart';
import 'package:event_right_scanner/Providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isHidden = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  late AuthProvider authProviderRef;
  bool credentialsReadOnly = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, authProviderRef, __) {
        return ModalProgressHUD(
          inAsyncCall: authProviderRef.authLoader,
          opacity: 0.5,
          progressIndicator: const SpinKitPulse(
            color: Palette.primary,
            size: 50.0,
          ),
          child: Scaffold(
            backgroundColor: Palette.white,
            appBar: AppBar(
                backgroundColor: Palette.primary,
                centerTitle: true,
                title: const Text('LogIn',
                    style: TextStyle(
                        fontSize: 16,
                        color: Palette.white,
                        fontFamily: AppFontFamily.poppinsMedium))),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: ListView(
                  children: [
                     SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    const Center(
                      child: Text(
                        "Hey Scanner!",
                        style: TextStyle(
                            color: Palette.black,
                            fontSize: 28,
                            fontFamily: AppFontFamily.poppinsMedium),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Login with your account to check attendees In.",
                      style: TextStyle(
                          color: Palette.darkGrey,
                          fontSize: 16,
                          letterSpacing: -1,
                          fontFamily: AppFontFamily.poppinsMedium),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Field(
                        controller: email,
                        label: "Email",
                        icon: const Icon(Icons.mail_outline_outlined),
                        isPassword: false,
                        inputType: TextInputType.emailAddress),
                    const SizedBox(
                      height: 10,
                    ),
                    Field(
                        onIconClicked: () {
                          setState(() {
                            _isHidden = !_isHidden;
                          });
                        },
                        controller: password,
                        label: "Password",
                        icon: Icon(
                          _isHidden ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black.withOpacity(0.6),
                        ),
                        isPassword: _isHidden,
                        inputType: TextInputType.text),
                    const SizedBox(
                      height: 60,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            Map<String, dynamic> body = {
                              "email": email.text,
                              "password": password.text,
                            };
                            authProviderRef.callLogin(body, context);
                          });
                        },
                        child: const Button(text: 'Login')),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
