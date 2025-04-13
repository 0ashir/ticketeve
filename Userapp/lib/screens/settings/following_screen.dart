import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_const_image.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  Future<void> refresh() async {
    setState(() {
      Future.delayed(
        const Duration(seconds: 0),
        () {
          settingProvider.callApiForFollowing();
        },
      );
    });
  }

  late SettingProvider settingProvider;

  @override
  void initState() {
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 0), () {
      settingProvider.callApiForFollowing();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of<SettingProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
            size: 16,
          ),
          
        ),

      ),
      body: ModalProgressHUD(
        inAsyncCall: settingProvider.followingLoader,
        progressIndicator: const SpinKitCircle(
          color: AppColors.primaryColor,
        ),
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: refresh,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Text(
                    getTranslated(context, AppConstant.following).toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFontFamily.poppinsMedium,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "${settingProvider.followingData.length} ${getTranslated(context, AppConstant.following)}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.inputTextColor,
                      fontFamily: AppFontFamily.poppinsMedium,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: settingProvider.followingData.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 45,
                            height: 45,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: settingProvider.followingData[index].imagePath.toString(),
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const SpinKitCircle(
                                  color: AppColors.primaryColor,
                                ),
                                errorWidget: (context, url, error) => Image.asset(AppConstantImage.noImage),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "${settingProvider.followingData[index].firstName ?? ""} ${settingProvider.followingData[index].lastName ?? ""}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: AppFontFamily.poppinsMedium,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                Map<String, dynamic> body = {"user_id": settingProvider.followingData[index].id!};
                                settingProvider.callApiForAddFollowing(body);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 07),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                getTranslated(context, AppConstant.following).toString(),
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontFamily: AppFontFamily.poppinsMedium,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
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
