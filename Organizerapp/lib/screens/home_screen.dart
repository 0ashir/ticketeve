import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/constant/pref_constant.dart';
import 'package:eventright_organizer/constant/preferences.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/event_provider.dart';
import 'package:eventright_organizer/screens/components/event.dart';
import 'package:eventright_organizer/screens/coupons_screen.dart';
import 'package:eventright_organizer/screens/events/create_event_screen.dart';
import 'package:eventright_organizer/screens/events/edit_event_screen.dart';
import 'package:eventright_organizer/screens/events/event_details_screen.dart';
import 'package:eventright_organizer/screens/followers_screen.dart';
import 'package:eventright_organizer/screens/guest_list_screen.dart';
import 'package:eventright_organizer/screens/my_account_screen.dart';
import 'package:eventright_organizer/screens/notification_screen.dart';
import 'package:eventright_organizer/screens/search_screen.dart';
import 'package:eventright_organizer/screens/setting_screen.dart';
import 'package:eventright_organizer/screens/settings/event_setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late EventProvider eventProvider;

  Future<void> refresh() async {
    Future.delayed(
      const Duration(seconds: 0),
      () {
        eventProvider.callApiForAllEvents();
      },
    );
  }

  late TabController _tabController;
  int _activeIndex = 0;
  TextStyle drawerListTextStyle =
      const TextStyle(fontSize: 16, color: blackColor);

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    eventProvider = Provider.of<EventProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      eventProvider.callApiForAllEvents();
    });

    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _activeIndex = _tabController.index;
        });
      }
    });

    return Scaffold(
      backgroundColor: whiteColor,
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          key: key,
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: primaryColor,
                  foregroundColor: primaryColor,
                  leading: IconButton(
                    onPressed: () {
                      setState(() {
                        key.currentState!.openDrawer();
                      });
                    },
                    icon: const Icon(Icons.menu, color: whiteColor),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.search, color: whiteColor),
                      ),
                    ),
                  ],
                  pinned: true,
                  floating: true,
                  snap: true,
                  shadowColor: whiteColor,
                  bottom: TabBar(
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 4.0,
                        color: whiteColor,
                      ),
                      insets: EdgeInsets.symmetric(
                        horizontal: 18.0,
                      ),
                    ),
                    tabs: <Tab>[
                      Tab(
                        child: Text(
                          getTranslated(context, 'ongoing').toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 13,
                              color: whiteColor,
                              fontFamily: AppFontFamily.poppinsMedium),
                        ),
                      ),
                      Tab(
                        child: Text(
                          getTranslated(context, 'future').toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 13,
                              color: whiteColor,
                              fontFamily: AppFontFamily.poppinsMedium),
                        ),
                      ),
                      Tab(
                        child: Text(
                          getTranslated(context, 'past').toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 13,
                              color: whiteColor,
                              fontFamily: AppFontFamily.poppinsMedium),
                        ),
                      ),
                      Tab(
                        child: Text(
                          getTranslated(context, 'draft').toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 13,
                              color: whiteColor,
                              fontFamily: AppFontFamily.poppinsMedium),
                        ),
                      ),
                    ],
                    controller: _tabController,
                  ),
                ),
              ];
            },
            body: ModalProgressHUD(
              inAsyncCall: eventProvider.eventLoader,
              progressIndicator: const SpinKitCircle(color: primaryColor),
              offset: Offset(MediaQuery.of(context).size.width * 0.43,
                  MediaQuery.of(context).size.height * 0.35),
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  RefreshIndicator(
                    onRefresh: refresh,
                    child: eventProvider.ongoingEvents.isNotEmpty
                        ? ListView.builder(
                            itemCount: eventProvider.ongoingEvents.length,
                            padding: const EdgeInsets.only(bottom: 10),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Event(
                                trailingClick: () {
                                  eventProvider
                                      .callApiForEventDetails(
                                          eventProvider.ongoingEvents[index].id)
                                      .then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditEventScreen(
                                                  eventId: eventProvider
                                                      .ongoingEvents[index].id!
                                                      .toInt(),
                                                )));
                                  });
                                },
                                trailingIcon: const CircleAvatar(
                                  backgroundColor: whiteColor,
                                  child: Icon(Icons.edit, color: blackColor),
                                ),
                                onMainTap: () {
                                  eventProvider.callApiForEventDetails(
                                      eventProvider.ongoingEvents[index].id);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EventDetails(),
                                    ),
                                  );
                                },
                                image: eventProvider
                                        .ongoingEvents[index].imagePath! +
                                    eventProvider.ongoingEvents[index].image!,
                                tickets:
                                    "${eventProvider.ongoingEvents[index].soldTickets!} / ${eventProvider.ongoingEvents[index].totalTickets!} Tickets Sold",
                                title: eventProvider.ongoingEvents[index].name!,
                                description: eventProvider
                                    .ongoingEvents[index].description!,
                                startTime: eventProvider
                                    .ongoingEvents[index].startTime!,
                                guestList: () {
                                  eventProvider.callApiForGuest(
                                      eventProvider.ongoingEvents[index].id);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const GuestList(),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : Center(
                            child: Text(getTranslated(context, 'no_data_found')
                                .toString()),
                          ),
                  ),
                  RefreshIndicator(
                    onRefresh: refresh,
                    child: eventProvider.upcomingEvents.isNotEmpty
                        ? ListView.builder(
                            itemCount: eventProvider.upcomingEvents.length,
                            padding: const EdgeInsets.only(bottom: 10),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Event(
                                  trailingClick: () {
                                    eventProvider
                                        .callApiForEventDetails(eventProvider
                                            .upcomingEvents[index].id)
                                        .then((value) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditEventScreen(
                                            eventId: eventProvider
                                                .upcomingEvents[index].id!
                                                .toInt(),
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  trailingIcon: const CircleAvatar(
                                    backgroundColor: whiteColor,
                                    foregroundColor: blackColor,
                                    child: Icon(Icons.edit),
                                  ),
                                  onMainTap: () {
                                    eventProvider.callApiForEventDetails(
                                        eventProvider.upcomingEvents[index].id);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EventDetails(),
                                      ),
                                    );
                                  },
                                  image: eventProvider
                                          .upcomingEvents[index].imagePath! +
                                      eventProvider
                                          .upcomingEvents[index].image!,
                                  tickets:
                                      "${eventProvider.upcomingEvents[index].soldTickets!} / ${eventProvider.upcomingEvents[index].totalTickets!} Tickets Sold",
                                  title:
                                      eventProvider.upcomingEvents[index].name!,
                                  description: eventProvider
                                      .upcomingEvents[index].description!,
                                  startTime: eventProvider
                                      .upcomingEvents[index].startTime!,
                                  guestList: () {
                                    eventProvider.callApiForGuest(
                                        eventProvider.upcomingEvents[index].id);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const GuestList(),
                                      ),
                                    );
                                  });
                            })
                        : Center(
                            child: Text(getTranslated(context, 'no_data_found')
                                .toString()),
                          ),
                  ),
                  RefreshIndicator(
                    onRefresh: refresh,
                    child: eventProvider.pastEvents.isNotEmpty
                        ? ListView.builder(
                            itemCount: eventProvider.pastEvents.length,
                            padding: const EdgeInsets.only(bottom: 10),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Event(
                                  title: eventProvider.pastEvents[index].name!,
                                  description: eventProvider
                                      .pastEvents[index].description!,
                                  startTime: eventProvider
                                      .pastEvents[index].startTime!,
                                  tickets:
                                      "${eventProvider.pastEvents[index].soldTickets!} / ${eventProvider.pastEvents[index].totalTickets} Tickets Sold",
                                  image: eventProvider
                                          .pastEvents[index].imagePath! +
                                      eventProvider.pastEvents[index].image!,
                                  guestList: () {
                                    eventProvider.callApiForGuest(
                                        eventProvider.pastEvents[index].id);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const GuestList(),
                                      ),
                                    );
                                  },
                                  onMainTap: () {
                                    eventProvider.callApiForEventDetails(
                                        eventProvider.pastEvents[index].id);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EventDetails(),
                                      ),
                                    );
                                  });
                            })
                        : Center(
                            child: Text(getTranslated(context, 'no_data_found')
                                .toString()),
                          ),
                  ),
                  RefreshIndicator(
                    onRefresh: refresh,
                    child: eventProvider.draftEvents.isNotEmpty
                        ? ListView.builder(
                            itemCount: eventProvider.draftEvents.length,
                            padding: const EdgeInsets.only(bottom: 10),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.all(08),
                                    decoration: BoxDecoration(
                                        color: primaryColor.withOpacity(0.2),
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.edit,
                                      color: primaryColor,
                                      size: 18,
                                    ),
                                  ),
                                  onTap: () {
                                    eventProvider.callApiForEventDetails(
                                        eventProvider.draftEvents[index].id);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditEventScreen(
                                          eventId: eventProvider
                                              .draftEvents[index].id!
                                              .toInt(),
                                        ),
                                      ),
                                    );
                                  },
                                  title: Text(
                                    eventProvider.draftEvents[index].name!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: blackColor,
                                        fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    "${DateFormat('dd MMM, yyyy hh:mm aa').format(DateTime.parse(eventProvider.draftEvents[index].startTime!))} ${getTranslated(context, 'to')} ${DateFormat('dd MMM, yyyy hh:mm aa').format(DateTime.parse(eventProvider.draftEvents[index].endTime!))}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: inputTextColor,
                                    ),
                                  ),
                                ),
                              );
                            })
                        : const Center(
                            child: Text("Inactive events will be shown here"),
                          ),
                  ),
                ],
              ),
            ),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Circle Avatar in Cached Network Image
                      CachedNetworkImage(
                        imageUrl:
                            SharedPreferenceHelper.getString(Preferences.image),
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 38,
                          backgroundColor: primaryColor,
                          backgroundImage: imageProvider,
                        ),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const CircleAvatar(
                          radius: 38,
                          backgroundColor: primaryColor,
                          backgroundImage:
                              AssetImage("assets/images/NoImage.png"),
                        ),
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                          radius: 38,
                          backgroundColor: primaryColor,
                          backgroundImage:
                              AssetImage("assets/images/NoImage.png"),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${SharedPreferenceHelper.getString(Preferences.firstName)} ${SharedPreferenceHelper.getString(Preferences.lastName)}",
                            style: const TextStyle(
                                fontSize: 24, color: blackColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyAccount(),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: inputTextColor,
                              size: 18,
                            ),
                          )
                        ],
                      ),
                      Text(
                        SharedPreferenceHelper.getString(Preferences.email),
                        style: const TextStyle(
                            fontSize: 14, color: inputTextColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: Text(
                    getTranslated(context, 'home').toString(),
                    style: drawerListTextStyle,
                  ),
                  leading: const Icon(CupertinoIcons.home, color: primaryColor),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EventSetting(),
                      ),
                    );
                  },
                  title: Text(
                    getTranslated(context, 'event_settings').toString(),
                    style: drawerListTextStyle,
                  ),
                  leading:
                      const Icon(CupertinoIcons.settings, color: primaryColor),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Coupons(),
                      ),
                    );
                  },
                  title: Text(
                    getTranslated(context, 'coupons').toString(),
                    style: drawerListTextStyle,
                  ),
                  leading: const Icon(CupertinoIcons.tickets_fill,
                      color: primaryColor),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FollowersScreen(),
                      ),
                    );
                  },
                  title: Text(
                    getTranslated(context, 'followers').toString(),
                    style: drawerListTextStyle,
                  ),
                  leading: const Icon(Icons.people, color: primaryColor),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                  },
                  title: Text(
                    getTranslated(context, 'notifications').toString(),
                    style: drawerListTextStyle,
                  ),
                  leading: const Icon(Icons.notifications_active_rounded,
                      color: primaryColor),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingScreen(),
                      ),
                    );
                  },
                  title: Text(
                    getTranslated(context, 'settings').toString(),
                    style: drawerListTextStyle,
                  ),
                  leading: const Icon(Icons.settings, color: primaryColor),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      showLogoutDialog();
                    });
                  },
                  title: Text(
                    getTranslated(context, 'logout').toString(),
                    style: drawerListTextStyle,
                  ),
                  leading: const Icon(Icons.logout, color: primaryColor),
                ),
              ],
            ),
          ),
          floatingActionButton: _activeIndex == 0
              ? FloatingActionButton(
                  elevation: 0.0,
                  backgroundColor: primaryColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateEvent(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add, color: whiteColor))
              : Container(),
        ),
      ),
    );
  }

  showLogoutDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        title: Text(
          "${getTranslated(context, 'logout')}?",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 20,
              ),
        ),
        content: Text(
          getTranslated(context, "logout_message").toString(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
            child: Text(getTranslated(context, "cancel").toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: blackColor)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              eventProvider.logoutUser(context);
            },
            child: Text(
              getTranslated(context, "logout").toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
