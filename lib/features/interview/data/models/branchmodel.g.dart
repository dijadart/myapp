// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branchmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
  id: json['branch_Id'] as String,
  name: json['branch_Name'] as String,
  location: json['location'] as String?,
  locationUrl: json['locationUrl'] as String?,
  city: json['city'] as String?,
  phone: json['phone'] as String?,
  whatsApp: json['whatsApp'] as String?,
  employeesNo: json['employeesNo'] == null
      ? '0'
      : BranchModel._toString(json['employeesNo']),
  studentsNo: json['studentsNo'] == null
      ? '0'
      : BranchModel._toString(json['studentsNo']),
);

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      'branch_Id': instance.id,
      'branch_Name': instance.name,
      'location': instance.location,
      'locationUrl': instance.locationUrl,
      'city': instance.city,
      'phone': instance.phone,
      'whatsApp': instance.whatsApp,
      'employeesNo': instance.employeesNo,
      'studentsNo': instance.studentsNo,
    };
