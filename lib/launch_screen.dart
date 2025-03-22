import 'package:flutter/material.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(
            'assets/images/background.jpeg',
            fit: BoxFit.cover,
          ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                Image.asset(
                  'assets/images/errands_boys_logo.png',
                  height: 300,
                  width: 300,
                ),

                const SizedBox(height: 20),

                Text(
                  'Errands Boys',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  )   
                    
                )
              ],
            ),)
        ]
        ),
    );
  }
}
