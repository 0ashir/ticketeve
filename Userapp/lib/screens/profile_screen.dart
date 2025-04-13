import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_const_image.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/events_provider.dart';
import 'package:eventright_pro_user/provider/order_provider.dart';
import 'package:eventright_pro_user/provider/setting_provider.dart';
import 'package:eventright_pro_user/screens/components/button.dart';
import 'package:eventright_pro_user/screens/settings/change_language_screen.dart';
import 'package:eventright_pro_user/screens/settings/change_password.dart';
import 'package:eventright_pro_user/screens/settings/edit_profile_screen.dart';
import 'package:eventright_pro_user/screens/settings/following_screen.dart';
import 'package:eventright_pro_user/screens/settings/notification_center.dart';
import 'package:eventright_pro_user/screens/settings/organizer_screen.dart';
import 'package:eventright_pro_user/screens/settings/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SettingProvider settingProvider;
  late OrderProvider orderProvider;
  late EventProvider eventProvider;

  int? value;
  int myTicket = 0;
  String selectedLanguage = "";

  @override
  void initState() {
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    eventProvider = Provider.of<EventProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      settingProvider.callApiForFollowing();
      orderProvider.callApiForOrders();
      eventProvider.callApiForFavorite();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of<SettingProvider>(context);
    orderProvider = Provider.of<OrderProvider>(context);
    eventProvider = Provider.of<EventProvider>(context);

    myTicket =
        orderProvider.upcomingData.length + orderProvider.pastData.length;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          // getTranslated(context, AppConstant.profile).toString(),
          'Profile',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: CachedNetworkImage(
                          imageUrl: SharedPreferenceHelper.getString(
                              Preferences.image),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SpinKitCircle(
                            color: AppColors.primaryColor,
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset(AppConstantImage.noImageUser),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "${SharedPreferenceHelper.getString(Preferences.fName)} ${SharedPreferenceHelper.getString(Preferences.lName)}",
                  style: const TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFontFamily.poppinsMedium,
                  ),
                ),
              ),
              const SizedBox(height: 05),
              Center(
                child: Text(
                  SharedPreferenceHelper.getString(Preferences.email),
                  style: const TextStyle(
                    fontFamily: AppFontFamily.poppinsMedium,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          eventProvider.favoriteData.length.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.blackColor,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        ),
                        Text(
                          getTranslated(context, AppConstant.likes).toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.inputTextColorDark,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          myTicket.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.blackColor,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        ),
                        Text(
                          getTranslated(context, AppConstant.myTickets)
                              .toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.inputTextColorDark,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FollowingScreen(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            '${settingProvider.followingData.length}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.blackColor,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                          ),
                          Text(
                            getTranslated(context, AppConstant.following)
                                .toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.inputTextColorDark,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.notifications,
                        color: AppColors.primaryColor,
                        size: 16,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        getTranslated(context, AppConstant.notificationCenter)
                            .toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.blackColor,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              if (settingProvider.wallet == 1)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WalletScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet_rounded,
                          color: AppColors.primaryColor,
                          size: 16,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          getTranslated(context, AppConstant.myWallet)
                              .toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.blackColor,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated(context, AppConstant.settings).toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.primaryColor,
                        fontFamily: AppFontFamily.poppinsMedium,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen(),
                                ),
                              );
                            },
                            child: generalEntry(
                                context: context,
                                text: AppConstant.editProfile)),

                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OrganizerScreen(),
                                ),
                              );
                            },
                            child: generalEntry(
                                context: context,
                                text: AppConstant.organizers)),

                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChangePassword(),
                                ),
                              );
                            },
                            child: generalEntry(
                                context: context,
                                text: AppConstant.changePassword)),
                        // const Divider(height: 1, thickness: 1),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangeLanguageScreen(),
                                ),
                              );
                            },
                            child: generalEntry(
                                context: context,
                                text: AppConstant.changeLanguageTitle)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      getTranslated(context, AppConstant.legal).toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.primaryColor,
                        fontFamily: AppFontFamily.poppinsMedium,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () async {
                              final uri = Uri.parse(settingProvider.privacy);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              } else {
                                CommonFunction.toastMessage(
                                    "URL not provided by server");
                              }
                            },
                            child: generalEntry(
                                context: context, text: AppConstant.privacy)),
                        // const Divider(height: 1, thickness: 1),
                        // InkWell(
                        //     onTap: () async {
                        //       final uri = Uri.parse(settingProvider.terms);
                        //       if (await canLaunchUrl(uri)) {
                        //         await launchUrl(uri);
                        //       } else {
                        //         CommonFunction.toastMessage(
                        //             "URL not provided by server");
                        //       }
                        //     },
                        //     child: generalEntry(
                        //         context: context,
                        //         text: AppConstant.termsOfServices)),
                        // const Divider(height: 1, thickness: 1),

                        // const Divider(height: 1, thickness: 1),
                        // InkWell(
                        //     onTap: () async {
                        //       final uri =
                        //           Uri.parse(settingProvider.acknowledgement);
                        //       if (await canLaunchUrl(uri)) {
                        //         await launchUrl(uri);
                        //       } else {
                        //         CommonFunction.toastMessage(
                        //             "URL not provided by server");
                        //       }
                        //     },
                        //     child: generalEntry(
                        //         context: context,
                        //         text: "FAQ's")),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      getTranslated(context, AppConstant.about).toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.primaryColor,
                        fontFamily: AppFontFamily.poppinsMedium,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(06),
                          child: Text(
                            '${getTranslated(context, AppConstant.version)} ${settingProvider.version}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                          ),
                        ),
                        // const Divider(height: 1, thickness: 1),
                        InkWell(
                            onTap: () async {
                              final uri = Uri.parse(settingProvider.help);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              } else {
                                CommonFunction.toastMessage(
                                    "URL not provided by server");
                              }
                            },
                            child: generalEntry(
                                context: context,
                                text: AppConstant.helpCenter)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  elevation: 0.5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  backgroundColor: AppColors.whiteColor,
                                  contentPadding: EdgeInsets.zero,
                                  buttonPadding: EdgeInsets.zero,
                                  actionsPadding: EdgeInsets.zero,
                                  titlePadding: EdgeInsets.zero,
                                  content: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          getTranslated(context,
                                                  AppConstant.areYouSure)
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                AppFontFamily.poppinsMedium,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          getTranslated(
                                                  context,
                                                  AppConstant
                                                      .youWillBeLoggedOut)
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily:
                                                AppFontFamily.poppinsMedium,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Center(
                                                  child: Text(
                                                    getTranslated(context,
                                                            AppConstant.cancel)
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: AppColors
                                                          .inputTextColor,
                                                      fontFamily: AppFontFamily
                                                          .poppinsMedium,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {
                                                  CommonFunction.checkNetwork()
                                                      .then((value) {
                                                    if (value == true) {
                                                      settingProvider
                                                          .logoutUser(context);
                                                    }
                                                  });
                                                },
                                                child: Text(
                                                  getTranslated(context,
                                                          AppConstant.ok)
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Button(
                            text: getTranslated(context, AppConstant.logout)
                                .toString())),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget generalEntry({required BuildContext context, required String text}) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getTranslated(context, text).toString(),
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.blackColor,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
        const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 16,
          color: AppColors.inputTextColor,
        )
      ],
    ),
  );
}
