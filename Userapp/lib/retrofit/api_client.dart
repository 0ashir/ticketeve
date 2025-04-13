// TODO: Seat Mapping Module: Step 3: Uncomment Following if you want to add this module
// import 'package:eventright_pro_user/SeatMap/seating_model_response.dart';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:eventright_pro_user/model/add_favorite_model.dart';
import 'package:eventright_pro_user/model/add_following_model.dart';
import 'package:eventright_pro_user/model/add_review_model.dart';
import 'package:eventright_pro_user/model/all_events_model.dart';
import 'package:eventright_pro_user/model/all_tax_model.dart';
import 'package:eventright_pro_user/model/book_order_model.dart';
import 'package:eventright_pro_user/model/change_password_model.dart';
import 'package:eventright_pro_user/model/check_coupon_code_model.dart';
import 'package:eventright_pro_user/model/coupon_model.dart';
import 'package:eventright_pro_user/model/delete_notification_model.dart';
import 'package:eventright_pro_user/model/edit_user_profile_model.dart';
import 'package:eventright_pro_user/model/event_tickets_model.dart';
import 'package:eventright_pro_user/model/events_detail_model.dart';
import 'package:eventright_pro_user/model/favorite_model.dart';
import 'package:eventright_pro_user/model/following_model.dart';
import 'package:eventright_pro_user/model/login_model.dart';
import 'package:eventright_pro_user/model/notification_model.dart';
import 'package:eventright_pro_user/model/order_model.dart';
import 'package:eventright_pro_user/model/organization_model.dart';
import 'package:eventright_pro_user/model/register_model.dart';
import 'package:eventright_pro_user/model/report_event_model.dart';
import 'package:eventright_pro_user/model/search_event_model.dart';
import 'package:eventright_pro_user/model/setting_model.dart';
import 'package:eventright_pro_user/model/single_order_details_model.dart';
import 'package:eventright_pro_user/model/ticket_details_model.dart';
import 'package:eventright_pro_user/model/update_profile_image_model.dart';
import 'package:eventright_pro_user/model/wallet_deposit_response_model.dart';
import 'package:eventright_pro_user/model/wallet_model.dart';
import 'package:eventright_pro_user/retrofit/apis.dart';
import 'package:retrofit/retrofit.dart';
import 'package:eventright_pro_user/model/category_model.dart';
import 'package:eventright_pro_user/model/forgot_password_model.dart';
part 'api_client.g.dart';

/// This class is used to call the apis using retrofit
/// To generate the api_client.g.dart file run the below command in terminal
/// flutter pub run build_runner build --delete-conflicting-outputs
/// Every time you change the api_client.dart file you need to run the above command
/// To watch the changes in part file as you modify the code run the below command in terminal
/// dart run build_runner watch --delete-conflicting-outputs
@RestApi(baseUrl: Apis.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST(Apis.login)
  Future<LoginModel> login(@Body() body);

  @GET(Apis.userLike)
  Future<FavoriteModel> favorite();

  @POST(Apis.register)
  Future<RegisterModel> register(@Body() body);

  @GET(Apis.order)
  Future<OrderModel> order();

  @GET(Apis.organization)
  Future<OrganizationModel> organization();

  @POST(Apis.addFollowing)
  Future<AddFollowingModel> addFollowing(@Body() body);
  //
  @GET(Apis.notification)
  Future<NotificationModel> notification();

  @POST(Apis.addReview)
  Future<AddReviewModel> addReview(@Body() body);

  @GET(Apis.following)
  Future<FollowingModel> following();

  @GET(Apis.singleOrderDetails)
  Future<SingleOrderDetailsModel> singleOrderDetails(@Path() int? id);

  @GET(Apis.eventsDetails)
  Future<EventsDetailModel> eventDetails(@Path() int? id);

  @POST(Apis.allEvents)
  Future<AllEventsModel> allEvents(@Body() body);

  @GET(Apis.eventsTicket)
  Future<EventTicketsModel> eventTickets(@Path() int? id);

  @GET(Apis.ticketDetails)
  Future<TicketDetailsModel> ticketDetails(@Path() int? id);

  @GET(Apis.allTax)
  Future<AllTaxModel> allTax(@Path() int? id);

  @POST(Apis.addFavorite)
  Future<AddFavoriteModel> addFavorite(@Body() body);

  @GET(Apis.category)
  Future<CategoryModel> category();

  @POST(Apis.searchEvent)
  Future<SearchEventModel> searchEvent(@Body() body);

  @GET(Apis.setting)
  Future<SettingModel> setting();

  @POST(Apis.checkCode)
  Future<CheckCouponCodeModel> checkCouponCode(@Body() body);

  @GET(Apis.coupon)
  Future<CouponModel> coupon();

  @POST(Apis.bookOrder)
  Future<BookOrderModel> bookOrder(@Body() body);

  @POST(Apis.reportEvent)
  Future<ReportEventModel> reportEvent(@Body() body);

  @GET(Apis.clearNotification)
  Future<DeleteNotificationModel> deleteNotification();

  @POST(Apis.updateImage)
  Future<UpdateProfileImageModel> updateImage(@Body() body);

  @POST(Apis.updateProfile)
  Future<EditUserProfileModel> updateProfile(@Body() body);

  @POST(Apis.changePassword)
  Future<ChangePasswordModel> changePassword(@Body() body);

  @POST(Apis.forgetPassword)
  Future<ForgotPasswordModel> forgotPassword(@Body() Map<String, String> map);

  @POST(Apis.otpVerify)
  Future<LoginModel> callVerifyOtp(@Body() Map<String, String> map);

  @GET(Apis.wallet)
  Future<WalletModel> wallet();

  @POST(Apis.walletDeposit)
  Future<WalletDepositResponseModel> walletDeposit(@Body() body);

  // TODO: Seat Mapping Module: Step 4: Uncomment Following if you want to add this module
  // @GET(Apis.seatMap)
  // Future<SeatingModelResponse> callGetSeatMap(@Path() int? id);
}
