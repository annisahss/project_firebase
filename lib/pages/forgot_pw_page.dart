import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  //text controllers
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple[200], elevation: 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter your email and we will send you a password reset link',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),

          SizedBox(height: 10),

          //email textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Email',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          SizedBox(height: 10),

          MaterialButton(
            onPressed: () {},
            color: Colors.deepPurple[200],
            child: Text('Reset Password'),
          ),
        ],
      ),
    );
  }
}
