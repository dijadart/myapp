import 'package:advanced_2/core/networking/api_service.dart';
import 'package:advanced_2/user_providers.dart';
import'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rulemodel.dart';
import '../../../login/data/repositories/loginrepository.dart';

final ruleProvider = FutureProvider<List<RuleModel>>((ref) async {
  final ApiService apiService = ref.watch(apiServiceProvider);
  return await apiService.getRules();
});