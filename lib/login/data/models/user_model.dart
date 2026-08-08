import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String token;
  final String username;
  final String expiryDate;

  @JsonKey(name: 'user_id')
  final String userId;

  final String role;
  final String? profileURL;
  final String? branch;

  const UserModel({
    required this.token,
    required this.username,
    required this.expiryDate,
    required this.userId,
    required this.role,
    this.profileURL,
    this.branch,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}