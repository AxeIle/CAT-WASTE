import 'package:flutter/material.dart';
import 'package:login/authentication/signIn/login.dart';
import 'package:login/user/user_home/user_home.dart';
import 'package:login/user/user_main.dart';
//import 'package:login/test_c.dart';

//creating a splash screen that displays for few seconds while app is opening and then redirecting to the login page,currently delaying a few minutes.
class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    gotoLogin();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        "assets/images/splash/logo.png",
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => SignInScreen(),
      ),
    );
  }
//   Future<void> gotoLogin() async {
//   await Future.delayed(Duration(seconds: 10)); // Corrected usage of Future.delayed
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (ctx) => ScreenHome(),
//     ),
//   );
// }
}
