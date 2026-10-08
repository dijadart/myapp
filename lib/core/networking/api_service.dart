// lib/core/networking/api_service.dart

import 'package:advanced_2/core/networking/api_constants.dart';
import 'package:advanced_2/features/interview/data/models/branchmodel.dart';
import 'package:advanced_2/features/interview/data/models/interviewdaymodel.dart';
import 'package:advanced_2/features/interview/data/models/interviewrequestmodel.dart';
import 'package:advanced_2/features/rules/models/rulemodel.dart';
import 'package:advanced_2/login/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:advanced_2/features/interview/data/api_list_response.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(
    Dio dio, {
    String baseUrl,
  }) = _ApiService;

  @GET("Rules")
  Future<List<RuleModel>> getRules();

  @POST(ApiConstants.loginEndpoint)
  Future<UserModel> login(
    @Body() Map<String, dynamic> body,
  );

  @POST("Email/forgot-password/send-otp")
  Future<dynamic> sendForgotPasswordOtp(
    @Body() Map<String, dynamic> body,
  );

  @POST("Email/forgot-password/verify-otp-reset-password")
  Future<dynamic> verifyOtpResetPassword(
    @Body() Map<String, dynamic> body,
  );

  @POST("User/changepassword/{id}")
  Future<void> changePassword(
    @Path("id") String userId,
    @Body() Map<String, dynamic> body,
  );

@GET(ApiConstants.interviewDays)
Future<ApiListResponse<InterviewDayModel>> getInterviewDays();

@GET(ApiConstants.branches)
Future<ApiListResponse<BranchModel>> getBranches();

  @POST(ApiConstants.registerInterview)
  Future<void> registerInterview(
    @Body() Interviewrequestmodel body,
  );
}