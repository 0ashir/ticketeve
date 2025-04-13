import 'package:eventright_organizer/routes/route_names.dart';
import 'package:eventright_organizer/screens/add_new_coupon_screen.dart';
import 'package:eventright_organizer/screens/auth/forgot_password_screen.dart';
import 'package:eventright_organizer/screens/auth/sign_up_screen.dart';
import 'package:eventright_organizer/screens/coupons_screen.dart';
import 'package:eventright_organizer/screens/edit_coupon_screen.dart';
import 'package:eventright_organizer/screens/events/create_event_screen.dart';
import 'package:eventright_organizer/screens/events/edit_event_screen.dart';
import 'package:eventright_organizer/screens/events/event_details_screen.dart';
import 'package:eventright_organizer/screens/followers_screen.dart';
import 'package:eventright_organizer/screens/guest_list_screen.dart';
import 'package:eventright_organizer/screens/home_screen.dart';
import 'package:eventright_organizer/screens/my_account_screen.dart';
import 'package:eventright_organizer/screens/notification_screen.dart';
import 'package:eventright_organizer/screens/search_screen.dart';
import 'package:eventright_organizer/screens/setting_screen.dart';
import 'package:eventright_organizer/screens/settings/change_password_screen.dart';
import 'package:eventright_organizer/screens/settings/edit_profile_screen.dart';
import 'package:eventright_organizer/screens/settings/event_setting_screen.dart';
import 'package:eventright_organizer/screens/settings/faqs_screen.dart';
import 'package:eventright_organizer/screens/settings/feed_back_screen.dart';
import 'package:eventright_organizer/screens/settings/tax_options_screen.dart';
import 'package:eventright_organizer/screens/tickets/add_ticket_screen.dart';
import 'package:eventright_organizer/screens/tickets/edit_ticket_screen.dart';
import 'package:eventright_organizer/screens/tickets/tickets_screen.dart';
import 'package:flutter/material.dart';
import '../screens/auth/sign_in_screen.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case loginRoute:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );
      case registerRoute:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );
      case forgotPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => const ForgotPassword(),
        );
      case homeScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case settingRoute:
        return MaterialPageRoute(
          builder: (_) => const SettingScreen(),
        );
      case changePasswordRoute:
        return MaterialPageRoute(
          builder: (_) => const ChangePassword(),
        );
      case faqsRoute:
        return MaterialPageRoute(
          builder: (_) => const FaqScreen(),
        );
      case feedBackRoute:
        return MaterialPageRoute(
          builder: (_) => const FeedBackScreen(),
        );
      case notificationRoute:
        return MaterialPageRoute(
          builder: (_) => const NotificationScreen(),
        );
      case followersRoute:
        return MaterialPageRoute(
          builder: (_) => const FollowersScreen(),
        );
      case eventSettingRoute:
        return MaterialPageRoute(
          builder: (_) => const EventSetting(),
        );
      case taxOptionRoute:
        return MaterialPageRoute(
          builder: (_) => const TaxOptions(),
        );
      case couponRoute:
        return MaterialPageRoute(
          builder: (_) => const Coupons(),
        );
      case editCouponRoute:
        int couponId = routeSettings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => EditCoupon(
            couponId: couponId,
          ),
        );
      case guestListRoute:
        return MaterialPageRoute(
          builder: (_) => const GuestList(),
        );
      case searchRoute:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
        );
      case myAccountRoute:
        return MaterialPageRoute(
          builder: (_) => const MyAccount(),
        );
      case addCouponRoute:
        return MaterialPageRoute(
          builder: (_) => const AddNewCoupon(),
        );
      case eventDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => const EventDetails(),
        );
      case editEventRoute:
        int eventId = routeSettings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => EditEventScreen(
            eventId: eventId,
          ),
        );
      case ticketRoute:
        int id = routeSettings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => TicketScreen(
            eventId: id,
          ),
        );
      case addTicketRoute:
        int id = routeSettings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => AddTicket(
            eventId: id,
          ),
        );
      case editTicketRoute:
        num ticketId = routeSettings.arguments as num;
        return MaterialPageRoute(
          builder: (_) => EditTicket(ticketId: ticketId),
        );
      case editProfileRoute:
        return MaterialPageRoute(
          builder: (_) => const EditProfileScreen(),
        );
      case createEventRoute:
        return MaterialPageRoute(
          builder: (_) => const CreateEvent(),
        );
    }
    return MaterialPageRoute(
      builder: (_) => const SignInScreen(),
    );
  }
}
