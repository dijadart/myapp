// lib/features/interview/data/repositories/interview_repository.dart

import 'package:advanced_2/core/networking/api_service.dart';
import 'package:advanced_2/core/networking/errrorhandler.dart';
import 'package:advanced_2/features/interview/data/models/branchmodel.dart';
import 'package:advanced_2/features/interview/data/models/interviewrequestmodel.dart';

class InterviewRepository {
  final ApiService _apiService;

  InterviewRepository(this._apiService);

 Future<List<String>> getInterviewDays() async {
  try {
    final response = await _apiService.getInterviewDays();
    // response is ApiListResponse<InterviewDayModel>
    return response.data
        .where((d) => d.isAllowed && !d.isDeleted)
        .map((d) => d.dayName)
        .toSet() // unique names
        .toList();
  } catch (e) {
    throw ErrorHandler.handleError(e);
  }
}

Future<List<BranchModel>> getBranches() async {
  try {
    final response = await _apiService.getBranches();
    // response is ApiListResponse<BranchModel>
    return response.data;
  } catch (e) {
    throw ErrorHandler.handleError(e);
  }
}
  Future<String> registerInterview(
    Interviewrequestmodel interviewRequest,
  ) async {
    try {
      await _apiService.registerInterview(interviewRequest);

      return "Interview registered successfully";
    } catch (e) {
      throw ErrorHandler.handleError(e);
    }
  }
}