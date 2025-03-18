import 'package:flutter/material.dart';
import 'package:project_firebase/pages/login_page.dart';
import 'package:project_firebase/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //toggle between login and register pages
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  //function to handle firebase authentication errors
  String getFirebaseErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'The email adress is not valid.';
      case 'email-already-in-use':
        return 'This email adress is already registered. Please log in';
      case 'user-not-found':
        return 'No account found with this email. Please sign up.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password';
      case 'too many requests':
        return 'Too many failed attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Check your internet.';
      case 'user-disabled':
        return 'This account is disabled. Contact support for help.';
      default:
        return 'An unknown error occured. Try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        showRegisterPage: toggleScreens,
        getFirebaseErrorMessage: getFirebaseErrorMessage, // pass the function
      );
    } else {
      return RegisterPage(
        showLoginPage: toggleScreens,
        getFirebaseErrorMessage: getFirebaseErrorMessage, // pass the function
      );
    }
  }
}
