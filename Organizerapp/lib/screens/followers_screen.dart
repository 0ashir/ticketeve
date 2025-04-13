import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  late SettingProvider settingProvider;

  Future<void> refresh() async {
    Future.delayed(
      const Duration(seconds: 0),
      () {
        settingProvider.callApiForFollowers();
      },
    );
  }

  @override
  void initState() {
    settingProvider = Provider.of<SettingProvider>(context, listen: false);

    Future.delayed(Duration.zero, () {
      settingProvider.callApiForFollowers();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of<SettingProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(

        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          getTranslated(context, 'followers').toString(),
          style:const  TextStyle(
            color: whiteColor, fontSize: 16, fontFamily: AppFontFamily.poppinsMedium
          ),
          
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: settingProvider.followersLoader,
        progressIndicator: const SpinKitCircle(color: primaryColor),
        offset: Offset(MediaQuery.of(context).size.width * 0.43, MediaQuery.of(context).size.height * 0.35),
        child: RefreshIndicator(
          onRefresh: refresh,
          child: settingProvider.followers.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  itemCount: settingProvider.followers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 45,
                            height: 45,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: settingProvider.followers[index].imagePath! +
                                    settingProvider.followers[index].image!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const SpinKitCircle(
                                  color: primaryColor,
                                ),
                                errorWidget: (context, url, error) => Image.asset("assets/images/NoImage.png"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    settingProvider.followers[index].name! + settingProvider.followers[index].lastName!,
                                    style: const TextStyle(fontSize: 16),
                                    maxLines: 1),
                                Text(settingProvider.followers[index].email!,
                                    style: const TextStyle(fontSize: 14, color: inputTextColor), maxLines: 1),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 80,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              getTranslated(context, 'following').toString(),
                              style: const TextStyle(color: inputTextColor),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                )
              : Center(
                  child: Text(getTranslated(context, 'no_data_found').toString()),
                ),
        ),
      ),
    );
  }
}
