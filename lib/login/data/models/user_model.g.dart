// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  token: json['token'] as String,
  username: json['username'] as String,
  expiryDate: json['expiryDate'] as String,
  userId: json['user_id'] as String,
  role: json['role'] as String,
  profileURL: json['profileURL'] as String?,
  branch: json['branch'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'token': instance.token,
  'username': instance.username,
  'expiryDate': instance.expiryDate,
  'user_id': instance.userId,
  'role': instance.role,
  'profileURL': instance.profileURL,
  'branch': instance.branch,
};
