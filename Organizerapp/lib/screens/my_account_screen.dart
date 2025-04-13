import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/pref_constant.dart';
import 'package:eventright_organizer/constant/preferences.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/auth_provider.dart';
import 'package:eventright_organizer/screens/settings/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../constant/font_constant.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'my_account').toString(),
          style: const TextStyle(
              color: whiteColor,
              fontSize: 16,
              fontFamily: AppFontFamily.poppinsMedium),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: whiteColor, size: 16),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: 10, vertical: MediaQuery.of(context).size.height * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 130,
                height: 130,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        SharedPreferenceHelper.getString(Preferences.image),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SpinKitCircle(
                      color: primaryColor,
                    ),
                    errorWidget: (context, url, error) =>
                        Image.asset("assets/images/NoImage.png"),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${SharedPreferenceHelper.getString(Preferences.firstName)} ${SharedPreferenceHelper.getString(Preferences.lastName)}",
                  style: const TextStyle(
                      fontSize: 18,
                      color: blackColor,
                      fontFamily: AppFontFamily.poppinsMedium),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ));
                  },
                  child: const CircleAvatar(
                      backgroundColor: whiteColor,
                      child:  Icon(Icons.edit, color: blackColor)),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, 'email_title').toString(),
                  style: const TextStyle(fontSize: 16, color: blackColor, fontFamily: AppFontFamily.poppinsRegular),
                ),
                Text(
                  SharedPreferenceHelper.getString(Preferences.email),
                  style: const TextStyle(fontSize: 16, color: inputTextColor, fontFamily: AppFontFamily.poppinsRegular),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, 'contact').toString(),
                  style: const TextStyle(fontSize: 16, color: blackColor, fontFamily: AppFontFamily.poppinsRegular),
                ),
                Text(
                  SharedPreferenceHelper.getString(Preferences.phoneNo),
                  style: const TextStyle(fontSize: 16, color: inputTextColor, fontFamily: AppFontFamily.poppinsRegular),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Bio",
                  style: TextStyle(fontSize: 16, color: blackColor, fontFamily: AppFontFamily.poppinsRegular),
                ),
                const SizedBox(height: 05),
                Text(
                  SharedPreferenceHelper.getString(Preferences.bio),
                  style: const TextStyle(fontSize: 16, color: inputTextColor, fontFamily: AppFontFamily.poppinsRegular),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
