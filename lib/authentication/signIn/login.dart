import 'package:flutter/material.dart';
// 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/authentication/signUp/signUp.dart';
import 'package:login/authentication/splash/splashsreen.dart';
import 'package:login/resueable/reuseable_widget.dart';
import 'package:login/user/user_main.dart';
//import 'package:login/user/user_main.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signIn() async {
    try {
      String email = emailController.text;
      String password = passwordController.text;

      // Store the context in a local variable
      BuildContext localContext = context;

      // Sign in with email and password
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If successful, navigate to HomeScreen using the local context
      Navigator.push(
          localContext, MaterialPageRoute(builder: (_) => ScreenHome()));
    } catch (e) {
      // Handle sign-in errors
      print('Error signing in: $e');
    }
  }

  Widget handleForgotPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ScreenSplash())),
      ),
    );
  }

  Row navigateToSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalyzing Waste'),
        backgroundColor: Color.fromARGB(255, 3, 155, 69),
      ),
      body: Container(
          color: const Color.fromARGB(255, 2, 133, 6),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                  child: Column(children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    reusableTextField("Enter UserName", Icons.person_outline,
                        false, emailController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outline,
                        true, passwordController),
                    const SizedBox(
                      height: 5,
                    ),
                    handleForgotPassword(context),
                    firebaseUIButton(context, "Sign In", () => signIn()),
                    navigateToSignUp(),

                    // forgetPassword(context),
                  ])))),
    );
  }

//signup & forgot password options

  // Row signUpOption() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       const Text("Don't have account?",
  //           style: TextStyle(color: Colors.white70)),
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.push(context,
  //               MaterialPageRoute(builder: (context) => SignUpScreen()));
  //         },
  //         child: const Text(
  //           " Sign Up",
  //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget forgetPassword(BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     height: 35,
  //     alignment: Alignment.bottomRight,
  //     child: TextButton(
  //       child: const Text(
  //         "Forgot Password?",
  //         style: TextStyle(color: Colors.white70),
  //         textAlign: TextAlign.right,
  //       ),
  //       onPressed: () => Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => ScreenSplash())),
  //     ),
  //   );
  // }
}
