import 'dart:io';

// TODO: Seat Mapping Module: Step 1: Uncomment Following if you want to add this module
// import 'package:eventright_pro_user/SeatMap/seat_map_provider.dart';
import 'package:eventright_pro_user/constant/lang_pref.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/localization/language_localization.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/auth_provider.dart';
import 'package:eventright_pro_user/provider/book_order_provider.dart';
import 'package:eventright_pro_user/provider/events_provider.dart';
import 'package:eventright_pro_user/provider/order_provider.dart';
import 'package:eventright_pro_user/provider/search_provider.dart';
import 'package:eventright_pro_user/provider/setting_provider.dart';
import 'package:eventright_pro_user/provider/ticket_provider.dart';
import 'package:eventright_pro_user/provider/wallet_provider.dart';
import 'package:eventright_pro_user/retrofit/api_client.dart';
import 'package:eventright_pro_user/retrofit/api_header.dart';
import 'package:eventright_pro_user/retrofit/base_model.dart';
import 'package:eventright_pro_user/retrofit/server_error.dart';
import 'package:eventright_pro_user/routes/custome_router.dart';
import 'package:eventright_pro_user/routes/route_names.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/model/setting_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await SharedPreferences.getInstance();
  await SharedPreferenceHelper.init();
  await SharedPreferenceHelperUtils.init();
  OneSignal.shared.setLocationShared(false);
  await callApiForSetting();

  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<EventProvider>(
          create: (context) => EventProvider(),
        ),

        ChangeNotifierProvider<SettingProvider>(
          create: (context) => SettingProvider(),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider<TicketProvider>(
          create: (context) => TicketProvider(),
        ),
        ChangeNotifierProvider<BookOrderProvider>(
          create: (context) => BookOrderProvider(),
        ),
        ChangeNotifierProvider<WalletProvider>(
          create: (context) => WalletProvider(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        ),

        // TODO: Seat Mapping Module: Step 2:  Uncomment Following if you want to add this module
        // ChangeNotifierProvider<SeatMapProvider>(
        //   create: (context) => SeatMapProvider(),
        // ),
      ],
      child: const MyApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }
}

Future<BaseModel<SettingModel>> callApiForSetting() async {
  SettingModel response;
  try {
    response = await RestClient(RetroApi().dioData()).setting();

    if (response.success == true) {
      if (response.data!.onesignalAppId != null) {
        getOneSingleToken(response.data!.onesignalAppId!);
      }
      if (response.data!.currencySymbol != null) {
        SharedPreferenceHelper.setString(
            Preferences.currencySymbol, response.data!.currencySymbol!);
      }

      if (response.data!.currency != null) {
        SharedPreferenceHelper.setString(
            Preferences.currencyCode, response.data!.currency!);
      }
    }
  } catch (error) {
    return BaseModel()..setException(ServerError.withError(error: error));
  }
  return BaseModel()..data = response;
}

getOneSingleToken(String appId) async {
  String? userId = '';
  OneSignal.shared.consentGranted(true);
  await OneSignal.shared.setAppId(appId);
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
  OneSignal.shared.promptLocationPermission();
  var status = await (OneSignal.shared.getDeviceState());
  userId = status!.userId;
  if (kDebugMode) {
    print("One Signal Token :$userId");
  }
  if (SharedPreferenceHelperUtils.getString(Preferences.onesignalPushToken) ==
      "") {
    if (userId != null) {
      SharedPreferenceHelperUtils.setString(
          Preferences.onesignalPushToken, userId);
    } else {
      SharedPreferenceHelperUtils.setString(Preferences.onesignalPushToken, '');
    }
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((local) => {
          setState(() {
            _locale = local;
          })
        });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          locale: _locale,
          supportedLocales: const [
            Locale(english, 'US'),
            Locale(spanish, 'ES'),
            Locale(arabic, 'AE'),
          ],
          localizationsDelegates: const [
            LanguageLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocal, supportedLocales) {
            for (var local in supportedLocales) {
              if (local.languageCode == deviceLocal!.languageCode &&
                  local.countryCode == deviceLocal.countryCode) {
                return deviceLocal;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          initialRoute:
              SharedPreferenceHelper.getBoolean(Preferences.isLoggedIn) == true
                  ? homeScreenRoute
                  : loginRoute,
          onGenerateRoute: CustomRouter.allRoutes,
          theme: ThemeData(primaryColor: AppColors.primaryColor),
        ),
      );
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, host, port) => true;
  }
}
