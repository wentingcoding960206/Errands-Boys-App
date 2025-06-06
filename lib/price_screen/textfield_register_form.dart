import 'package:flutter/material.dart';


class TextfieldRegisterForm extends StatelessWidget {

  final TextEditingController formTextFieldController;
  final String formTextFieldText;

  const TextfieldRegisterForm({
    super.key,
    required this.formTextFieldController,
    required this.formTextFieldText
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            formTextFieldText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            )
          )
        ),

        const SizedBox(height: 8),
        
        SizedBox(
          width: double.infinity,
          child: TextField(
            style: TextStyle(color: const Color.fromARGB(164, 0, 0, 0)),
            controller: formTextFieldController,
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
              hintText: 'Enter your $formTextFieldText',
              hintStyle: TextStyle(color: Color.fromARGB(164, 0, 0, 0)))
            )
          )
      ],
    );
  }
}

