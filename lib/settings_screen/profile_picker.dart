import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePicSelector extends StatefulWidget {
  const ProfilePicSelector({super.key});

  @override
  _ProfilePicSelectorState createState() => _ProfilePicSelectorState();
}

class _ProfilePicSelectorState extends State<ProfilePicSelector> {
  String _selectedAvatar = 'avatar1.jpg';  // Default avatar
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAvatar();
  }

  Future<void> _loadAvatar() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;
        final doc = await FirebaseFirestore.instance.collection('Users').doc(uid).get();
        setState(() {
          _selectedAvatar = doc.data()?['profilePic'] ?? 'avatar1.jpg';  // Default if not found
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle error if any
      setState(() {
        _isLoading = false;
      });
      print("Error loading avatar: $e");
    }
  }

  Future<void> _saveAvatar(String avatarName) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;
        await FirebaseFirestore.instance.collection('Users').doc(uid).set({
          'profilePic': avatarName,
        }, SetOptions(merge: true));

        print("Saving for UID: $uid");
        print("Avatar saved to Firestore!");
        
        setState(() {
          _selectedAvatar = avatarName;
        });
      }
    } catch (e) {
      // Handle error if any
      print("Error saving avatar: $e");
    }
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GridView.builder(
          itemCount: 3,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (context, index) {
            String avatarName = 'avatar${index + 1}.jpg';
            return GestureDetector(
              onTap: () {
                _saveAvatar(avatarName);
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile_pics/$avatarName'),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          ? CircularProgressIndicator()  // Show loading indicator if loading avatar
          : Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/profile_pics/$_selectedAvatar'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: _showAvatarPicker,
                  ),
                ),
              ],
            ),
    );
  }
}
