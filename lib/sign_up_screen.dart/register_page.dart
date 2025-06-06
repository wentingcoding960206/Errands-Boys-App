import 'package:errands_boys/auth_service.dart';
import 'package:errands_boys/sign_up_screen.dart/signup_textfiled.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key, required this.onTap});
  final TextEditingController sign_up_screen_email_textFieldController =
      TextEditingController();
  final String sign_up_email_label = "Email";

  final TextEditingController sign_up_screen_fullname_textFieldController =
      TextEditingController();
  final String sign_up_fullname_label = "Full Name";

  final TextEditingController sign_up_screen_birthdate_textFieldController =
      TextEditingController();
  final String sign_up_birthdate_label = "Birth Date";

  final TextEditingController sign_up_screen_password_textFieldController =
      TextEditingController();
  final String sign_up_password_label = "Password";

  final TextEditingController
  sign_up_screen_repeatpassword_textFieldController = TextEditingController();
  final String sign_up_repeatpassword_label = "Password Again";

  final void Function()? onTap;

  void register(BuildContext context) async{
    // get auth service
    final auth = AuthService();

    // Password match ->
    if (sign_up_screen_password_textFieldController.text ==
        sign_up_screen_repeatpassword_textFieldController.text) {
      try {
        print('sign up');
        await auth.signUpWithEmailPassword(
          sign_up_screen_email_textFieldController.text,
          sign_up_screen_password_textFieldController.text,
        );
      } catch (e) {
        // Handle unexpected errors
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(content: Text(e.toString())),
        );
      }
    }
    // password don't match
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text("Passwords don't match")),
      );
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            children: [
              // Email TextField
              SignUpTextField(
                sign_up_screen_textFieldController:
                    sign_up_screen_email_textFieldController,
                sign_up_screen_textFieldLabel: sign_up_email_label,
                obscureText: false,
              ),

              // Password
              SignUpTextField(
                sign_up_screen_textFieldController:
                    sign_up_screen_password_textFieldController,
                sign_up_screen_textFieldLabel: sign_up_password_label,
                obscureText: true,
              ),

              // Repeat Password
              SignUpTextField(
                sign_up_screen_textFieldController:
                    sign_up_screen_repeatpassword_textFieldController,
                sign_up_screen_textFieldLabel: sign_up_repeatpassword_label,
                obscureText: true,
              ),

              const SizedBox(height: 30),

              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        register(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Sign Up'),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account ?'),

                    SizedBox(width: 20),

                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        'Log in',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
