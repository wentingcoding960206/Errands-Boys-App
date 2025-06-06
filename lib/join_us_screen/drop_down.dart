
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

void toggleDropdown({
  required BuildContext context,
  required VoidCallback refreshUI,
  required TextEditingController controller,
}) {
  if (_overlayEntry != null) {
    _overlayEntry?.remove();
    _overlayEntry = null;
    return;
  }

  final RenderBox renderBox =
      _fieldKey.currentContext!.findRenderObject() as RenderBox;
  final Size size = renderBox.size;
  final Offset offset = renderBox.localToGlobal(Offset.zero);

  _overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      left: offset.dx,
      top: offset.dy + size.height + 5,
      width: size.width,
      child: CompositedTransformFollower(
        link: _layerLink,
        showWhenUnlinked: false,
        offset: Offset(0, size.height + 5),
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
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView(
                  shrinkWrap: true,
                  children: availableServices.map((service) {
                    return CheckboxListTile(
                      title: Text(service),
                      value: selectedServices.contains(service),
                      onChanged: (bool? value) {
                        if (value == true) {
                          selectedServices.add(service);
                        } else {
                          selectedServices.remove(service);
                        }

                        controller.text = selectedServices.join(', ');
                        setOverlayState(() {}); // Only rebuild overlay, not whole screen
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ),
    ),
  );

  Overlay.of(context).insert(_overlayEntry!);
}


// service_dropdown.dart


GlobalKey getServiceFieldKey() => _fieldKey;
LayerLink getLayerLink() => _layerLink;
List<String> getSelectedServices() => selectedServices;
