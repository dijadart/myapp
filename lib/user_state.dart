import 'login/data/models/user_model.dart';

class UserState {
  final bool isLoading;
  final bool isLoggedIn;
  final UserModel? userProfile;
  final String? errorMessage;

  const UserState({
    this.isLoading = false,
    this.isLoggedIn = false,
    this.userProfile,
    this.errorMessage,
  });

  UserState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    UserModel? userProfile,
    String? errorMessage,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      userProfile: userProfile ?? this.userProfile,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}