import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_firebase/pages/auth/auth_page.dart';
import 'package:project_firebase/firebase_options.dart';
import 'package:project_firebase/pages/home_screen.dart';
import 'package:project_firebase/services/storage/storage_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => StorageService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AuthPage());
  }
}
