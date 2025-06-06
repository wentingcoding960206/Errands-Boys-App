import 'dart:developer';

import 'package:errands_boys/auth_service.dart';
import 'package:errands_boys/login_screen/forgot_password_page.dart';
import 'package:errands_boys/login_screen/text_field.dart';
import 'package:flutter/material.dart';

class LoginChatpages extends StatelessWidget {
  LoginChatpages({
    super.key,
    required this.onTap,
  });
  final TextEditingController UsernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String googleButton = "google";
  final String facebookButton = "facebook";
  final String appleButton = "apple";

  // tap to go to register page
  final void Function()? onTap;

  // login
  void login(BuildContext context) async{
    // get auth service
    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailPassword(UsernameController.text, passwordController.text);
    } catch (e) {
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text(e.toString())
        ),
        
      );
    }

    // catch any errors
  }

  void googleSignIn() {
    AuthService().signInWithGoogle();
  }

  void appleSignIn() {
    print("apple pressed");
  }

  void facebookSignIn() {
    print("facebook pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpeg'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/errands_boys_logo.png',
                    height: 150,
                    width: 150,
                  ),
                ),
                const SizedBox(height: 16),

                // Login text field (Email)
                LoginScreenTextField(
                  textFieldLabel: 'Email',
                  textFieldController: UsernameController,
                  obscureText: false,
                ),
                const SizedBox(height: 20),

                // Login text field (Password)
                LoginScreenTextField(
                  textFieldLabel: 'Password',
                  textFieldController: passwordController,
                  obscureText: true,
                ),

                //const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        log('Forgot Password Button Pressed');
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          })
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blueAccent,
                      ),
                      child: Text('Forgot Password ?'),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          login(context);
                          log('Login Button Pressed');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Login'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // // Authentication Choices (Google, Facebook & Apple)
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 100),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [

                //       // Google Button
                //       AuthButton(
                //         buttonLabel: googleButton,
                //         onTap: googleSignIn,
                //       ),

                //       // // Facebook Button 
                //       // AuthButton(
                //       //   buttonLabel: facebookButton,
                //       //   onTap: facebookSignIn
                //       // ),

                //       // //Apple Button
                //       // AuthButton(
                //       //   buttonLabel: appleButton,
                //       //   onTap: appleSignIn
                //       // ),
                //     ],
                //   ),
                // ),
                const Expanded(child: SizedBox()),

                Padding(
                  padding: const EdgeInsets.only(bottom: 35, right: 50, left: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?'
                      ),

                      SizedBox(width: 30,),


                      GestureDetector(
                        onTap: onTap, 
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.blueAccent
                          ),
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
