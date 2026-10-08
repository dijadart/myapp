import 'package:json_annotation/json_annotation.dart';

import 'package:flutter/material.dart';
part 'rulemodel.g.dart';

@JsonSerializable()
class RuleModel {
@JsonKey(name: 'rule_id')
  final String? ruleId;
@JsonKey(name: 'rule_name')
final String? ruleName;
@JsonKey(name: 'rule_description')
final String? ruleDescription;
@JsonKey(name: 'rule_type')
final String?  ruleType;
@JsonKey(name: 'rule_pointsToDecrease')
final int? rulePointsToDecrease;
@JsonKey(name: 'rule_imagePath')
final String? ruleImagePath;

  RuleModel({
   this.ruleId,
   this.ruleName,
    this.ruleDescription,
    this.ruleType,
     this.rulePointsToDecrease,
     this.ruleImagePath,
  });

  factory RuleModel.fromJson(Map<String, dynamic> json) => _$RuleModelFromJson(json);
  Map<String, dynamic> toJson() => _$RuleModelToJson(this);

  RuleModel copyWith({
    String? ruleId,
    String? ruleName,
    String? ruleDescription,
    String? ruleType,
    int? rulePointsToDecrease,
    String? ruleImagePath,
  }) {
    return RuleModel(
      ruleId: ruleId ?? this.ruleId,
      ruleName: ruleName ?? this.ruleName,
      ruleDescription: ruleDescription ?? this.ruleDescription,
      ruleType: ruleType ?? this.ruleType,
      rulePointsToDecrease: rulePointsToDecrease ?? this.rulePointsToDecrease,
      ruleImagePath: ruleImagePath ?? this.ruleImagePath,
    );
  }
}