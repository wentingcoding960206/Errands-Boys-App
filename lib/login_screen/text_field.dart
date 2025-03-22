import 'package:flutter/material.dart';

class LoginScreenTextField extends StatelessWidget {

  final TextEditingController textFieldController;
  final String textFieldLabel;
  const LoginScreenTextField({super.key, required this.textFieldLabel, required this.textFieldController});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                textFieldLabel,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16), // Space between the label and textfield
            SizedBox(
              width: double.infinity, // Makes the TextField take the full width
              height: 50, 
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: textFieldController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(131, 66, 66, 66),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Enter your $textFieldLabel',
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
