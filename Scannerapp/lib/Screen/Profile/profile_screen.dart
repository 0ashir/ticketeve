import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_right_scanner/DeviceUtil/fonts.dart';
import 'package:event_right_scanner/Providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:event_right_scanner/DeviceUtil/app_string.dart';
import 'package:event_right_scanner/DeviceUtil/palette.dart';
import 'package:event_right_scanner/localization/localization_constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileProvider profileProviderRef;

  @override
  void initState() {
    profileProviderRef = Provider.of<ProfileProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 0), () {
      profileProviderRef.callApiProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (_, profileProviderRef, __) {
        return ModalProgressHUD(
          inAsyncCall: profileProviderRef.profileLoader,
          opacity: 0.5,
          progressIndicator: const SpinKitPulse(
            color: Palette.primary,
            size: 50.0,
          ),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Palette.primary,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Palette.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              title: Text(
                  // myAccount,
                  getTranslated(context, myAccount).toString(),
                  style: const TextStyle(
                      color: Palette.white,
                      fontFamily: AppFontFamily.poppinsMedium,
                      fontSize: 16)),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(70),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: profileProviderRef.image,
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const SpinKitFadingCircle(color: Palette.primary),
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/images/NoImage.png",
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    profileProviderRef.name,
                    style: const TextStyle(color: Palette.black, fontFamily: AppFontFamily.poppinsMedium, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 25.w,
                          child: Text(
                            // email,
                            getTranslated(context, email).toString(),
                            style: const TextStyle(color: Palette.black, fontFamily: AppFontFamily.poppinsMedium, fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            profileProviderRef.email,
                            textAlign: TextAlign.end,
                            style: const TextStyle(color: Palette.black, fontFamily: AppFontFamily.poppinsMedium, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.4),
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 25.w,
                          child: Text(
                            // phone,
                            getTranslated(context, phone).toString(),
                            style: const TextStyle(color: Palette.black, fontFamily: AppFontFamily.poppinsMedium, fontSize: 14)
                          ),
                        ),
                        Expanded(
                          child: Text(
                            profileProviderRef.phone,
                            textAlign: TextAlign.end,
                            style: const TextStyle(color: Palette.black, fontFamily: AppFontFamily.poppinsMedium, fontSize: 14)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.4),
                    thickness: 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
