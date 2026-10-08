// lib/features/interview/data/models/interviewrequestmodel.dart

import 'package:json_annotation/json_annotation.dart';

part 'interviewrequestmodel.g.dart';

@JsonSerializable()
class Interviewrequestmodel {
  final String branch;
  final String dateOfBirth;
  final String interviewDate;
  final String interviewDay;
  final String interviewTime;
  final bool isDone;
  final String phoneNumber;
  final String referral;
  final String studentName;
  final String whatsApp;

  const Interviewrequestmodel({
    required this.branch,
    required this.dateOfBirth,
    required this.interviewDate,
    required this.interviewDay,
    required this.interviewTime,
    required this.isDone,
    required this.phoneNumber,
    required this.referral,
    required this.studentName,
    required this.whatsApp,
  });

  factory Interviewrequestmodel.fromJson(Map<String, dynamic> json) =>
      _$InterviewrequestmodelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$InterviewrequestmodelToJson(this);
}