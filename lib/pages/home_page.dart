import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_firebase/auth/auth_page.dart';
import 'package:project_firebase/services/auth_service.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  final user = FirebaseAuth.instance.currentUser!;

  //sign user out method
  void signUserOut() {
    _authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
      ),
      body: Center(
        child: Text(
          'LOGGED IN AS: ' + user.email!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
