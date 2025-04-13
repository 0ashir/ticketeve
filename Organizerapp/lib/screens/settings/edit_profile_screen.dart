import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/constant/pref_constant.dart';
import 'package:eventright_organizer/constant/preferences.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/auth_provider.dart';
import 'package:eventright_organizer/screens/components/desc_field.dart';
import 'package:eventright_organizer/screens/components/field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AuthProvider authProvider;

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    _fNameController.text =
        SharedPreferenceHelper.getString(Preferences.firstName);
    _lNameController.text =
        SharedPreferenceHelper.getString(Preferences.lastName);
    _emailController.text = SharedPreferenceHelper.getString(Preferences.email);
    _phoneController.text =
        SharedPreferenceHelper.getString(Preferences.phoneNo);
      
    _bioController.text = SharedPreferenceHelper.getString(Preferences.bio);
    super.initState();
  }

  @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'edit_profile').toString(),
          style: const TextStyle(
              color: whiteColor,
              fontSize: 16,
              fontFamily: AppFontFamily.poppinsMedium),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: authProvider.profileLoader,
        progressIndicator: const SpinKitCircle(color: primaryColor),
        offset: Offset(MediaQuery.of(context).size.width * 0.43,
            MediaQuery.of(context).size.height * 0.35),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: MediaQuery.of(context).size.height * 0.1),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: 100,
                      width: 110,
                      child: Stack(
                        children: [
                          authProvider.proImage != null
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    child: Image.file(
                                      authProvider.proImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    color: Colors.grey.withAlpha(30),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          SharedPreferenceHelper.getString(
                                              Preferences.image),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const SpinKitCircle(
                                        color: primaryColor,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              "assets/images/NoImage.png"),
                                    ),
                                  ),
                                ),
                          Positioned(
                            top: 64,
                            left: 72,
                            child: GestureDetector(
                              onTap: () {
                                authProvider.chooseProfileImage(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  border: Border.all(color: primaryColor),
                                ),
                                child: const CircleAvatar(
                                  backgroundColor: primaryColor,
                                  radius: 12,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: whiteColor,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Field(
                      controller: _fNameController,
                      label: getTranslated(context, 'first_name').toString(),
                      icon: const Icon(Icons.person_outline_outlined),
                      isPassword: false,
                      inputType: TextInputType.name),
                  const SizedBox(height: 10),
                  Field(
                      controller: _lNameController,
                      label: getTranslated(context, 'last_name').toString(),
                      icon: const Icon(Icons.person_outline_outlined),
                      isPassword: false,
                      inputType: TextInputType.name),
                  const SizedBox(height: 10),
                  Field(
                      controller: _emailController,
                      label: getTranslated(context, 'email_title').toString(),
                      icon: const Icon(Icons.email_outlined),
                      isPassword: false,
                      inputType: TextInputType.emailAddress),
                  
                  const SizedBox(height: 10),
                  DescField(controller: _bioController, label:  getTranslated(context, 'bio').toString())
                ,const SizedBox(height: 35),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> body = {
                          "first_name": _fNameController.text,
                          "last_name": _lNameController.text,
                          "phone": _phoneController.text,
                          "email": _emailController.text,
                          "bio": _bioController.text
                        };

                        authProvider.callApiForEditProfile(body, context);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        getTranslated(context, 'save').toString(),
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
