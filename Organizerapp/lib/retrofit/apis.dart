class Apis {
  //TODO Setup: Enter your base url here, Might need /public/ before /api/organization/ depending on your server setup
  static const String baseUrl = "https://ticketeve.com/api/organization/"; //do not remove /api/organization/

  static const String settings = 'setting';
  static const String addFeedBack = 'add-feedback';
  static const String followers = 'followers';
  static const String scanner = 'all-scanner';

  // FAQ
  static const String faqs = 'faq';

  // Tax
  static const String tax = 'view-tax';
  static const String addTax = 'add-tax';
  static const String deleteTax = 'delete-tax/{id}';
  static const String editTax = 'edit-tax';
  static const String taxDetail = 'taxDetail/{id}';

  // Tickets
  static const String tickets = 'event-tickets/{id}';
  static const String ticketDetails = 'ticketDetail/{id}';
  static const String addTicket = 'add-ticket';
  static const String editTicket = 'edit-ticket';
  static const String deleteTicket = 'delete-ticket/{id}';
  static const String category = 'category';
  static const String changeTaxStatus = 'change-status-tax/{id}/{status}';

  // Notification
  static const String notification = 'notifications';
  static const String deleteNotification = 'clear-notification';

  // Coupons
  static const String coupons = 'coupons';
  static const String addCoupons = 'add-coupon';
  static const String deleteCoupon = 'delete-coupon/{id}';
  static const String couponEvent = 'coupon-event';
  static const String couponDetails = 'couponDetail/{id}';
  static const String editCoupon = 'edit-coupon';
  // Events
  static const String allEvents = 'all-events';
  static const String addEvent = 'add-event';
  static const String eventDetails = 'eventDetail/{id}';
  static const String editEvents = 'edit-event';
  static const String searchEvent = 'search-events';
  static const String deleteEvent = 'delete-event/{id}';
  static const String cancelEvent = 'cancel-event/{id}';
  static const String guest = 'event-guestList/{id}';
  static const String addGalleryImage = 'add-gallery-image';
  static const String removeGalleryImage = 'remove-gallery';

  // Auth & Profile
  static const String login = 'login';
  static const String register = 'register';
  static const String otpVerify = 'otp-verify';
  static const String forgotPassword = 'forget-password';
  static const String changePassword = 'change-password';
  static const String editProfile = 'edit-profile';
  static const String editProfileImage = 'change-profile-image';

}
