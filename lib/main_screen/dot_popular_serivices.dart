import 'package:flutter/material.dart';

class DotPopularSerivices extends StatelessWidget {
  final int index;
  final bool isActive;
  final VoidCallback onTap;

  const DotPopularSerivices({
    super.key,
    required this.index,
    required this.isActive,
    required this.onTap,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: () {
          print("Switch to Popular Service no. $index");
          onTap();
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          minimumSize: isActive ? const Size(20, 20) : const Size(10, 10),
          fixedSize: isActive ? const Size(20, 20) : const Size(10, 10),
          elevation: 0,
          backgroundColor: isActive 
            ? Colors.purple 
            : Colors.grey,
        ),
        child: Container(),
      ),
    );
  }
}
