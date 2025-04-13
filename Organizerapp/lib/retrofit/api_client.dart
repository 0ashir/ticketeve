// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:eventright_organizer/model/add_coupon_model.dart';
import 'package:eventright_organizer/model/add_event_model.dart';
import 'package:eventright_organizer/model/add_feed_back_model.dart';
import 'package:eventright_organizer/model/add_gallery_image_response_model.dart';
import 'package:eventright_organizer/model/add_tax_model.dart';
import 'package:eventright_organizer/model/add_ticket_model.dart';
import 'package:eventright_organizer/model/all_events_model.dart';
import 'package:eventright_organizer/model/cancel_event_model.dart';
import 'package:eventright_organizer/model/category_model.dart';
import 'package:eventright_organizer/model/change_password_model.dart';
import 'package:eventright_organizer/model/change_tax_status_model.dart';
import 'package:eventright_organizer/model/coupon_details_model.dart';
import 'package:eventright_organizer/model/coupon_events_model.dart';
import 'package:eventright_organizer/model/coupons_model.dart';
import 'package:eventright_organizer/model/delete_coupon_model.dart';
import 'package:eventright_organizer/model/delete_event_model.dart';
import 'package:eventright_organizer/model/delete_notification_model.dart';
import 'package:eventright_organizer/model/delete_tax_model.dart';
import 'package:eventright_organizer/model/delete_ticket_model.dart';
import 'package:eventright_organizer/model/edit_coupon_model.dart';
import 'package:eventright_organizer/model/edit_event_model.dart';
import 'package:eventright_organizer/model/edit_profile_image_model.dart';
import 'package:eventright_organizer/model/edit_profile_model.dart';
import 'package:eventright_organizer/model/edit_tax_model.dart';
import 'package:eventright_organizer/model/edit_ticket_model.dart';
import 'package:eventright_organizer/model/event_details_model.dart';
import 'package:eventright_organizer/model/faq_model.dart';
import 'package:eventright_organizer/model/followers_model.dart';
import 'package:eventright_organizer/model/forgot_password_model.dart';
import 'package:eventright_organizer/model/guest_list_model.dart';
import 'package:eventright_organizer/model/login_model.dart';
import 'package:eventright_organizer/model/notification_model.dart';
import 'package:eventright_organizer/model/register_model.dart';
import 'package:eventright_organizer/model/scanner_model.dart';
import 'package:eventright_organizer/model/search_event_model.dart';
import 'package:eventright_organizer/model/setting_model.dart';
import 'package:eventright_organizer/model/tax_detail_model.dart';
import 'package:eventright_organizer/model/tax_model.dart';
import 'package:eventright_organizer/model/ticket_details_model.dart';
import 'package:eventright_organizer/model/tickets_model.dart';
import 'package:retrofit/http.dart';
import 'apis.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Apis.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  /// Endpoint: "login"
  @POST(Apis.login)
  Future<LoginModel> login(@Body() body);

  /// Endpoint: "register"
  @POST(Apis.register)
  Future<RegisterModel> register(@Body() body);

  ///otp verify
  @POST(Apis.otpVerify)
  Future<LoginModel> callVerifyOtp(@Body() Map<String, String> map);
  /// Endpoint: "notifications"
  @GET(Apis.notification)
  Future<NotificationModel> notification();

  /// Endpoint: "setting"
  @GET(Apis.settings)
  Future<SettingModel> settings();

  /// Endpoint: "coupons"
  @GET(Apis.coupons)
  Future<CouponsModel> coupons();

  /// Endpoint: "view-tax"
  @GET(Apis.tax)
  Future<TaxModel> tax();

  /// Endpoint: "add-tax"
  @POST(Apis.addTax)
  Future<AddTaxModel> addTax(@Body() body);

  /// Endpoint: "delete-tax/{id}"
  @GET(Apis.deleteTax)
  Future<DeleteTaxModel> deleteTax(@Path() int? id);

  /// Endpoint: "edit-tax"
  @POST(Apis.editTax)
  Future<EditTaxModel> editTax(@Body() body);

  /// Endpoint: "taxDetail/{id}"
  @GET(Apis.taxDetail)
  Future<TaxDetailModel> taxDetails(@Path() int? id);

  /// Endpoint: "add-coupon"
  @POST(Apis.addCoupons)
  Future<AddCouponModel> addCoupon(@Body() body);

  /// Endpoint: "change-password"
  @POST(Apis.changePassword)
  Future<ChangePasswordModel> changePassword(@Body() body);

  /// Endpoint: "faq"
  @GET(Apis.faqs)
  Future<FaqModel> faqs();

  /// Endpoint: "add-feedback"
  @POST(Apis.addFeedBack)
  Future<AddFeedBackModel> feedBack(@Body() body);

  /// Endpoint: "all-events"
  @GET(Apis.allEvents)
  Future<AllEventsModel> allEvents();

  /// Endpoint: "event-guestList/{id}"
  @GET(Apis.guest)
  Future<GuestListModel> guest(@Path() int? id);

  /// Endpoint: "eventDetail/{id}"
  @GET(Apis.eventDetails)
  Future<EventDetailsModel> eventDetails(@Path() int? id);

  /// Endpoint: "followers"
  @GET(Apis.followers)
  Future<FollowersModel> followers();

  /// Endpoint: "event-tickets/{id}"
  @GET(Apis.tickets)
  Future<TicketsModel> tickets(@Path() int? id);

  /// Endpoint: "edit-ticket"
  @POST(Apis.editTicket)
  Future<EditTicketModel> editTicket(@Body() body);

  /// Endpoint: ticketDetail/{id}
  @GET(Apis.ticketDetails)
  Future<TicketDetailsModel> ticketDetails(@Path() int? id);

  /// Endpoint: "category"
  @GET(Apis.category)
  Future<CategoryModel> category();

  /// Endpoint: "edit-event"
  @POST(Apis.editEvents)
  Future<EditEventModel> editEvent(@Body() body);

  /// Endpoint: "remove-gallery"
  @POST(Apis.removeGalleryImage)
  Future<GalleryImageAddRemoveResponseModel> eventGalleryImageRemove(@Body() body);

  /// Endpoint: "remove-gallery"
  @POST(Apis.addGalleryImage)
  Future<GalleryImageAddRemoveResponseModel> eventGalleryImageAdd(@Body() body);

  /// Endpoint: "add-ticket"
  @POST(Apis.addTicket)
  Future<AddTicketModel> addTicket(@Body() body);

  /// Endpoint: "delete-ticket/{id}"
  @GET(Apis.deleteTicket)
  Future<DeleteTicketModel> deleteTicket(@Path() int? id);

  /// Endpoint: "change-status-tax/{id}/{status}"
  @GET(Apis.changeTaxStatus)
  Future<ChangeTaxStatusModel> changeStatusTax(@Path() int? id, @Path() int? status);

  /// Endpoint: "clear-notification"
  @GET(Apis.deleteNotification)
  Future<DeleteNotificationModel> deleteNotification();

  /// Endpoint: "all-scanner"
  @GET(Apis.scanner)
  Future<ScannerModel> scanners();

  /// Endpoint: "delete-coupon/{id}"
  @GET(Apis.deleteCoupon)
  Future<DeleteCouponModel> deleteCoupon(@Path() int? id);

  /// Endpoint: "coupon-event"
  @GET(Apis.couponEvent)
  Future<CouponEventsModel> couponEvent();

  /// Endpoint: "couponDetail/{id}"
  @GET(Apis.couponDetails)
  Future<CouponDetailsModel> couponDetails(@Path() int? id);

  /// Endpoint: "edit-coupon"
  @POST(Apis.editCoupon)
  Future<EditCouponModel> editCoupon(@Body() body);

  /// Endpoint: "add-event"
  @POST(Apis.addEvent)
  Future<AddEventModel> addEvent(@Body() body);

  /// Endpoint: "search-events"
  @GET(Apis.searchEvent)
  Future<SearchEventModel> searchEvent();

  /// Endpoint: "delete-event/{id}"
  @GET(Apis.deleteEvent)
  Future<DeleteEventModel> deleteEvent(@Path() int? id);

  /// Endpoint: "cancel-event/{id}"
  @GET(Apis.cancelEvent)
  Future<CancelEventModel> cancelEvent(@Path() int? id);

  /// Endpoint: "forget-password"
  @POST(Apis.forgotPassword)
  Future<ForgotPasswordModel> forgotPassword(@Body() body);

  /// Endpoint: "edit-profile"
  @POST(Apis.editProfile)
  Future<EditProfileModel> editProfile(@Body() body);

  /// Endpoint: "change-profile-image"
  @POST(Apis.editProfileImage)
  Future<EditProfileImageModel> editProfileImage(@Body() body);
}
