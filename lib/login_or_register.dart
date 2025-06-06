import 'package:errands_boys/login_screen/login_chatpages.dart';
import 'package:errands_boys/sign_up_screen.dart/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginChatpages(
        onTap: togglePages
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}