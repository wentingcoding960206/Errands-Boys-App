import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errands_boys/join_us_screen/join_us_service_list/dropdown_list.dart';
import 'package:errands_boys/join_us_screen/join_us_service_list/availability_screen.dart';
import 'package:errands_boys/screen_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class JoinUsServiceListScreen extends StatefulWidget {
  const JoinUsServiceListScreen({super.key});

  @override
  State<JoinUsServiceListScreen> createState() =>
      _JoinUsServiceListScreenState();
}

class _JoinUsServiceListScreenState extends State<JoinUsServiceListScreen> {

  late final TextEditingController serviceController;
  final LayerLink _layerLink = LayerLink(); // To manage dropdown positioning
  OverlayEntry? _dropdownOverlayEntry; // To control overlay
  bool _dropdownOpen = false; // Track if dropdown is open

  Stream<Map<String, dynamic>> combinedStatusStream() {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) throw Exception('User not logged in');

    final docRef = FirebaseFirestore.instance
        .collection('joinus_request')
        .doc(uid);
    final servicesRef = docRef.collection('services');

    final userStatusStream = docRef.snapshots();
    final servicesStatusStream = servicesRef.snapshots();

    return CombineLatestStream.combine2(
      userStatusStream,
      servicesStatusStream,
      (DocumentSnapshot userSnap, QuerySnapshot servicesSnap) {
        final userStatus = userSnap.data() as Map<String, dynamic>?;

        final services =
            servicesSnap.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return {'name': doc.id, 'status': data['status']};
            }).toList();

        return {
          'status': userStatus?['status'] ?? 'pending',
          'services': services,
        };
      },
    );
  }

  final int _selectedIndex = 2;

  void calendarPicker() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => AvailabilityScreen()));
  }

  @override
  void initState() {
    super.initState();
    serviceController = TextEditingController();
  }

  @override
  void dispose() {
    serviceController.dispose();
    _removeDropdownOverlay();
    super.dispose();
  }

  void _removeDropdownOverlay() {
    if (_dropdownOverlayEntry != null) {
      _dropdownOverlayEntry?.remove();
      _dropdownOverlayEntry = null;
      _dropdownOpen = false;
    }
  }

  void _onItemTapped(int selectedTabIndex) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder:
            (_) => ScreenManager(
              initialSelectedTabIndex:
                  selectedTabIndex, // Pass the selected tab index
            ),
      ),
      (route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: combinedStatusStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final status = snapshot.data!['status'];
        final List services = snapshot.data!['services'];

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Join Us',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  Icon(Icons.handshake, size: 30),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Select available Time',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 30),
                    IconButton(
                      onPressed: calendarPicker,
                      icon: Icon(Icons.calendar_month_outlined, size: 80),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Add Services:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ),

                    SizedBox(width: 20),

                    SizedBox(
                      width: 187,
                      child: CompositedTransformTarget(
                        link: getLayerLink(),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            toggleDropdownSelectList(
                              context: context,
                              refreshUI: () => setState(() {}),
                              controller: serviceController,
                            );
                          },
                          child: AbsorbPointer(
                            absorbing: true,
                            child: TextField(
                              key: getServiceFieldKey(),
                              controller: serviceController,
                              decoration: InputDecoration(
                                hintText: 'Tap to select services',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.arrow_drop_down),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    final isVerified = service['status'] == 'verified';

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color:
                            isVerified ? Colors.blue[100] : Colors.orange[100],
                        child: ListTile(
                          title: Text(service['name']),
                          subtitle: Text('Status: ${service['status']}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              final uid =
                                  FirebaseAuth.instance.currentUser?.uid;
                              if (uid == null) return;

                              final serviceDocRef = FirebaseFirestore.instance
                                  .collection('joinus_request')
                                  .doc(uid)
                                  .collection('services')
                                  .doc(service['name']);

                              try {
                                await serviceDocRef.delete();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${service['name']} deleted'),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Failed to delete service: $e',
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
