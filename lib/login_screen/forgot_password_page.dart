import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> passwordReset() async {
    final email = _emailController.text.trim();

    try {
      // Query Users collection to check if the email exists
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .where('email', isEqualTo: email)
              .get();

      if (querySnapshot.docs.isEmpty) {
        // No user found with that email
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                content: Text("No account found with that email."),
              ),
        );
        return; // stop here, no reset email sent
      }

      // User exists — send the password reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              content: Text(
                "A password reset link has been sent to your email.",
              ),
            ),
      );
    } catch (e) {
      // Handle any errors (network, permissions, etc.)
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              content: Text("An error occurred: ${e.toString()}"),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey, elevation: 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter Your Email and we will send you a password reset link',
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),

            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Email',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),

          SizedBox(height: 10),

          MaterialButton(
            onPressed: passwordReset,
            color: Colors.deepPurple[200],
            child: Text('Reset Password'),
          ),
        ],
      ),
    );
  }
}
