import 'package:cloud_firestore/cloud_firestore.dart';

class ReservedService {
  final String serviceName;
  final String timeSlot;
  final String serviceProvider;

  ReservedService({
    required this.serviceName,
    required this.timeSlot,
    required this.serviceProvider,
  });
}

class RequestedService {
  final String serviceName;
  final String timeSlot;
  final String serviceCustomer;

  RequestedService({
    required this.serviceName,
    required this.timeSlot,
    required this.serviceCustomer,
  });
}

int calculateTotalCards(
  Map<String, List<ReservedService>> categorizedServices,
) {
  int total = 0;
  categorizedServices.forEach((key, serviceList) {
    total += serviceList.length;
  });
  return total;
}

int calculateProviderTotalCards(
  Map<String, List<RequestedService>> categorizedServices,
) {
  int total = 0;
  categorizedServices.forEach((key, serviceList) {
    total += serviceList.length;
  });
  return total;
}

Future<Map<String, List<ReservedService>>> fetchReservedServices(
  String uid,
) async {
  Map<String, List<ReservedService>> tempCategorized = {
    'Academics': [],
    'Aesthetics': [],
    'Outdoor Chores': [],
    'Indoor Chores': [],
  };

  print('uid: $uid');

  final servicesSnapshot =
      await FirebaseFirestore.instance
          .collection('customer_request')
          .doc(uid)
          .collection('selected_service')
          .get();

  print('Number of selected_service docs: ${servicesSnapshot.docs.length}');

  final allUserDocs =
      await FirebaseFirestore.instance.collection('customer_request').get();
  print(
    'All customer_request docs IDs: ${allUserDocs.docs.map((d) => d.id).toList()}',
  );

  for (var serviceDoc in servicesSnapshot.docs) {
    //final serviceName = serviceDoc.id;
    final serviceName = serviceDoc.id;
    print('Service doc id: $serviceName');

    final providerSnapshot =
        await serviceDoc.reference.collection('providerID').get();
    print(
      'Provider docs count under $serviceName: ${providerSnapshot.docs.length}',
    );

    if (providerSnapshot.docs.isEmpty) {
      print('No provider docs found for service $serviceName, skipping.');
      continue; // Skip if no provider docs
    }

    String category = 'Uncategorized';

    if (serviceName.contains('Tutoring')) {
      category = 'Academics';
    } else if (serviceName.contains('Painting') ||
        serviceName.contains('Holiday')) {
      category = 'Aesthetics';
    } else if (serviceName.contains('Snow') ||
        serviceName.contains('Walking') ||
        serviceName.contains('Grocery') ||
        serviceName.contains('Lawn') ||
        serviceName.contains('Car')) {
      category = 'Outdoor Chores';
    } else if (serviceName.contains('Babysitting') ||
        serviceName.contains('House') ||
        serviceName.contains('Furniture') ||
        serviceName.contains('Packing')) {
      category = 'Indoor Chores';
    }

    for (var providerDoc in providerSnapshot.docs) {
      final data = providerDoc.data();
      final List<dynamic> timeSlots = data['time_slots'] ?? [];
      final String serviceProvider = data['provider_name'] ?? '';

      for (var time in timeSlots) {
        tempCategorized[category]?.add(
          ReservedService(
            serviceName: serviceName,
            timeSlot: time,
            serviceProvider: serviceProvider,
          ),
        );
      }
    }
  }

  print('Fetched data: $tempCategorized');
  return tempCategorized;
}


Future<Map<String, List<RequestedService>>> fetchRequestedServices(
  String uid,
) async {
  Map<String, List<RequestedService>> tempCategorized = {
    'Academics': [],
    'Aesthetics': [],
    'Outdoor Chores': [],
    'Indoor Chores': [],
  };

  final servicesSnapshot =
      await FirebaseFirestore.instance
          .collection('provider_request')
          .doc(uid)
          .collection('selected_service')
          .get();

  print('Number of selected_service docs: ${servicesSnapshot.docs.length}');


  for (var serviceDoc in servicesSnapshot.docs) {
    //final serviceName = serviceDoc.id;
    final serviceName = serviceDoc.id;
    print('Service doc id: $serviceName');

    final customerSnapshot =
        await serviceDoc.reference.collection('customerID').get();
    print(
      'Provider docs count under $serviceName: ${customerSnapshot.docs.length}',
    );

    if (customerSnapshot.docs.isEmpty) {
      print('No provider docs found for service $serviceName, skipping.');
      continue; // Skip if no provider docs
    }

    String category = 'Uncategorized';

    if (serviceName.contains('Tutoring')) {
      category = 'Academics';
    } else if (serviceName.contains('Painting') ||
        serviceName.contains('Holiday')) {
      category = 'Aesthetics';
    } else if (serviceName.contains('Snow') ||
        serviceName.contains('Walking') ||
        serviceName.contains('Grocery') ||
        serviceName.contains('Lawn') ||
        serviceName.contains('Car')) {
      category = 'Outdoor Chores';
    } else if (serviceName.contains('Babysitting') ||
        serviceName.contains('House') ||
        serviceName.contains('Furniture') ||
        serviceName.contains('Packing')) {
      category = 'Indoor Chores';
    }

    for (var customerDoc in customerSnapshot.docs) {
      final data = customerDoc.data();
      final List<dynamic> timeSlots = data['time_slots'] ?? [];
      final String serviceCustomer = data['customer_name'] ?? '';

      for (var time in timeSlots) {
        tempCategorized[category]?.add(
          RequestedService(
            serviceName: serviceName,
            serviceCustomer: serviceCustomer,
            timeSlot: time
          ),
        );
      }
    }
  }

  print('Fetched data: $tempCategorized');
  return tempCategorized;
}
