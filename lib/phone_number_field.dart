import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class CanadianPhoneNumberField extends StatefulWidget {
  final TextEditingController controller;

  const CanadianPhoneNumberField({super.key, required this.controller});

  @override
  _CanadianPhoneNumberFieldState createState() =>
      _CanadianPhoneNumberFieldState();
}

class _CanadianPhoneNumberFieldState extends State<CanadianPhoneNumberField> {
  String? _phoneError;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(60, 158, 158, 158),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 10
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none
        ),
        hintText: 'Phone Number (Canada)',
        errorText: _phoneError, // Show the error message if validation fails
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        PhoneInputFormatter(allowEndlessPhone: false, defaultCountryCode: 'CA'),
      ],
      onChanged: (value) {
        // Validate the phone number format on every change
        setState(() {
          _phoneError = _validatePhoneNumber(value);
        });
      },
    );
  }

  String? _validatePhoneNumber(String value) {
    final raw = value.replaceAll(RegExp(r'\D'), ''); // Remove non-digits

    if (raw.isEmpty) {
      return 'Phone number is required';
    }

    // Validate the format: Canadian phone numbers should be 10 digits (without the country code)
    if (raw.length != 10) {
      return 'Enter a valid 10-digit Canadian number';
    }

    return null; // No error
  }
}
