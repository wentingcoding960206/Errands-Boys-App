
// Your existing fetch functions below — no change needed

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Future<List<String>> fetchAllAvailableServices() async {
  final joinusSnapshot =
      await FirebaseFirestore.instance.collection('joinus_request').get();
  final Set<String> allServices = {};

  for (final userDoc in joinusSnapshot.docs) {
    final servicesSub = await userDoc.reference.collection('services').get();
    print("User ${userDoc.id} has ${servicesSub.docs.length} service docs");

    for (final serviceDoc in servicesSub.docs) {
      final data = serviceDoc.data();
      print("Service doc data: $data");

      final String? serviceName = data['name'];
      if (serviceName != null && serviceName.isNotEmpty) {
        allServices.add(serviceName);
      }
    }
  }

  print("All collected services: $allServices"); // Final print
  return allServices.toList()..sort();
}

Future<List<Map<String, dynamic>>> fetchProvidersForService(String service) async {
  final joinusSnapshot = await FirebaseFirestore.instance.collection('joinus_request').get();
  final List<Map<String, dynamic>> verifiedProviders = [];

  for (final userDoc in joinusSnapshot.docs) {
    final userData = userDoc.data();

    if (userData['status']?.toString().toLowerCase() != 'verified') continue;

    final servicesSnapshot = await userDoc.reference.collection('services').get();

    bool providerAdded = false;

    for (final serviceDoc in servicesSnapshot.docs) {
      final data = serviceDoc.data();
      final String? serviceName = data['name'];
      final String? serviceStatus = data['status'];

      if (serviceName != null &&
          serviceStatus != null &&
          serviceName.toLowerCase().trim() == service.toLowerCase().trim() &&
          serviceStatus.toLowerCase().trim() == 'verified') {
        if (!providerAdded) {
          verifiedProviders.add({
            'id': userDoc.id,
            'fullName': userData['fullName'] ?? '',
            'teenEmail': userData['teenEmail'] ?? '',
            'introduction': userData['introduction'] ?? 'No introduction provided',
            'parentEmail': userData['parentEmail'] ?? '',
          });
          providerAdded = true;
        }
      }
    }
  }

  return verifiedProviders;
}

Future<Map<String, List<String>>> fetchAvailability(String email) async {
  final docSnapshot = await FirebaseFirestore.instance
      .collection('availabilities') // make sure this is correctly spelled
      .doc(email)
      .get();

  if (!docSnapshot.exists) return {};

  final data = docSnapshot.data();
  if (data == null || !data.containsKey('availability')) return {};

  final rawAvailability = data['availability'] as Map<String, dynamic>;

  final availability = rawAvailability.map((day, times) {
    final timeList = (times as List<dynamic>).map((e) => e.toString()).toList();
    return MapEntry(day, timeList);
  });

  print('Availability: $availability'); // ✅ DEBUG PRINT
  return availability;
}

Future<void> updateBookingDays(String providerId) async {
  final bookingDocRef = FirebaseFirestore.instance.collection('book').doc(providerId);
  final docSnapshot = await bookingDocRef.get();
  final now = DateTime.now();
  final today = DateFormat('yyyy-MM-dd').format(now);

  Map<String, dynamic> currentData = {};

  if (docSnapshot.exists) {
    currentData = docSnapshot.data() ?? {};
  }

  // Remove days older than today
  final keysToKeep = currentData.keys.where((date) {
    return DateTime.parse(date).isAfter(now.subtract(Duration(days: 1)));
  }).toList();

  final Map<String, dynamic> updatedData = {};

  for (final key in keysToKeep) {
    updatedData[key] = currentData[key];
  }

  // Add next day if only 6 or fewer days exist
  while (updatedData.length < 7) {
    final nextDay = now.add(Duration(days: updatedData.length));
    final nextDayStr = DateFormat('yyyy-MM-dd').format(nextDay);
    updatedData[nextDayStr] = []; // or predefined time slots
  }

  await bookingDocRef.set(updatedData);
}


Future<List<String>> fetchProvidersBookedSlots(String providerId) async {
  final docSnapshot = await FirebaseFirestore.instance
      .collection('providersBooked')
      .doc(providerId)
      .get();

  if (!docSnapshot.exists) return [];

  final data = docSnapshot.data();

  if (data == null) return [];

  final timeslots = data['timeslots'] as List<dynamic>?;

  return timeslots?.cast<String>() ?? [];
}


Future<List<String>> fetchCustomersBookedSlots(String customerId) async {
  final docSnapshot = await FirebaseFirestore.instance
      .collection('customersBooked')
      .doc(customerId)
      .get();

  if (!docSnapshot.exists) return [];

  final data = docSnapshot.data();

  if (data == null) return [];

  final timeslots = data['timeslots'] as List<dynamic>?;

  return timeslots?.cast<String>() ?? [];
}
