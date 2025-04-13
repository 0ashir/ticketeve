import 'dart:io';

import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/pref_constant.dart';
import 'package:eventright_organizer/constant/preferences.dart';
import 'package:eventright_organizer/localization/language_localization.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/auth_provider.dart';
import 'package:eventright_organizer/provider/coupon_provider.dart';
import 'package:eventright_organizer/provider/event_provider.dart';
import 'package:eventright_organizer/provider/scanner_provider.dart';
import 'package:eventright_organizer/provider/setting_provider.dart';
import 'package:eventright_organizer/provider/tax_provider.dart';
import 'package:eventright_organizer/provider/ticket_provider.dart';
import 'package:eventright_organizer/routes/custom_router.dart';
import 'package:eventright_organizer/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await SharedPreferenceHelper.init();
  HttpOverrides.global = MyHttpOverrides();
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
        ChangeNotifierProvider<CouponProvider>(
          create: (context) => CouponProvider(),
        ),
        ChangeNotifierProvider<TaxProvider>(
          create: (context) => TaxProvider(),
        ),
        ChangeNotifierProvider<TicketProvider>(
          create: (context) => TicketProvider(),
        ),
        ChangeNotifierProvider<ScannerProvider>(
          create: (context) => ScannerProvider(),
        ),
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

class _MyAppState extends State<MyApp> {
  late SharedPreferences _sharedPreferences;

  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<SharedPreferences?> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences;
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
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(
            FocusNode(),
          );
        },
        child: MaterialApp(
          locale: _locale,
          theme: ThemeData(
            primaryColor: primaryColor,
            primaryColorLight: primaryColor,
            primaryColorDark: primaryColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: primaryColor,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: whiteColor,
                fontSize: 18,
              ),
              iconTheme: IconThemeData(color: whiteColor, size: 18),
            ),
            tabBarTheme: TabBarTheme(
              labelColor: whiteColor,
              labelStyle: const TextStyle(fontSize: 15),
              unselectedLabelColor: whiteColor.withOpacity(0.65),
              unselectedLabelStyle: const TextStyle(fontSize: 15),
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: primaryColor,
              ),
            ),
            drawerTheme: const DrawerThemeData(
              backgroundColor: whiteColor,
            ),
          ),
          supportedLocales: const [
            Locale(english, 'US'),
            Locale(spanish, 'ES'),
          ],
          localizationsDelegates: const [
            LanguageLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocal, supportedLocales) {
            for (var local in supportedLocales) {
              if (local.languageCode == deviceLocal!.languageCode && local.countryCode == deviceLocal.countryCode) {
                return deviceLocal;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          initialRoute:
              SharedPreferenceHelper.getBoolean(Preferences.isLoggedIn) == true ? homeScreenRoute : loginRoute,
          onGenerateRoute: CustomRouter.allRoutes,
        ),
      );
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, host, port) => true;
  }
}
