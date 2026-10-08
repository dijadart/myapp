// lib/features/interview/data/models/interview_day_model.dart

class InterviewDayModel {
  final String dayId;
  final String dayName;
  final bool isAllowed;
  final String branch;
  final bool isDeleted;

  const InterviewDayModel({
    required this.dayId,
    required this.dayName,
    required this.isAllowed,
    required this.branch,
    required this.isDeleted,
  });

  factory InterviewDayModel.fromJson(Map<String, dynamic> json) {
    return InterviewDayModel(
      dayId: json['dayId'] as String? ?? '',
      dayName: json['dayName'] as String? ?? '',
      isAllowed: json['isAllowed'] as bool? ?? false,
      branch: json['branch'] as String? ?? '',
      isDeleted: json['isDeleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayId': dayId,
      'dayName': dayName,
      'isAllowed': isAllowed,
      'branch': branch,
      'isDeleted': isDeleted,
    };
  }
}