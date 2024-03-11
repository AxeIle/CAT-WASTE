import 'package:flutter/material.dart';
import 'package:login/authentication/repository/user_repository.dart';
import 'package:login/authentication/splash/splashsreen.dart';
import 'package:login/resueable/reuseable_widget.dart';
//import 'package:login/user/user_main.dart';

class SignInScreen extends StatefulWidget {

  const SignInScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void signIn(formKey) async {
    if (await formKey.currentState!.validate()) {
      await AuthServices.signinUser(
          _emailController.text, _passwordController.text, context);
    }
    // try {
    //   String email = emailController.text;
    //   String password = passwordController.text;

    //   // Store the context in a local variable
    //   BuildContext localContext = context;

    // Sign in with email and password
    // await _auth.signInWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // );

    // If successful, navigate to HomeScreen using the local context
    //   Navigator.push(
    //       localContext, MaterialPageRoute(builder: (_) => ScreenHome()));
    // } catch (e) {
    //   // Handle sign-in errors
    //   print('Error signing in: $e');
    // }
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Catalyzing Waste',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 133, 86, 105),
        ),
        body: Container(
            color:  Color.fromARGB(255, 21, 24, 29),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                    child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                            reusableTextField("Enter Email",
                                Icons.person_outline, false, _emailController),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextField("Enter Password", Icons.lock_outline,
                            true, _passwordController),
                        const SizedBox(
                          height: 5,
                        ),
                        handleForgotPassword(context),
                        firebaseUIButton(
                            context, "Sign In", () => signIn(_formKey)),
                        navigateToSignUp("Sign Up", true, context),

                        // forgetPassword(context),
                      ]),
                    )))),
      ),
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
