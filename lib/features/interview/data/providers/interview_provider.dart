// lib/features/interview/data/providers/interview_provider.dart

import 'package:advanced_2/core/networking/api_service.dart';
import 'package:advanced_2/features/interview/data/models/interviewrequestmodel.dart';
import 'package:advanced_2/features/interview/data/repositories/interview_repository.dart';
import 'package:advanced_2/user_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final interviewRepositoryProvider =
    Provider<InterviewRepository>((ref) {
  final ApiService apiService = ref.watch(apiServiceProvider);

  return InterviewRepository(apiService);
});

final interviewDaysProvider =
    FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(interviewRepositoryProvider);

  return repository.getInterviewDays();
});

final branchesProvider =
    FutureProvider((ref) async {
  final repository = ref.watch(interviewRepositoryProvider);

  return repository.getBranches();
});

final interviewProvider =
    FutureProvider.family<String, Interviewrequestmodel>(
  (ref, interviewRequest) async {
    final repository = ref.watch(interviewRepositoryProvider);

    return repository.registerInterview(interviewRequest);
  },
);