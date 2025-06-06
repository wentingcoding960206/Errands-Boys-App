import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> submitJoinUsForm({
  required String fullName,
  required String teenEmail,
  required String parentEmail,
  required String phoneNumber,
  required List<String> selectedServices, // CHANGED: Now a list
  required String introduction,
}) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) {
    throw Exception('User not logged in');
  }

  final docRef = FirebaseFirestore.instance
      .collection('joinus_request')
      .doc(uid);

  // Store basic user data
  await docRef.set({
    'fullName': fullName,
    'teenEmail': teenEmail,
    'parentEmail': parentEmail,
    'introduction': introduction,
    'timestamp': FieldValue.serverTimestamp(),
    'status': 'pending',
  });

  // Save services as subcollection
  final servicesRef = docRef.collection('services');
  for (final service in selectedServices) {
    await servicesRef.doc(service).set({'name': service, 'status': 'pending'});
  }
}
