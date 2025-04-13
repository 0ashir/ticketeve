/// This class contains all the apis used in the app
/// To generate the api_client.g.dart file run the below command in terminal
/// flutter pub run build_runner build --delete-conflicting-outputs
/// Every time you change the api_client.dart file you need to run the above command
/// To watch the changes run the below command in terminal
/// flutter pub run build_runner watch --delete-conflicting-outputs
class Apis {
  // After changing the base url run the below command in terminal:
  // dart run build_runner build --delete-conflicting-outputs
  // static const String baseUrl = "https://_enter_your_base_url_here_/api/user/"; //do not remove /api/user/
  static const String baseUrl = "https://ticketeve.com/api/user/"; //do not remove /api/user/

  static const String login = 'login';
  static const String register = 'register';
  static const String otpVerify = "otp-verify";
  static const String userLike = 'user-likes';
  static const String order = 'user-order';
  static const String notification = 'user-notification';
  static const String organization = 'organization';
  static const String following = 'user-following';
  static const String addFollowing = 'add-following-list';
  static const String singleOrderDetails = 'view-single-order/{id}';
  static const String addReview = 'add-review';
  static const String allEvents = 'events';
  static const String eventsDetails = 'event-detail/{id}';
  static const String eventsTicket = 'event-tickets/{id}';
  static const String ticketDetails = 'ticket-detail/{id}';
  static const String allTax = 'order-tax/{id}';
  static const String addFavorite = 'add-favorite';
  static const String category = 'category';
  static const String searchEvent = 'search-event';
  static const String setting = 'setting';
  static const String checkCode = 'check-code';
  static const String coupon = 'all-coupon';
  static const String bookOrder = 'create-order';
  static const String reportEvent = 'report-event';
  static const String clearNotification = 'clear-notification';
  static const String updateImage = 'change-profile-image';
  static const String updateProfile = 'edit-profile';
  static const String changePassword = 'change-password';
  static const String forgetPassword = "forget-password";
  static const String seatMap = "seatmap/{id}";
  static const String wallet = "get-wallet";
  static const String walletDeposit = "wallet-deposit";
}
