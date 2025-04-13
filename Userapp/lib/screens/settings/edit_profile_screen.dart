import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_const_image.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/setting_provider.dart';
import 'package:eventright_pro_user/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late SettingProvider settingProvider;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    settingProvider = Provider.of(context, listen: false);
    _firstNameController.text = SharedPreferenceHelper.getString(Preferences.fName);
    _lastNameController.text = SharedPreferenceHelper.getString(Preferences.lName);
    _phoneController.text = SharedPreferenceHelper.getString(Preferences.phoneNo);
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of<SettingProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
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
          getTranslated(context, AppConstant.editProfile).toString(),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Map<String, dynamic> body = {"name": _firstNameController.text, "last_name": _lastNameController.text};
              settingProvider.callApiForUpdateProfile(body).then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(index: 3),
                  ),
                );
              });
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Center(
              child: SizedBox(
                height: 100,
                width: 110,
                child: Stack(
                  children: [
                    settingProvider.proImage != null
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
                                settingProvider.proImage!,
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
                                imageUrl: SharedPreferenceHelper.getString(Preferences.image),
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const SpinKitSpinningLines(
                                  color: AppColors.primaryColor,
                                ),
                                errorWidget: (context, url, error) => Image.asset(AppConstantImage.noImageUser),
                              ),
                            ),
                          ),
                    Positioned(
                      top: 62,
                      left: 70,
                      child: GestureDetector(
                        onTap: () {
                          settingProvider.chooseProfileImage(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                            border: Border.all(color: AppColors.primaryColor),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            radius: 15,
                            
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColors.whiteColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4,),
            Text(
              "${SharedPreferenceHelper.getString(Preferences.fName)} ${SharedPreferenceHelper.getString(Preferences.lName)}",
              style: const TextStyle(
                fontSize: 20,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
                fontFamily: AppFontFamily.poppinsMedium,
              ),
            ),
            const SizedBox(height: 25),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(02),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getTranslated(context, AppConstant.firstNameTitle).toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: AppFontFamily.poppinsMedium,
                                    ),
                                  ),
                                  const SizedBox(width: 10)
                                ],
                              ),
                            ),
                            hintText: getTranslated(context, AppConstant.enterYourFirstName).toString(),
                            hintStyle: const TextStyle(
                              color: AppColors.inputTextColor,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getTranslated(context, AppConstant.lastNameTitle).toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: AppFontFamily.poppinsMedium,
                                    ),
                                  ),
                                  const SizedBox(width: 10)
                                ],
                              ),
                            ),
                            hintText: getTranslated(context, AppConstant.enterYourLastName).toString(),
                            hintStyle: const TextStyle(
                              color: AppColors.inputTextColor,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _phoneController,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getTranslated(context, AppConstant.phoneTitle).toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: AppFontFamily.poppinsMedium,
                                    ),
                                  ),
                                  const SizedBox(width: 10)
                                ],
                              ),
                            ),
                            hintText: getTranslated(context, AppConstant.enterYourPhoneNumber).toString(),
                            hintStyle: const TextStyle(
                              color: AppColors.inputTextColor,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
