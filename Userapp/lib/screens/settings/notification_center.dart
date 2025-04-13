import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_const_image.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late SettingProvider settingProvider;

  @override
  void initState() {
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 0), () {
      settingProvider.callApiForNotification();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of<SettingProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
        ),
        actions: [
          settingProvider.notificationData.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        settingProvider.callApiForDeleteNotification();
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.delete,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: settingProvider.notificationLoader,
        progressIndicator: const SpinKitCircle(color: AppColors.primaryColor),
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: settingProvider.callApiForNotification,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),
                  Text(
                    getTranslated(context, AppConstant.notificationCenter)
                        .toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFontFamily.poppinsMedium,
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (settingProvider.notificationData.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: settingProvider.notificationData.length,
                      itemBuilder: (context, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            settingProvider
                                        .notificationData[index].eventImage !=
                                    null
                                ? SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6)),
                                      child: CachedNetworkImage(
                                        imageUrl: settingProvider
                                            .notificationData[index]
                                            .eventImage!,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            SpinKitCircle(
                                          color: AppColors.primaryColor
                                              .withOpacity(0.4),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                AppConstantImage.noImage),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6)),
                                      child:
                                          Image.asset(AppConstantImage.noImage),
                                    ),
                                  ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        settingProvider
                                            .notificationData[index].title!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily:
                                              AppFontFamily.poppinsMedium,
                                        ),
                                      ),
                                      Text(
                                        "${CommonFunction.shortMonthName(settingProvider.notificationData[index].createdAt!)} ${CommonFunction.convertLocalToDetroit("Asia/Kolkata", settingProvider.notificationData[index].createdAt!)}",
                                        style: const TextStyle(
                                          fontFamily:
                                              AppFontFamily.poppinsMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    settingProvider
                                        .notificationData[index].message!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.inputTextColor,
                                      fontFamily: AppFontFamily.poppinsMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    )
                  else
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.notifications,
                              size: 40,
                              color: Colors.blueGrey.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            getTranslated(
                                    context, AppConstant.noCurrentNotification)
                                .toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.inputTextColor,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            getTranslated(
                                    context,
                                    AppConstant
                                        .yourRecentPurchasesEventsFromOrganizersYouFollowAndOther)
                                .toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.inputTextColor,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
