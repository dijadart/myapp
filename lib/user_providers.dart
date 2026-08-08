import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../core/networking/dio_factory.dart';
import '../../core/networking/api_service.dart';
import '../../login/data/repositories/loginrepository.dart';
import 'user_state.dart';
import 'login/viewmodels/user_view_model.dart';

// Networking Providers
final dioProvider = Provider<Dio>((ref) {
  return DioFactory.getDio();
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthRepository(apiService);
});

// Master User View Model Provider
final userViewModelProvider =
    StateNotifierProvider<UserViewModel, UserState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return UserViewModel(authRepository: authRepository);
});

// Safe Computed Providers
final isInstructorProvider = Provider<bool>((ref) {
  final userState = ref.watch(userViewModelProvider);
  final role = userState.userProfile?.role?.toLowerCase();
  return role == 'instructor';
});

final isLoggedInProvider = Provider<bool>((ref) {
  final userState = ref.watch(userViewModelProvider);
  return userState.isLoggedIn;
});

final isAdminOrManagerProvider = Provider<bool>((ref) {
  final userState = ref.watch(userViewModelProvider);
  final role = userState.userProfile?.role?.toLowerCase();
  return role == 'admin' || role == 'manager';
});