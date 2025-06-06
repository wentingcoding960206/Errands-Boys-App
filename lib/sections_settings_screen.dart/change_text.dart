import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangeText extends StatefulWidget {
  final String fieldName; // 'username' or 'phoneNumber'
  final String currentValue;

  const ChangeText({
    super.key,
    required this.fieldName,
    required this.currentValue,
  });

  @override
  _ChangeTextState createState() => _ChangeTextState();
}

class _ChangeTextState extends State<ChangeText> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveChange() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;

      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        widget.fieldName: _controller.text.trim(),
      }, SetOptions(merge: true));

      Navigator.of(context).pop(_controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Change ${widget.fieldName}'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(hintText: 'Enter new ${widget.fieldName}'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _saveChange, child: const Text('Save')),
      ],
    );
  }
}
