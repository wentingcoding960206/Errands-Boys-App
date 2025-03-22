import 'dart:developer';

import 'package:errands_boys/login_screen/text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  textFieldController: emailController,
                ),
                const SizedBox(height: 20),

                // Login text field (Password)
                LoginScreenTextField(
                  textFieldLabel: 'Password',
                  textFieldController: passwordController,
                ),

                //const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        log('Forgot Password Button Pressed');
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
                const SizedBox(height: 10),

                // Authentication Choices (Google, Facebook & Apple)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Google Button
                      Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            log('Google Button Pressed');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/google_icon.png',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                      ),

                      // Facebook Button 
                      Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            log('Facebook Button Pressed');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/facebook_icon.png',
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                      ),

                      //Apple Button
                      Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            log('Apple Button Pressed');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/apple_icon.png',
                              width: 45,
                              height: 45,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),

                Padding(
                  padding: const EdgeInsets.only(bottom: 35, right: 50, left: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?'
                      ),

                      TextButton(
                        onPressed: () {
                          log('Sign Up Button Pressed');
                        }, 
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
