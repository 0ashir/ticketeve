import 'dart:io';

import 'package:event_right_scanner/DeviceUtil/palette.dart';
import 'package:event_right_scanner/Providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:event_right_scanner/DeviceUtil/const_strings.dart';
import 'package:event_right_scanner/DeviceUtil/preference.dart';
import 'package:event_right_scanner/Providers/event_provider.dart';
import 'package:event_right_scanner/Providers/profile_provider.dart';
import 'package:event_right_scanner/Providers/setting_provider.dart';
import 'package:event_right_scanner/Screen/Auth/login_screen.dart';
import 'package:event_right_scanner/Screen/Home/home_screen.dart';
import 'package:event_right_scanner/localization/language_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<EventProvider>(
          create: (context) => EventProvider(),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider<SettingProvider>(
          create: (context) => SettingProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, host, port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
      SharedPreferenceHelper.setString(ConstString.appVersion, info.version);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Consumer<SettingProvider>(
          builder: (_, settingProviderRef, __) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'EventRight Scanner',
                locale: settingProviderRef.appLocaleChange,
                supportedLocales: const [
                  Locale('en', 'US'),
                  Locale('es', 'ES'),
                ],
                localizationsDelegates: const [
                  LanguageLocalization.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: ThemeData(
                  primaryColor: Palette.primary,
                ),
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode ||
                        supportedLocale.countryCode == locale?.countryCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                home: SharedPreferenceHelper.getBoolean(ConstString.isLoggedIn) == true
                    ? const HomeScreen()
                    : const LoginScreen(),
              ),
            );
          },
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
