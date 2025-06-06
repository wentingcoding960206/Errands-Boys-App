import 'package:errands_boys/chat/chat_screen.dart';
import 'package:errands_boys/join_us_screen/join_us_screen_manager.dart';
import 'package:errands_boys/main_screen/main_screen.dart';
import 'package:errands_boys/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:errands_boys/bottom_nav_bar.dart';
//import 'bottom_nav_bar.dart'; // Import the BottomNavBar

class ScreenManager extends StatefulWidget {
  final int initialSelectedTabIndex;

  const ScreenManager({super.key, required this.initialSelectedTabIndex});

  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  // int _selectedIndex = 0;
  late int _selectedIndex;

  // Screens to display based on the selected index
  final List<Widget> _screens = [
    MainScreen(),
    ChatScreen(),
    JoinUsScreenManager(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the selected tab with the passed value
    _selectedIndex = widget.initialSelectedTabIndex;
  }

  // Function to handle the tap on the BottomNavigationBar
  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Show the appropriate screen based on the selected index
      bottomNavigationBar: BottomNavBar(
        navBarSelectedIndex: _selectedIndex,
        navBarOnTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}





