import 'package:flutter/material.dart';
import 'package:kinbech/auth/login.dart';
import 'package:kinbech/auth/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially show login page
  bool showLoginpage = true;
  void toggleScreens() {
    setState(() {
      showLoginpage = !showLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginpage) {
      return Loginpage(showSignupPage: toggleScreens);
    } else {
      return SignupPage(showLoginpage: toggleScreens);
    }
  }
}
