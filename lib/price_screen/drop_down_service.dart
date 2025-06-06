import 'package:flutter/material.dart';

/// Returns a list of DropdownMenuItem widgets built from the provided [services].
List<DropdownMenuItem<String>> buildServiceDropdownItems(List<String> services) {
  return services.map((service) {
    return DropdownMenuItem<String>(
      value: service,
      child: Text(service),
    );
  }).toList();
}
