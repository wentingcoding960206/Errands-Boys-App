import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errands_boys/bottom_nav_bar.dart';
import 'package:errands_boys/screen_manager.dart';
import 'package:errands_boys/sections_settings_screen.dart/change_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SectionsSettingsScreen extends StatefulWidget {
  const SectionsSettingsScreen({super.key});

  @override
  State<SectionsSettingsScreen> createState() => _SectionsSettingsScreen();
}

class _SectionsSettingsScreen extends State<SectionsSettingsScreen> {
  final int _selectedIndex = 0;
  String _selectedAvatar = 'avatar1.jpg'; // Default avatar
  final String _username = 'Errands_Boys'; // Default, will be updated from Firestore
  String _phoneNumber = '437-266-7343';
  String _selectedEmail = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAvatar();
    _loadEmail();
    
  }

  Future<void> _loadAvatar() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;
        final doc =
            await FirebaseFirestore.instance.collection('Users').doc(uid).get();
        setState(() {
          _selectedAvatar =
              doc.data()?['profilePic'] ??
              'avatar1.jpg'; // Default if not found
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

  Future<void> _loadEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;
        final doc =
            await FirebaseFirestore.instance.collection('Users').doc(uid).get();
        setState(() {
          _selectedEmail = doc.data()?['email'] ?? ''; // Default if not found
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle error if any
      setState(() {
        _isLoading = false;
      });
      print("Error loading email: $e");
    }
  }

  

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'Personal Information',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              // Padding(
              //   padding: const EdgeInsets.all(1.0),
              //   child: SizedBox(
              //     width: 250,
              //     height: 250,
              //     //child: Image.asset('assets/profile_pics/$_selectedAvatar'),
              //   ),
              // ),

              //const SizedBox(height: 20),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     SizedBox(
              //       width: 175,
              //       height: 150,
              //       child: ElevatedButton(
              //         onPressed: () {
              //           print('Service Reserved List Button Pressed');
              //         },
              //         style: ElevatedButton.styleFrom(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           backgroundColor: Colors.white,
              //         ),
              //         child: Center(
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 '5',
              //                 style: TextStyle(
              //                   fontSize: 26,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //               const SizedBox(height: 5),
              //               Text(
              //                 '  Service \nReserved',
              //                 style: TextStyle(fontSize: 20),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),

              //     SizedBox(
              //       width: 175,
              //       height: 150,
              //       child: ElevatedButton(
              //         onPressed: () {
              //           print('Service Requested List Button Pressed');
              //         },
              //         style: ElevatedButton.styleFrom(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           backgroundColor: Colors.white,
              //         ),
              //         child: Center(
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 '6',
              //                 style: TextStyle(
              //                   fontSize: 26,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //               const SizedBox(height: 5),
              //               Text(
              //                 '   Service \nRequested',
              //                 style: TextStyle(fontSize: 20),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              // const SizedBox(height: 20),

              // Divider(color: Colors.grey, thickness: 2),

              // const SizedBox(height: 15),

              

              //const SizedBox(height: 15),

              /*Row(
                children: [
                  Text('Password', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(128, 158, 158, 158),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        Text('27893232'),
                      ],
                    ),
                  ),
                ],
              ),*/
              const SizedBox(height: 15),
              InkWell(
                onTap: () async {
                  final newPhoneNumber = await showDialog<String>(
                    context: context,
                    builder:
                        (context) => ChangeText(
                          fieldName: 'phoneNumber',
                          currentValue: _phoneNumber,
                        ),
                  );

                  if (newPhoneNumber != null && newPhoneNumber.isNotEmpty) {
                    setState(() {
                      _phoneNumber = newPhoneNumber;
                    });
                  }
                },
                child: Row(
                  children: [
                    Text('Phone Number', style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(128, 158, 158, 158),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),

                          Text(_phoneNumber),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Text('Email', style: TextStyle(fontSize: 20)),

                  const SizedBox(width: 20),

                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(128, 158, 158, 158),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        Text(_selectedEmail),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 100,),
            ],
          ),
        ),
      ),

      
    );
  }
}
