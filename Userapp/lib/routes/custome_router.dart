import 'package:eventright_pro_user/routes/route_names.dart';
import 'package:eventright_pro_user/screens/auth/signin_screen.dart';
import 'package:eventright_pro_user/screens/auth/signup_screen.dart';
import 'package:eventright_pro_user/screens/home_screen.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
    return MaterialPageRoute(builder: (_) => const LoginScreen());
  }
}
