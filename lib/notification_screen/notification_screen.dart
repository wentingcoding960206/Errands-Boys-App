import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  int _selectedIndex = 0;
  bool isSwitched_orderUpdates = true;
  bool isSwitched_messaging = true;
  bool isSwitched_marketingUpon = true;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('Bottom Nav Bar Icon $index pressed');
    });
  }


  Future<void> _updatePreference(String key, bool value) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid != null) {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .set({'notifications': {key: value}}, SetOptions(merge: true));
  } else {
    print('No user is signed in.');
  }
}



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'Notification',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold
          ),
        )
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Order Updates',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
                ),
        
                Expanded(child: SizedBox(),),
        
                Switch(
                  value: isSwitched_orderUpdates, 
                  onChanged: (value) {
                    setState(() {
                      isSwitched_orderUpdates = value;
                    });
                    _updatePreference('orderUpdates', value);
                  }
                )
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Text(
                  'Messaging',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
                ),
        
                Expanded(child: SizedBox(),),
        
                Switch(
                  value: isSwitched_messaging, 
                  onChanged: (value) {
                    setState(() {
                      isSwitched_messaging = value;
                    });
                    _updatePreference('messaging', value);
                  }
                )
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Text(
                  'Marketing Upon',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
                ),
        
                Expanded(child: SizedBox(),),
        
                Switch(
                  value: isSwitched_marketingUpon, 
                  onChanged: (value) {
                    setState(() {
                      isSwitched_marketingUpon = value;
                    });
                    _updatePreference('marketingUpon', value);
                  }
                )
              ],
            ),
          ],
        ),
      ),
 
      
    );
  }
}
