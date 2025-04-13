import 'package:dio/dio.dart';
import 'package:event_right_scanner/Models/auth_model.dart';
import 'package:event_right_scanner/Models/event_detail_model.dart';
import 'package:event_right_scanner/Models/profile_model.dart';
import 'package:event_right_scanner/Models/single_ticket_model.dart';
// ignore: depend_on_referenced_packages
import 'package:retrofit/http.dart';
import 'package:event_right_scanner/Models/all_event_model.dart';
import 'package:event_right_scanner/Models/attendance_model.dart';
import 'package:event_right_scanner/Models/scanner_model.dart';
import 'package:event_right_scanner/Models/setting_model.dart';
import 'package:event_right_scanner/api/apis.dart';

part 'network_api.g.dart';

@RestApi(baseUrl: Apis.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(Apis.login)
  Future<AuthModel> loginRequest(@Body() body);

  @GET(Apis.allEvent)
  Future<AllEventModel> allEventRequest();

  @GET(Apis.setting)
  Future<SettingModel> settingRequest();

  @GET(Apis.eventDetail)
  Future<EventDetailModel> eventDetailRequest(@Path() int id);

  @GET(Apis.profile)
  Future<ProfileModel> profileRequest();

  @GET(Apis.scanner)
  Future<ScannerModel> scannerRequest(@Path() String ticketNumber, @Path() int id);

  @GET(Apis.attendance)
  Future<AttendanceModel> attendanceRequest(@Path() int id);

  @GET(Apis.singleTicket)
  Future<SingleTicketModel> singleTicketRequest(@Path() int id);
}

// flutter pub run build_runner build --delete-conflicting-outputs
