// lib/features/interview/data/models/api_list_response.dart

import 'package:json_annotation/json_annotation.dart';
import 'package:advanced_2/features/interview/data/models/branchmodel.dart';
import 'package:advanced_2/features/interview/data/models/interviewdaymodel.dart';
part 'api_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiListResponse<T> {
  final List<T> data;
  final int? count;

  const ApiListResponse({
    required this.data,
    this.count,
  });

  factory ApiListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiListResponseFromJson(json, fromJsonT);
}