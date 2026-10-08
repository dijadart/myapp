// lib/features/interview/data/models/branchmodel.dart

import 'package:json_annotation/json_annotation.dart';

part 'branchmodel.g.dart';

@JsonSerializable()
class BranchModel {
  @JsonKey(name: 'branch_Id')
  final String id;

  @JsonKey(name: 'branch_Name')
  final String name;

  final String? location;
  final String? locationUrl;
  final String? city;
  final String? phone;
  final String? whatsApp;

  @JsonKey(fromJson: _toString)
  final String employeesNo;

  @JsonKey(fromJson: _toString)
  final String studentsNo;

  const BranchModel({
    required this.id,
    required this.name,
    this.location,
    this.locationUrl,
    this.city,
    this.phone,
    this.whatsApp,
    this.employeesNo = '0',
    this.studentsNo = '0',
  });

  static String _toString(dynamic value) => value?.toString() ?? '0';

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchModelToJson(this);
}