import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_right_scanner/DeviceUtil/fonts.dart';
import 'package:event_right_scanner/Models/all_event_model.dart';
import 'package:event_right_scanner/Providers/auth_provider.dart';
import 'package:event_right_scanner/Screen/Components/field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:event_right_scanner/DeviceUtil/app_string.dart';
import 'package:event_right_scanner/DeviceUtil/const_strings.dart';
import 'package:event_right_scanner/DeviceUtil/palette.dart';
import 'package:event_right_scanner/DeviceUtil/preference.dart';
import 'package:event_right_scanner/Providers/event_provider.dart';
import 'package:event_right_scanner/Providers/setting_provider.dart';
import 'package:event_right_scanner/localization/localization_constant.dart';
import 'package:event_right_scanner/main.dart';
import 'package:event_right_scanner/Screen/Event/event_detail_screen.dart';
import 'package:event_right_scanner/Screen/Profile/profile_screen.dart';

enum LanguagesActions { english, spanish }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController search = TextEditingController();

  late EventProvider eventProviderRef;
  late SettingProvider settingProviderRef;

  @override
  void initState() {
    eventProviderRef = Provider.of<EventProvider>(context, listen: false);
    settingProviderRef = Provider.of<SettingProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 0), () {
      eventProviderRef.callApiAllEvent();
      settingProviderRef.callSetting();
    });
    super.initState();
  }

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Tap again to exit App",
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (_, eventProviderRef, __) {
        return Consumer<AuthProvider>(
          builder: (_, authProviderRef, __) {
            return ModalProgressHUD(
              inAsyncCall: eventProviderRef.eventLoader,
              opacity: 0.5,
              progressIndicator: const SpinKitPulse(
                color: Palette.primary,
                size: 50.0,
              ),
              child: PopScope(
                onPopInvoked: (iod) => onWillPop,
                child: Scaffold(
                  key: scaffoldKey,
                  backgroundColor: Palette.white,
                  appBar: AppBar(
                    backgroundColor: Palette.primary,
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        size: 25,
                        color: Palette.white,
                      ),
                      onPressed: () {
                        setState(() {
                          scaffoldKey.currentState!.openDrawer();
                        });
                      },
                    ),
                    centerTitle: true,
                    title: Text(
                        // events,
                        getTranslated(context, events).toString(),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Palette.white,
                            fontFamily: AppFontFamily.poppinsMedium)),
                  ),
                  drawer: Drawer(
                    backgroundColor: Palette.white,
                    child: ListView(
                      children: [
                        Container(
                          color: Palette.primary.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          SharedPreferenceHelper.getString(
                                              ConstString.image),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const SpinKitFadingCircle(
                                              color: Palette.primary),
                                      errorWidget: (context, url, error) =>
                                          ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        child: Image.asset(
                                          "assets/images/NoImage.png",
                                          width: 90,
                                          height: 90,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        // width: 55.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                SharedPreferenceHelper
                                                    .getString(
                                                        ConstString.name),
                                                style: const TextStyle(
                                                    color: Palette.black,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                    fontSize: 16)),
                                            Text(
                                                SharedPreferenceHelper
                                                    .getString(
                                                        ConstString.email),
                                                style: const TextStyle(
                                                    color: Palette.black,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ProfileScreen(),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.chevron_right_outlined,
                                        color: Palette.black,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.emoji_events_outlined,
                                      color: Palette.black,
                                      size: 25,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                        // events,
                                        getTranslated(context, events)
                                            .toString(),
                                        style: const TextStyle(
                                          color: Palette.black,
                                          fontFamily:
                                              AppFontFamily.poppinsRegular,
                                          fontSize: 14,
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.language_outlined,
                                      color: Palette.black,
                                      size: 25,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              // language,
                                              getTranslated(context, language)
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Palette.black,
                                                fontFamily: AppFontFamily
                                                    .poppinsRegular,
                                                fontSize: 14,
                                              )),
                                          PopupMenuButton<LanguagesActions>(
                                            color: Palette.white,
                                            position: PopupMenuPosition.under,
                                            onSelected: (LanguagesActions val) {
                                              switch (val) {
                                                case LanguagesActions.english:
                                                  settingProviderRef
                                                      .updateLanguage("en");
                                                  Navigator.pop(context);
                                                  break;
                                                case LanguagesActions.spanish:
                                                  settingProviderRef
                                                      .updateLanguage("es");
                                                  Navigator.pop(context);
                                              }
                                            },
                                            itemBuilder: (context) {
                                              return <PopupMenuEntry<
                                                  LanguagesActions>>[
                                                PopupMenuItem(
                                                  value:
                                                      LanguagesActions.english,
                                                  child: Text('English',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            AppFontFamily
                                                                .poppinsRegular,
                                                        color: SharedPreferenceHelper
                                                                    .getString(
                                                                        ConstString
                                                                            .currentLanguageCode) ==
                                                                "en"
                                                            ? Palette.primary
                                                            : Palette.black,
                                                      )),
                                                ),
                                                PopupMenuItem(
                                                    value: LanguagesActions
                                                        .spanish,
                                                    child: Text('Spanish',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              AppFontFamily
                                                                  .poppinsRegular,
                                                          color: SharedPreferenceHelper
                                                                      .getString(
                                                                          ConstString
                                                                              .currentLanguageCode) ==
                                                                  "es"
                                                              ? Palette.primary
                                                              : Palette.black,
                                                        ))),
                                              ];
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      title: Text(
                                        // logout,
                                        getTranslated(context, logout)
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontSize: 20,
                                            ),
                                      ),
                                      content: Text(
                                        // logoutMsg,
                                        getTranslated(context, logoutMsg)
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontSize: 14,
                                            ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: Text(
                                            // no,
                                            getTranslated(context, no)
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            authProviderRef
                                                .logoutUser(this.context);
                                          },
                                          child: Text(
                                              // logout,
                                              getTranslated(context, logout)
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: AppFontFamily
                                                      .poppinsRegular,
                                                  color: Palette.black)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.login,
                                        color: Palette.black,
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                          // logout,
                                          getTranslated(context, logout)
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily:
                                                  AppFontFamily.poppinsRegular,
                                              color: Palette.black)),
                                    ],
                                  ),
                                ),
                              ),
                    ],
                          ),
                        )
                      ],
                    ),
                  ),
                  body: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Field(
                          onChange: onSearchEvent,
                            controller: search,
                            label:
                                getTranslated(context, searchHere).toString(),
                            icon: const Icon(Icons.search_outlined),
                            isPassword: false,
                            inputType: TextInputType.text),
                      ),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: eventProviderRef
                                      .searchAllEventList.isNotEmpty ||
                                  search.text.isNotEmpty
                              ? ListView.builder(
                                  itemCount: eventProviderRef
                                      .searchAllEventList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    AllEventData data = eventProviderRef
                                        .searchAllEventList[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EventDetail(
                                                    id: data.id,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Palette.white,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Palette.black
                                                            .withOpacity(0.1),
                                                        blurRadius: 2,
                                                      )
                                                    ],
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          data.imagePath! +
                                                              data.image!,
                                                      fit: BoxFit.cover,
                                                      placeholder: (context,
                                                              url) =>
                                                          const SpinKitFadingCircle(
                                                              color: Palette
                                                                  .primary),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(15),
                                                        ),
                                                        child: Image.asset(
                                                          "assets/images/NoImage.png",
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data.name!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            color:
                                                                Palette.primary,
                                                            fontFamily:
                                                                AppFontFamily
                                                                    .poppinsMedium,
                                                            fontSize: 16),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        data.address ??
                                                            getTranslated(
                                                                    context,
                                                                    noAddressFound)
                                                                .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style:const TextStyle(color: Palette.black, fontFamily: AppFontFamily.poppinsRegular, fontSize: 14)
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        // "11:36 PM",
                                                        "${DateUtilShow().formattedDate(
                                                          DateTime.parse(
                                                              data.startTime!),
                                                        )} ${DateFormat.jm().format(
                                                          DateTime.parse(
                                                              data.startTime!),
                                                        )}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style:const TextStyle(fontSize: 14, color: Palette.darkGrey, fontFamily: AppFontFamily.poppinsRegular)
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : ListView.builder(
                                  itemCount:
                                      eventProviderRef.allEventList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    AllEventData data =
                                        eventProviderRef.allEventList[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EventDetail(
                                                    id: data.id,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Palette.white,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Palette.black
                                                            .withOpacity(0.1),
                                                        blurRadius: 2,
                                                      )
                                                    ],
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          data.imagePath! +
                                                              data.image!,
                                                      fit: BoxFit.cover,
                                                      placeholder: (context,
                                                              url) =>
                                                          const SpinKitFadingCircle(
                                                              color: Palette
                                                                  .primary),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(15),
                                                        ),
                                                        child: Image.asset(
                                                          "assets/images/NoImage.png",
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data.name!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            color:
                                                                Palette.primary,
                                                            fontFamily:
                                                                AppFontFamily
                                                                    .poppinsMedium,
                                                            fontSize: 16),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        data.address ??
                                                            getTranslated(
                                                                    context,
                                                                    noAddressFound)
                                                                .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style:const TextStyle(color: Palette.black, fontFamily: AppFontFamily.poppinsRegular, fontSize: 14)
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        // "11:36 PM",
                                                        "${DateUtilShow().formattedDate(
                                                          DateTime.parse(
                                                              data.startTime!),
                                                        )} ${DateFormat.jm().format(
                                                          DateTime.parse(
                                                              data.startTime!),
                                                        )}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style:const TextStyle(fontSize: 14, color: Palette.darkGrey, fontFamily: AppFontFamily.poppinsRegular)
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  onSearchEvent(String text) async {
    eventProviderRef.searchAllEventList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var appointmentData in eventProviderRef.allEventList) {
      if (appointmentData.name!.toLowerCase().contains(text.toLowerCase())) {
        eventProviderRef.searchAllEventList.add(appointmentData);
      }
    }

    setState(() {});
  }
}
