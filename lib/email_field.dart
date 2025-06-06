import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String textFieldText;

  const EmailField({super.key, required this.controller, required this.textFieldText});

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(60, 158, 158, 158),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 10
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none
        ),
        hintText: 'Enter your $textFieldText',
        hintStyle: TextStyle(color: Color.fromARGB(164, 0, 0, 0))
      ),
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        } else if (!_isValidEmail(value)) {
          return 'Enter a valid email address';
        }
        return null;
      },
    );
  }
}
