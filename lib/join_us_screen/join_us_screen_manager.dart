import 'package:errands_boys/join_us_screen/join_us_screen.dart';
import 'package:errands_boys/join_us_screen/join_us_service_list/join_us_service_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JoinUsScreenManager extends StatelessWidget {
  const JoinUsScreenManager({super.key});

  Stream<String> getUserStatusStream() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');

    return FirebaseFirestore.instance
        .collection('joinus_request')
        .doc(uid)
        .snapshots()
        .map((snapshot) {
          final data = snapshot.data();
          return data?['status'] ?? 'pending';
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: getUserStatusStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final status = snapshot.data!;
        if (status == 'verified') {
          return const JoinUsServiceListScreen(); // your screen with service cards
        } else {
          return const JoinUsScreen(); // show something like "awaiting approval"
        }
      },
    );
  }
}
