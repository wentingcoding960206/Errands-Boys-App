import 'package:flutter/material.dart';


class TextfieldJoinUs extends StatelessWidget {

  // final TextEditingController joinTextFieldController;
  // final String joinTextFieldText;

  final TextEditingController joinTextFieldController;
  final String joinTextFieldText;
  final int maxLines;

  const TextfieldJoinUs({
    super.key,
    required this.joinTextFieldController,
    required this.joinTextFieldText,
    this.maxLines = 1, // default is 1 for single-line inputs
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
            joinTextFieldText,
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
            controller: joinTextFieldController,
            maxLines: maxLines,
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
              hintText: 'Enter your $joinTextFieldText',
              hintStyle: TextStyle(color: Color.fromARGB(164, 0, 0, 0)))
            )
          )
      ],
    );
  }
}

