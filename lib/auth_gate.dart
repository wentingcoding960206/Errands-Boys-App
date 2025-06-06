import 'package:errands_boys/login_or_register.dart';
import 'package:errands_boys/screen_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if(snapshot.hasData) {
            return ScreenManager(initialSelectedTabIndex: 0,);
          }

          // user is logged out
          else {
            return const LoginOrRegister();
          }
        },
      )
    );
  }
}