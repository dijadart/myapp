import 'package:advanced_2/login/views/register_interview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:advanced_2/core/theming/theme_provider.dart';
import 'package:advanced_2/login/login.dart';
import 'package:advanced_2/login/views/home_view.dart'; // adjust path if needed


final visibilityProvider = StateProvider<bool>((ref) => false);

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    

    return ScreenUtilInit(                    // ← ADD THIS
      designSize: const Size(375, 812),       // iPhone X size (common default)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Jupiter Academy',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF6A0DAD),
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.grey[50],
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF6A0DAD),
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
            scaffoldBackgroundColor: const Color.fromARGB(255, 32, 17, 40),
          ),
          home: Login(visibilityProvider: visibilityProvider),// Set the initial route to RegisterInterviewPage
        );
      },
    );
  }
}