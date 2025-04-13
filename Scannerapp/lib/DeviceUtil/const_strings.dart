import 'package:intl/intl.dart';

class ConstString {
  static const String isLoggedIn = "isLogin";
  static const String authToken = "authToken";
  static const String currentLanguageCode = "currentLanguageCode";
  static const String name = "name";
  static const String email = "email";
  static const String phone = "phone";
  static const String image = "image";
  static const String currencySymbol = "currencySymbol";
  static const String appVersion="appVersion";
}

class DateUtilShow {
  static const dateFormat = 'MMM, dd';

  String formattedDate(DateTime dateTime) {
    return DateFormat(dateFormat).format(dateTime);
  }
}

class DateUtilShow1 {
  static const dateFormat = 'dd MMM yy - hh:mm a';

  String formattedDate(DateTime dateTime) {
    return DateFormat(dateFormat).format(dateTime);
  }
}
