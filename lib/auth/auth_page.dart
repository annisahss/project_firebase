import 'package:flutter/material.dart';
import 'package:project_firebase/pages/login_page.dart';
import 'package:project_firebase/pages/register_page.dart';
import 'package:project_firebase/services/auth_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;
  final AuthService _authService = AuthService();

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  // Validation function for RegisterPage
  String? validateInput({
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    if (email == null || email.isEmpty) return "Email cannot be empty";
    if (!RegExp(
      r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
    ).hasMatch(email)) {
      return "Enter a valid email address";
    }
    if (password == null || password.isEmpty) return "Password cannot be empty";
    if (password.length < 6)
      return "Password must be at least 6 characters long";
    if (confirmPassword == null || confirmPassword.isEmpty)
      return "Confirm password cannot be empty";
    if (password != confirmPassword) return "Passwords do not match";

    return null; // No validation errors
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage
        ? LoginPage(
          showRegisterPage: toggleScreens,
          getFirebaseErrorMessage: _authService.getFirebaseErrorMessage,
          signInWithGoogle:
              _authService
                  .signInWithGoogle, // ✅ FIXED: Ensure Google Sign-in is passed
        )
        : RegisterPage(
          showLoginPage: toggleScreens,
          getFirebaseErrorMessage: _authService.getFirebaseErrorMessage,
          validateInput:
              validateInput, // ✅ FIXED: Ensure function signature matches expected format
          signInWithGoogle:
              _authService
                  .signInWithGoogle, // ✅ FIXED: Ensure Google Sign-in is passed
        );
  }
}
