// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rulemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleModel _$RuleModelFromJson(Map<String, dynamic> json) => RuleModel(
  ruleId: json['rule_id'] as String?,
  ruleName: json['rule_name'] as String?,
  ruleDescription: json['rule_description'] as String?,
  ruleType: json['rule_type'] as String?,
  rulePointsToDecrease: (json['rule_pointsToDecrease'] as num?)?.toInt(),
  ruleImagePath: json['rule_imagePath'] as String?,
);

Map<String, dynamic> _$RuleModelToJson(RuleModel instance) => <String, dynamic>{
  'rule_id': instance.ruleId,
  'rule_name': instance.ruleName,
  'rule_description': instance.ruleDescription,
  'rule_type': instance.ruleType,
  'rule_pointsToDecrease': instance.rulePointsToDecrease,
  'rule_imagePath': instance.ruleImagePath,
};
