import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_firebase/components/square_tile.dart';
import 'package:project_firebase/pages/forgot_pw_page.dart';
import 'package:project_firebase/components/my_button.dart';
import 'package:project_firebase/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  final String Function(String) getFirebaseErrorMessage;
  final String? Function({
    String? email,
    String? password,
    String? confirmPassword,
  })
  validateInput;

  const RegisterPage({
    required this.showLoginPage,
    required this.getFirebaseErrorMessage,
    required this.validateInput,
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    String email: _emailController.text.trim();
    String password: _passwordController.text.trim();
    String confirmPassword: _passwordController.text.trim();

    //use centralized validation
    String? errorMessage = widget.validateInput(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    if (errorMessage != null) {
      showToast(errorMessage);
      return;
    }

    //try creating the user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Fluttertoast.showToast(
        msg: 'Registration successful!',
        backgroundColor: Colors.green,
      );
    } on FirebaseAuthException catch (e) {
      showToast(widget.getFirebaseErrorMessage(e.code));
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // change the icon or logo
                Icon(Icons.phone_android, size: 50),
                SizedBox(height: 25),

                //Welcome
                Text('Welcome', style: GoogleFonts.bebasNeue(fontSize: 52)),
                SizedBox(height: 10),

                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                ),
                SizedBox(height: 25),

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
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // confirm password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgotPasswordPage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25),

                //sign up button
                MyButton(text: 'Sign Up', onTap: signUp),

                const SizedBox(height: 25),

                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[700]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                //google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.png',
                    ),

                    SizedBox(width: 10),
                    // //apple button
                    // SquareTile(imagePath: 'lib/images/apple.jpg'),
                  ],
                ),

                const SizedBox(height: 25),

                // i am a member? login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'I am a member',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        ' Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
