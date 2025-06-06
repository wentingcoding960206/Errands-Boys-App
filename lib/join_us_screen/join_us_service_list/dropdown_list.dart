import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

bool showDropdown = false;
final LayerLink _layerLink = LayerLink();
final GlobalKey _fieldKey = GlobalKey();
OverlayEntry? _overlayEntry;

final List<String> availableServices = [
  'Tutoring - Math',
    'Tutoring - Science',
    'Babysitting - 1 kid',
    'Babysitting - 2-3 kids',
    'Babysitting - 4-5 kids',
    'Babysitting - 6+ kids',
    'Painting',
    'House Cleaning',
    'Furniture Assembly - Small Items',
    'Furniture Assembly - Medium Items',
    'Furniture Assembly - Large Items',
    'Packing & Moving - Light Items',
    'Packing & Moving - Moderate Items',
    'Packing & Moving - Heavy Items',
    'Packing & Moving - Extra Heavy Items',
    'Car Washing',
    'Holiday Help',
    'Snow Shoveling - Small',
    'Snow Shoveling - Medium',
    'Snow Shoveling - Large',
    'Dog Walking / Sitting - Walking / Sitting',
    'Dog Walking / Sitting - Feeding / Medication',
    'Dog Walking / Sitting - Bath / Brush',
    'Grocery Shopping',
    'Lawn Mowing',
    'Car Washing - Interior Only',
    'Car Washing - Exterior Only',
    'Car Washing - Interior & Exterior'
];

List<String> selectedServices = [];

void toggleDropdownSelectList({
  required BuildContext context,
  required VoidCallback refreshUI,
  required TextEditingController controller,
  VoidCallback? onSubmit,
}) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  // Step 1: Fetch services already added to Firestore
  final snapshot =
      await FirebaseFirestore.instance
          .collection('joinus_request')
          .doc(uid)
          .collection('services')
          .get();

  final alreadyAdded = snapshot.docs.map((doc) => doc.id).toSet();

  // Step 2: Filter out already added services
  final unselectedServices =
      availableServices
          .where((service) => !alreadyAdded.contains(service))
          .toList();

  if (_overlayEntry != null) {
    _overlayEntry?.remove();
    _overlayEntry = null;
    //selectedServices.clear(); // Clear selections
    return;
  }

  final contextBox = _fieldKey.currentContext;
  if (contextBox == null) return;

  final RenderBox renderBox = contextBox.findRenderObject() as RenderBox;

  final Size size = renderBox.size;
  final Offset offset = renderBox.localToGlobal(Offset.zero);
  final screenSize = MediaQuery.of(context).size;
  final dropdownWidth = 250.0;
  final dropdownHeight = 100.0;

  _overlayEntry = OverlayEntry(
    builder: (context) {
      return Stack(
        children: [
          // This covers the whole screen and dismisses the dropdown on tap
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _overlayEntry?.remove();
              _overlayEntry = null;
              //selectedServices.clear();
            },
            child: Container(
              color: Colors.transparent, // full screen tap area
            ),
          ),

          // The actual dropdown, centered
          Positioned(
            left: (screenSize.width - dropdownWidth) / 2,
            top: (screenSize.height - dropdownHeight) / 2,
            width: dropdownWidth,
            height: dropdownHeight * 3,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: StatefulBuilder(
                builder: (context, setOverlayState) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: BoxConstraints(
                      maxHeight: (unselectedServices.length * 56.0).clamp(
                        0.0,
                        250.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        if (unselectedServices.isNotEmpty)
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children:
                                  unselectedServices.map((service) {
                                    return CheckboxListTile(
                                      title: Text(service),
                                      value: selectedServices.contains(service),
                                      onChanged: (bool? value) {
                                        if (value == true) {
                                          selectedServices.add(service);
                                        } else {
                                          selectedServices.remove(service);
                                        }
                                        controller.text = selectedServices.join(
                                          ', ',
                                        );
                                        setOverlayState(() {});
                                      },
                                    );
                                  }).toList(),
                            ),
                          )
                        else
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "No services left to select.",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        if (unselectedServices.isNotEmpty)
                          ElevatedButton(
                            onPressed: () async {
                              final uid =
                                  FirebaseAuth.instance.currentUser?.uid;
                              if (uid == null) return;

                              final docRef = FirebaseFirestore.instance
                                  .collection('joinus_request')
                                  .doc(uid);

                              for (final service in selectedServices) {
                                await docRef
                                    .collection('services')
                                    .doc(service)
                                    .set({
                                      'name': service,
                                      'status': 'pending',
                                    });
                              }

                              controller.text = selectedServices.join(', ');
                              if (onSubmit != null) onSubmit();

                              controller.clear();

                              _overlayEntry?.remove();
                              _overlayEntry = null;
                              refreshUI();
                              selectedServices.clear();
                            },
                            child: const Text('Submit'),
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    },
  );

  Overlay.of(context).insert(_overlayEntry!);
}

GlobalKey getServiceFieldKey() => _fieldKey;
LayerLink getLayerLink() => _layerLink;
List<String> getSelectedServices() => selectedServices;
