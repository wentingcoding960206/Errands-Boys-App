import 'package:flutter/material.dart';

class SignUpTextField extends StatelessWidget {
  final TextEditingController sign_up_screen_textFieldController;
  final String sign_up_screen_textFieldLabel;
  final bool obscureText;
  const SignUpTextField({
    super.key, 
    required this.sign_up_screen_textFieldController, 
    required this.sign_up_screen_textFieldLabel,
    required this.obscureText
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),

      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: TextField(
          obscureText: obscureText,
          style: const TextStyle(color: Colors.black),
          controller: sign_up_screen_textFieldController,
          decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: sign_up_screen_textFieldLabel,
                  hintStyle: TextStyle(color: Colors.black),
        )
      ),
      ),
    );
  }
}
