import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kinbech/auth/authpage.dart';
import 'package:kinbech/optionpage.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          return const OptionPage();
        }
        else{
          return
          const AuthPage();

        }
      },
      ),
    );
  }
}
