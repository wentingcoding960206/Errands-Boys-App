import 'package:flutter/material.dart';

class ButtonChatPage extends StatelessWidget {
  final String nameCategories;
  final double widthCategories;
  final double heightCategories;
  final Function(int) onButtonTap;
  final bool isButtonActive;
  final int index;

  const ButtonChatPage({
    super.key,
    required this.nameCategories,
    required this.heightCategories,
    required this.widthCategories,
    required this.onButtonTap,
    required this.isButtonActive,
    required this.index
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print('$nameCategories Button on Chat Page Pressed');
        onButtonTap(index);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isButtonActive 
          ? Colors.white 
          : const Color.fromARGB(91, 158, 158, 158),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        maximumSize: Size(widthCategories, heightCategories),
        fixedSize: Size(widthCategories, heightCategories),
        elevation: isButtonActive ? 1 : 0
      ),
      child: Text(nameCategories),
    );
  }
}
