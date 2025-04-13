import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_const_image.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/model/all_events_model.dart';
import 'package:eventright_pro_user/provider/events_provider.dart';
import 'package:eventright_pro_user/provider/setting_provider.dart';
import 'package:eventright_pro_user/screens/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with SingleTickerProviderStateMixin {
  late EventProvider eventProvider;
  late TabController _tabController;
  int _activeIndex = 0;
  late SettingProvider settingProvider;

  @override
  void initState() {
    eventProvider = Provider.of<EventProvider>(context, listen: false);
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 0), () {
      eventProvider.callApiForFavorite();
      settingProvider.callApiForFollowing();
    });
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);
    settingProvider = Provider.of<SettingProvider>(context);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _activeIndex = _tabController.index;
        });
      }
    });
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          getTranslated(context, AppConstant.followedFavorites).toString(),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1,
                ),
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: _activeIndex == 0
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        )
                      : const BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                  color: AppColors.primaryColor,
                ),
                labelColor: Colors.white,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Colors.black,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: AppFontFamily.poppinsMedium,
                ),
                splashBorderRadius: _activeIndex == 0
                    ? const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )
                    : const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                tabs: [
                  Tab(
                    text: getTranslated(context, AppConstant.followed).toString(),
                  ),
                  Tab(
                    text: getTranslated(context, AppConstant.favorites).toString(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  ModalProgressHUD(
                    inAsyncCall: settingProvider.followingLoader,
                    progressIndicator: const SpinKitCircle(color: AppColors.primaryColor),
                    color: Colors.transparent,
                    child: RefreshIndicator(
                      color: AppColors.primaryColor,
                      onRefresh: settingProvider.callApiForFollowing,
                      child: ListView.builder(
                        itemCount: settingProvider.followingData.length,
                        itemBuilder: (context, fIndex) {
                          return ListView.separated(
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            shrinkWrap: true,
                            itemCount: settingProvider.followingData[fIndex].events!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            itemBuilder: (context, index) {
                              Events event = settingProvider.followingData[fIndex].events![index];
                              return InkWell(
                                onTap: () {
                                  eventProvider.callApiForEventDetails(event.id!).then((value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EventDetailsScreen(
                                          eventId: event.id!.toInt(),
                                        ),
                                      ),
                                    );
                                  });
                                },
                                child: Card(
                                  shadowColor: AppColors.primaryColor.withOpacity(0.4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 20,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //Image
                                        Container(
                                          height: 150,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: event.imagePath.toString() + event.image.toString(),
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => SpinKitCircle(
                                                color: AppColors.primaryColor.withOpacity(0.4),
                                              ),
                                              errorWidget: (context, url, error) => Image.asset(AppConstantImage.noImage, fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                        // Event Name
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6),
                                          child: Text(
                                            event.name!,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: AppFontFamily.poppinsMedium,
                                            ),
                                          ),
                                        ),
                                        // Event Starting Time
                                        Text(
                                          event.time!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.inputTextColor,
                                            fontFamily: AppFontFamily.poppinsRegular,
                                          ),
                                        ),
                                        // Event Description
                                        Text(
                                          event.description!,
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.inputTextColor,
                                            fontFamily: AppFontFamily.poppinsRegular,
                                            overflow: TextOverflow.ellipsis
                                          ),
                                        ),
        
                                        Row(
                                          children: [
                                            // Event Ratings
                                            event.rate != null
                                                ? Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                                    child: RatingBar.builder(
                                                    unratedColor: AppColors.blackColor,
                                                      
                                                      initialRating: event.rate!.toDouble(),
                                                      minRating: 1,
                                                      itemSize: 16,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      ignoreGestures: true,
                                                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                      itemBuilder: (context, _) => const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {},
                                                    ),
                                                  )
                                                : Container(),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  Share.share(event.shareUrl??"");
                                                });
                                              },
                                              child: const Icon(
                                                Icons.share,
                                                color: AppColors.blackColor,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 14);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  ModalProgressHUD(
                    inAsyncCall: eventProvider.favoriteLoader,
                    progressIndicator: const SpinKitCircle(color: AppColors.primaryColor),
                    color: Colors.transparent,
                    child: RefreshIndicator(
                      color: AppColors.primaryColor,
                      onRefresh: eventProvider.callApiForFavorite,
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              eventProvider.favoriteData.isEmpty
                                  ? const SizedBox()
                                  : Text(
                                      " ${eventProvider.favoriteData.length}  ${getTranslated(context, AppConstant.favorites)}",
                                      style: const TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: 16,
                                        fontFamily: AppFontFamily.poppinsMedium,
                                      ),
                                    ),
                              const SizedBox(height: 15),
                              eventProvider.favoriteData.isEmpty
                                  ? SizedBox(
                                      height: MediaQuery.of(context).size.height * .6,
                                      child: Center(
                                        child: Text(
                                          getTranslated(context, AppConstant.noDataFound).toString(),
                                          style: const TextStyle(
                                            fontFamily: AppFontFamily.poppinsMedium,
                                          ),
                                        ),
                                      ),
                                    )
                                  : ListView.separated(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: eventProvider.favoriteData.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            SizedBox(
                                              width: 90,
                                              height: 90,
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(6),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: eventProvider.favoriteData[index].imagePath! + eventProvider.favoriteData[index].image!,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) => SpinKitCircle(
                                                    color: AppColors.primaryColor.withOpacity(0.4),
                                                  ),
                                                  errorWidget: (context, url, error) => Image.asset(AppConstantImage.noImage),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    eventProvider.favoriteData[index].name!,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: AppFontFamily.poppinsMedium,
                                                    ),
                                                  ),
                                                  Text(
                                                    eventProvider.favoriteData[index].time!,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: AppFontFamily.poppinsRegular,
                                                      color: AppColors.inputTextColor,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          eventProvider.favoriteData[index].description!,
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            color: AppColors.inputTextColor,
                                                            fontFamily: AppFontFamily.poppinsRegular,
                                                          ),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.favorite_rounded,
                                                        color: AppColors.primaryColor,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(height: 25,);
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ),
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
