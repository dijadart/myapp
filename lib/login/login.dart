import 'package:advanced_2/user_providers.dart';
import 'package:advanced_2/user_state.dart';
import 'views/home_view.dart'; // Make sure this import points to your HomeView file
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerWidget {
  Login({super.key, required this.visibilityProvider});

  final StateProvider<bool> visibilityProvider;

  // Controllers are kept clean at the class level to preserve input string state
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isObscured = ref.watch(visibilityProvider);
    
    // Watch state to dynamically trigger the loading spinner or get profiles
    final userState = ref.watch(userViewModelProvider);

    // ✅ CORRECT POSITION: This listens directly inside build, completely separate from the UI widgets tree
    ref.listen<UserState>(userViewModelProvider, (previous, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      }
      if (next.isLoggedIn && next.userProfile != null) {
        // Navigates securely using your established AppRoutes class
        Navigator.pushReplacementNamed(context, AppRoutes.home); 
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/download (1).png', 
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              width: 360, 
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(16.0), 
                boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 20,
    offset: const Offset(0, 10),
  ),
],

              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/Jupiter Logo raw.png',
                      height: 80, 
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: emailController, 
                    decoration: InputDecoration(
                      hintText: 'enter your username',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Color(0xFF6A0DAD), width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: passwordController, 
                    obscureText: isObscured,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'enter your password',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                      suffixIcon: IconButton(
                        icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off), 
                        color: Colors.purple,
                        onPressed: () {
                          ref.read(visibilityProvider.notifier).state = !isObscured;
                        },
                      ), 
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Color(0xFF6A0DAD), width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: userState.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6A0DAD)),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              ref.read(userViewModelProvider.notifier).login(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6A0DAD), 
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
