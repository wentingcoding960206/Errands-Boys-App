
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {

  final String buttonLabel;
  final void Function()? onTap;
  const AuthButton({
    super.key, 
    required this.buttonLabel,
    required this.onTap
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Select the image based on buttonLabel
    String imageAsset = '';
    double buttonWidth = 0.0;
    if (buttonLabel == 'google') {
      imageAsset = 'assets/images/google_icon.png';
      buttonWidth = 80;
    } else if (buttonLabel == 'facebook') {
      imageAsset = 'assets/images/facebook_icon.png';
      buttonWidth = 60;
    } else if (buttonLabel == 'apple') {
      imageAsset = 'assets/images/apple_icon.png';
      buttonWidth = 45;
    }

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            imageAsset,
            width: buttonWidth,
            height: buttonWidth,
          ),
        ),
      ),
    );
  }
}
