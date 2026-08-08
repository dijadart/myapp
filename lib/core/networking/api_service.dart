import 'package:advanced_2/core/networking/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../login/data/models/user_model.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.loginEndpoint)
  Future<UserModel> login(@Body() Map<String, dynamic> body);
  @POST("Email/forgot-password/send-otp")
  Future<dynamic> sendForgotPasswordOtp(@Body() Map<String, dynamic> body);

  @POST("Email/forgot-password/verify-otp-reset-password")
  Future<dynamic> verifyOtpResetPassword(@Body() Map<String, dynamic> body);
  @POST("User/changepassword/{id}")
  Future<void> changePassword(
    @Path("id") String userId,
    @Body() Map<String, dynamic> body,
  );
}