import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../login/data/repositories/loginrepository.dart';
import '../../user_state.dart';

class UserViewModel extends StateNotifier<UserState> {
  final AuthRepository _authRepository;

  UserViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const UserState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final userModel = await _authRepository.login(email, password);

      state = state.copyWith(
        isLoading: false,
        isLoggedIn: true,
        userProfile: userModel,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoggedIn: false,
        userProfile: null,
        errorMessage: e.toString(),
      );
    }
  }

  void logout() {
    state = const UserState();
  }
}