
import 'package:advanced_2/core/networking/api_service.dart';

import '../../../core/networking/errrorhandler.dart';
import '../models/user_model.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  /// Function to call login API
  Future<UserModel> login(String email, String password) async {
    try {
      final user = await _apiService.login({
        'email': email,
        'password': password,
      });
      return user; // UserModel
    } catch (e) {
      throw ErrorHandler.handleError(e);
    }
  }

  Future<void> sendForgotPasswordOtp(String email) async {
    try {
      await _apiService.sendForgotPasswordOtp({'email': email});
    } catch (e) {
      throw ErrorHandler.handleError(e);
    }
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      await _apiService.verifyOtpResetPassword({
        'email': email,
        'OtpCode': otp,
        'newPassword': newPassword,
      });
    } catch (e) {
      throw ErrorHandler.handleError(e);
    }
  }
}