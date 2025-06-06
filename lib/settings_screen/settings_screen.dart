import 'package:errands_boys/attributes_screen/attributes_screen.dart';
import 'package:errands_boys/bottom_nav_bar.dart';
import 'package:errands_boys/notification_screen/notification_screen.dart';
import 'package:errands_boys/order_history_screen/order_history_screen.dart';
import 'package:errands_boys/pay_screen/pay_screen.dart';
import 'package:errands_boys/privacy_sharing_screen/privacy_sharing_screen.dart';
import 'package:errands_boys/sections_settings_screen.dart/sections_settings_screen.dart';

import 'package:errands_boys/settings_screen/profile_picker.dart';
import 'package:errands_boys/settings_screen/sections_settings.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('Bottom Nav Bar Icon $index pressed');
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        // title: Row(
        //   children: [
        //     Spacer(),
        //     Padding(
        //       padding: const EdgeInsets.all(16.0),
        //       //child: Icon(Icons.search, size: 30),

        //     ),
        //   ],
        // ),
        title: Text(
          'Account Settings',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Center(
              //   child: Stack(
              //     alignment: AlignmentDirectional(1.25, 1.2),
              //     children: [
              //       SizedBox(
              //         width: 150,
              //         height: 150,
              //         child: Image.asset('assets/images/person_icon.png'),
              //       ),

              //       IconButton(
              //         onPressed: () {
              //           print('Camera Button Pressed');
              //         },
              //         icon: Icon(
              //           Icons.camera_alt_outlined,
              //           size: 40,
              //         )
              //       )
              //     ],
              //   ),
              // ),
              //ProfilePicSelector(),

              //const SizedBox(height: 30),
              //const SizedBox(height: 10),

              SectionsSettings(
                nameSectionsSettings: 'Personal Information',
                iconsSectionsSettings: Icons.person_2_outlined,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SectionsSettingsScreen(),
                    ),
                  );
                },
              ),

              // SectionsSettings(
              //   nameSectionsSettings: 'Payment',
              //   iconsSectionsSettings: Icons.payment,
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => PayScreen()),
              //     );
              //   },
              // ),

              SectionsSettings(
                nameSectionsSettings: 'Notifications',
                iconsSectionsSettings: Icons.notification_add_outlined,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ),
                  );
                },
              ),

              SectionsSettings(
                nameSectionsSettings: 'Privacy & Sharing',
                iconsSectionsSettings: Icons.privacy_tip_outlined,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrivacySharingScreen(),
                    ),
                  );
                },
              ),

              SectionsSettings(
                nameSectionsSettings: 'Order History',
                iconsSectionsSettings: Icons.history,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderHistoryScreen(),
                    ),
                  );
                },
              ),

              SectionsSettings(
                nameSectionsSettings: 'About Us & Attributes',
                iconsSectionsSettings: Icons.info_outline,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AttributesScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // bottomNavigationBar: BottomNavBar(
      //   navBarOnTap: _onItemTapped,
      //   navBarSelectedIndex: _selectedIndex,
      // ),
    );
  }
}
