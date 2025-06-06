import 'package:flutter/material.dart';

class SectionsSettings extends StatelessWidget {
  final String nameSectionsSettings;
  final IconData iconsSectionsSettings;
  final VoidCallback onPressed;

  const SectionsSettings({
    super.key,
    required this.nameSectionsSettings,
    required this.iconsSectionsSettings,
    required this.onPressed
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 10),

          Row(
            children: [
              Icon(iconsSectionsSettings),
          
              const SizedBox(width: 10),
              Text(
                nameSectionsSettings,
                style: TextStyle(
                  fontSize: 18
                )
              ),
              Spacer(),

              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  onPressed();
                  print('$nameSectionsSettings button pressed');
                }), 
            ],
          ),

          const SizedBox(height: 10),

          Divider(
            color: Colors.grey,
            thickness: 1,
          )
        ],
      )
    );
  }
}
