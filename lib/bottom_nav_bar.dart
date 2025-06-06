import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int navBarSelectedIndex;
  final Function(int) navBarOnTap;

  const BottomNavBar({
    super.key,
    required this.navBarOnTap,
    required this.navBarSelectedIndex,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        iconSize: 30,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: navBarSelectedIndex,
        onTap: (index) {
          navBarOnTap(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset: Offset(0, 8), 
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset: Offset(0, 8), 
              child: Icon(Icons.chat),
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset: Offset(0, 8), 
              child: Icon(Icons.handshake),
            ),
            label: 'Hand Shake',
          ),
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset: Offset(0, 8), 
              child: Icon(Icons.person),
            ),
            label: 'Person',
          ),
        ]
      );
  }
}
