import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/firebase_options.dart';
import 'package:login/authentication/signIn/login.dart';
import 'package:login/authentication/signUp/signUp.dart';
import 'package:login/authentication/splash/splashsreen.dart';
import 'package:login/user/user_main.dart'; // Import your sign-up screen file

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => ScreenSplash(), // Set the initial screen
        '/signin': (context) =>
            SignInScreen(), // Define the sign-in screen route
        '/signup': (context) => SignUpScreen(),
        '/user': (context) => ScreenHome(), // Define the sign-up screen route
      },
    );
  }
}
