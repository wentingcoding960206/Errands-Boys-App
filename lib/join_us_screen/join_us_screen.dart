import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errands_boys/email_field.dart';
import 'package:errands_boys/join_us_screen/drop_down.dart';
//import 'package:errands_boys/join_us_screen/join_us_service_list/dropdown_list.dart';
import 'package:errands_boys/join_us_screen/submit_join_us_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:errands_boys/join_us_screen/textfield_join_us.dart';

class JoinUsScreen extends StatefulWidget {
  const JoinUsScreen({super.key});

  @override
  State<JoinUsScreen> createState() => _JoinUsScreen();
}

class _JoinUsScreen extends State<JoinUsScreen> {
  final TextEditingController nameJoinUsController = TextEditingController();
  final TextEditingController teenEmailJoinUsController =
      TextEditingController();
  final TextEditingController parentEmailJoinUsController =
      TextEditingController();
  final TextEditingController phoneJoinUsController = TextEditingController();
  final TextEditingController serviceJoinUsController = TextEditingController();
  final TextEditingController introJoinUsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTeenEmail();
  }

  Future<bool> _hasSubmittedForm() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return false; // or throw error depending on your logic

    final doc =
        await FirebaseFirestore.instance
            .collection('joinus_request')
            .doc(uid)
            .get();
    return doc.exists;
  }

  Future<void> _loadTeenEmail() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    if (doc.exists) {
      final email = doc['email']; // OR use whatever field your Firestore uses
      teenEmailJoinUsController.text = email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasSubmittedForm(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting, show a loading spinner
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          // If there was an error reading Firestore, show an error message or fallback UI
          return Scaffold(body: Center(child: Text('Error loading data')));
        }
        final hasSubmitted = snapshot.data ?? false;
        if (hasSubmitted) {
          // User already submitted the form -> show blank page or a message
          return Scaffold(
            body: Center(child: Text('You have already submitted the form.')),
          );
        }

        return Scaffold(
          resizeToAvoidBottomInset: true,
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
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How to Apply:\n1. Fill Out the Application Form – Provide your details, availability, and services you can offer.\n2. Attend an Interview – After submitting your application, you’ll receive an interview invitation.\n3. Get Approved & Start Working – If selected, you’ll be added to our job network and can begin accepting work requests!',
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Interview Process:\n'
                      '• Interviews will be scheduled after reviewing applications.\n'
                      '• Conducted in-person or via video call.\n'
                      '• Discuss your skills, reliability, and work ethic.',
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Who Can Apply\n'
                      '• Teens aged 13 or above.\n'
                      '• Must be responsible, punctual, and hardworking.\n'
                      '• Willing to follow safety guidelines and respect clients.',
                    ),
                    const SizedBox(height: 25),
                    TextfieldJoinUs(
                      joinTextFieldText: 'Full Name',
                      joinTextFieldController: nameJoinUsController,
                    ),
                    const SizedBox(height: 10),

                    TextfieldJoinUs(
                      joinTextFieldText: 'Teen Email',
                      joinTextFieldController: teenEmailJoinUsController,
                    ),

                    const SizedBox(height: 10),
                    // TextfieldJoinUs(
                    //   joinTextFieldText: 'Parent Email',
                    //   joinTextFieldController: parentEmailJoinUsController,
                    // ),

                    Text(
                      "Parent Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(height: 10),

                    EmailField(controller: parentEmailJoinUsController, textFieldText: "Parent Email"),

                    const SizedBox(height: 10),
                    Text(
                      'Select Services You Can Offer:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CompositedTransformTarget(
                      link: getLayerLink(),
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          toggleDropdown(
                            context: context,
                            refreshUI: () => setState(() {}),
                            controller: serviceJoinUsController,
                          );
                        },
                        child: AbsorbPointer(
                          absorbing: true,
                          child: TextField(
                            key: getServiceFieldKey(),
                            controller: serviceJoinUsController,
                            decoration: InputDecoration(
                              hintText: 'Tap to select services',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.arrow_drop_down),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    TextfieldJoinUs(
                      joinTextFieldText: 'Self Introduction (be specific)',
                      joinTextFieldController: introJoinUsController,
                      maxLines: 6,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          print('Join Us Application Button Pressed');
                          try {
                            await submitJoinUsForm(
                              fullName: nameJoinUsController.text,
                              teenEmail: teenEmailJoinUsController.text,
                              parentEmail: parentEmailJoinUsController.text,
                              phoneNumber: phoneJoinUsController.text,
                              selectedServices: selectedServices,
                              introduction: introJoinUsController.text,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Application submitted successfully!',
                                ),
                              ),
                            );

                            // Optionally clear the form
                            nameJoinUsController.clear();
                            teenEmailJoinUsController.clear();
                            parentEmailJoinUsController.clear();
                            phoneJoinUsController.clear();
                            serviceJoinUsController.clear();
                            introJoinUsController.clear();

                            // After submit, refresh UI to show blank page
                            setState(() {});
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${e.toString()}')),
                            );
                          }
                        },
                        child: Text('Submit Application'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
