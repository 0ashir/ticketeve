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

class OrganizerScreen extends StatefulWidget {
  const OrganizerScreen({super.key});

  @override
  State<OrganizerScreen> createState() => _OrganizerScreenState();
}

class _OrganizerScreenState extends State<OrganizerScreen> {
  Future<void> refresh() async {
    setState(() {
      Future.delayed(
        const Duration(seconds: 0),
        () {
          settingProvider.callApiForOrganization();
        },
      );
    });
  }

  late SettingProvider settingProvider;

  @override
  void initState() {
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 0), () {
      settingProvider.callApiForOrganization();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of<SettingProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar
      
      (
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
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
                 title: Text(
          getTranslated(context, AppConstant.organizers).toString(),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: settingProvider.organizationLoader,
        progressIndicator: const SpinKitCircle(color: AppColors.primaryColor),
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
                    getTranslated(context, AppConstant.hearAboutGreatEventsFirstFromOurBestLocalOrganizers).toString(),
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
                    itemCount: settingProvider.organizationData.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 45,
                            height: 45,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                              child: CachedNetworkImage(
                                imageUrl: settingProvider.organizationData[index].imagePath!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const SpinKitCircle(
                                  color: AppColors.primaryColor,
                                ),
                                errorWidget: (context, url, error) => Image.asset(AppConstantImage.noImageUser),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                              child: settingProvider.organizationData[index].firstName != null
                                  ? Text(
                                      "${settingProvider.organizationData[index].firstName!} ${settingProvider.organizationData[index].lastName!}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: AppFontFamily.poppinsMedium,
                                      ),
                                      maxLines: 1,
                                    )
                                  : Container()),
                          InkWell(
                            onTap: () {
                              setState(() {
                                Map<String, dynamic> body = {"user_id": settingProvider.organizationData[index].id!};
                                settingProvider.callApiForAddFollowing(body);
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 80,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: settingProvider.organizationData[index].isFollow == true ? AppColors.primaryColor : AppColors.inputTextColor,
                                  width: 1,
                                ),
                              ),
                              child: settingProvider.organizationData[index].isFollow == true
                                  ? Text(
                                      getTranslated(context, AppConstant.following).toString(),
                                      style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontFamily: AppFontFamily.poppinsMedium,
                                        fontSize: 12,
                                      ),
                                    )
                                  : Text(
                                      getTranslated(context, AppConstant.follow).toString(),
                                      style: const TextStyle(
                                        color: AppColors.inputTextColor,
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
