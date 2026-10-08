// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interviewrequestmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Interviewrequestmodel _$InterviewrequestmodelFromJson(
  Map<String, dynamic> json,
) => Interviewrequestmodel(
  branch: json['branch'] as String,
  dateOfBirth: json['dateOfBirth'] as String,
  interviewDate: json['interviewDate'] as String,
  interviewDay: json['interviewDay'] as String,
  interviewTime: json['interviewTime'] as String,
  isDone: json['isDone'] as bool,
  phoneNumber: json['phoneNumber'] as String,
  referral: json['referral'] as String,
  studentName: json['studentName'] as String,
  whatsApp: json['whatsApp'] as String,
);

Map<String, dynamic> _$InterviewrequestmodelToJson(
  Interviewrequestmodel instance,
) => <String, dynamic>{
  'branch': instance.branch,
  'dateOfBirth': instance.dateOfBirth,
  'interviewDate': instance.interviewDate,
  'interviewDay': instance.interviewDay,
  'interviewTime': instance.interviewTime,
  'isDone': instance.isDone,
  'phoneNumber': instance.phoneNumber,
  'referral': instance.referral,
  'studentName': instance.studentName,
  'whatsApp': instance.whatsApp,
};
