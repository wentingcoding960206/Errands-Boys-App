import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errands_boys/chat/chat_service.dart';
import 'package:errands_boys/join_us_screen/drop_down.dart';
import 'package:errands_boys/phone_number_field.dart';
import 'package:errands_boys/price_screen/date_picker.dart';
import 'package:errands_boys/price_screen/drop_down_service.dart';
import 'package:errands_boys/price_screen/send_initial_message.dart';
import 'package:errands_boys/price_screen/textfield_register_form.dart';
import 'package:errands_boys/service_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  final String title;
  final double price;
  final String additionalCharge;
  final String firebaseCollection;
  final String? providerId;
  final String? providerName;
  final String? providerEmail;
  final Table table;

  const PriceScreen({
    super.key,
    required this.title,
    required this.price,
    required this.additionalCharge,
    required this.firebaseCollection,
    this.providerId,
    this.providerName,
    this.providerEmail,
    required this.table,
  });

  @override
  State<PriceScreen> createState() => _PriceScreen();
}

class _PriceScreen extends State<PriceScreen> {
  String? selectedServiceName;
  String? selectedProviderId;
  String? selectedProviderName;
  bool _isEmailChecked = false;
  bool _isPhoneChecked = false;
  List<String> selectedTimeSlot = [];
  int _selectedIndex = 0;
  final TextEditingController fullName_formController = TextEditingController();
  final TextEditingController address_formController = TextEditingController();
  final TextEditingController phoneNumber_formController =
      TextEditingController();
  final TextEditingController email_formController = TextEditingController();
  final TextEditingController date_formController = TextEditingController();
  //final TextEditingController time_formController = TextEditingController();
  final TextEditingController subject_formController = TextEditingController();
  final GlobalKey<ServiceSelectorButtonState> _dropdownKey =
      GlobalKey<ServiceSelectorButtonState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('Bottom Nav Bar Icon $index pressed');
    });
  }

  void _toggleEmailCheckBox(bool? newEmailValue) {
    setState(() {
      _isEmailChecked = newEmailValue!;
    });
  }

  void _togglePhoneCheckBox(bool? newPhoneValue) {
    setState(() {
      _isPhoneChecked = newPhoneValue!;
    });
  }

  Future<void> _loadEmail() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    if (doc.exists) {
      final email = doc['email'];
      setState(() {
        email_formController.text = email;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - 32;
    final thirdWidth = screenWidth / 3;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(width: 20),

              Icon(Icons.book, size: 30),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.table,

              const SizedBox(height: 25),

              TextfieldRegisterForm(
                formTextFieldController: fullName_formController,
                formTextFieldText: 'Full Name',
              ),

              const SizedBox(height: 10),

              TextfieldRegisterForm(
                formTextFieldController: address_formController,
                formTextFieldText: 'Address',
              ),

              const SizedBox(height: 10),

              Text(
                'Phone Number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              CanadianPhoneNumberField(controller: phoneNumber_formController),

              const SizedBox(height: 10),

              Text(
                'Email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                height: 48,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(60, 158, 158, 158),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.transparent, // or any color you want
                  ),
                ),
                // child: Text(email_formController.text, style: TextStyle(color: Colors.white),),
                child: Text(
                  email_formController.text,
                  style: TextStyle(fontSize: 17),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Prefered Contact Method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              Row(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _isEmailChecked,
                        onChanged: _toggleEmailCheckBox,
                      ),
                      Text('Email'),
                    ],
                  ),

                  const SizedBox(width: 20),

                  Row(
                    children: [
                      Checkbox(
                        value: _isPhoneChecked,
                        onChanged: _togglePhoneCheckBox,
                      ),
                      Text('Phone Number'),
                    ],
                  ),
                ],
              ),

              // DateTimePicker(
              //   dateController: date_formController,
              //   //timeController: time_formController
              // ),
              const SizedBox(height: 10),

              Text(
                'Select a service',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              ServiceSelectorButton(
                key: _dropdownKey,
                keyword: widget.title,
                currentUserId: FirebaseAuth.instance.currentUser?.uid,
                onServiceSelected: (serviceName, providerId, providerName) {
                  setState(() {
                    selectedServiceName = serviceName;
                    selectedProviderId = providerId;
                    selectedProviderName = providerName;
                  });
                },
                onTimeSlotSelected: (slots) {
                  setState(() {
                    selectedTimeSlot = slots;
                  });
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(400, 50),
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onPressed: () async {
                  print('Submit Request Button Pressed');

                  final chatService = ChatService();

                  final message = generateRequestMessage(
                    providerName: selectedProviderName ?? '',
                    serviceName: selectedServiceName ?? '',
                    address:
                        address_formController.text, // Your value from form
                    phone:
                        phoneNumber_formController.text, // Your value from form
                    contactMethod:
                        _isEmailChecked && _isPhoneChecked
                            ? 'Both Email and Phone'
                            : _isEmailChecked
                            ? 'Email'
                            : 'Phone',
                    timeSlot: selectedTimeSlot.join(', '),
                    customerName:
                        fullName_formController
                            .text, // You can fetch or store this during init
                  );

                  await chatService.SendMessage(
                    selectedProviderId ?? '', // receiverID
                    message,
                  );

                  if (fullName_formController.text.isEmpty ||
                      address_formController.text.isEmpty ||
                      phoneNumber_formController.text.isEmpty ||
                      email_formController.text.isEmpty ||
                      (!_isEmailChecked && !_isPhoneChecked)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please fill in all fields and select a contact method.',
                        ),
                      ),
                    );
                    return;
                  }

                  if (selectedServiceName == null ||
                      selectedServiceName!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a service.')),
                    );
                    return;
                  }

                  final uid = FirebaseAuth.instance.currentUser?.uid;

                  try {
                    print(
                      'Saving order with service: $selectedServiceName, provider ID: $selectedProviderId, provider name: $selectedProviderName',
                    );

                    // customer reserved
                    final userDocRef = FirebaseFirestore.instance
                        .collection('customer_request')
                        .doc(uid);

                    await userDocRef.set({
                      'created_at': FieldValue.serverTimestamp(),
                    }, SetOptions(merge: true));

                    final selectedServiceDoc = userDocRef
                        .collection('selected_service')
                        .doc(selectedServiceName);
                    await selectedServiceDoc.set({
                      'some_service_field':
                          'value', // e.g., description, category, etc.
                    });

                    final docRefRequest = selectedServiceDoc
                        .collection('providerID')
                        .doc(selectedProviderId);

                    await docRefRequest.set({
                      'full_name': fullName_formController.text,
                      'address': address_formController.text,
                      'phone_number': phoneNumber_formController.text,
                      'email': email_formController.text,
                      'preferred_contact':
                          _isEmailChecked && _isPhoneChecked
                              ? 'Both'
                              : _isEmailChecked
                              ? 'Email'
                              : 'Phone',
                      //'date': date_formController.text,
                      'price': widget.price,
                      'additional_charge': widget.additionalCharge,
                      'provider_name': selectedProviderName ?? '',
                      'provider_ID': selectedProviderId ?? '',
                      //'time_slots': selectedTimeSlot ?? [],
                      'ordered_by_uid': uid ?? '',
                      'timestamp': FieldValue.serverTimestamp(),
                    }, SetOptions(merge: true));

                    if (selectedTimeSlot != null &&
                        selectedTimeSlot.isNotEmpty) {
                      await docRefRequest.update({
                        'time_slots': FieldValue.arrayUnion(
                          selectedTimeSlot is List<String>
                              ? selectedTimeSlot
                              : [selectedTimeSlot],
                        ),
                        'timestamp': Timestamp.now(),
                      });
                    }

                    // provider request
                    final providerDocRef = FirebaseFirestore.instance
                        .collection('provider_request')
                        .doc(selectedProviderId);

                    await providerDocRef.set({
                      'created_at': FieldValue.serverTimestamp(),
                    }, SetOptions(merge: true));

                    final selectedProviderServiceDoc = providerDocRef
                        .collection('selected_service')
                        .doc(selectedServiceName);
                    await selectedProviderServiceDoc.set({
                      'some_service_field':
                          'value', // e.g., description, category, etc.
                    });

                    final docRefProviderRequest = selectedProviderServiceDoc
                        .collection('customerID')
                        .doc(uid);

                    await docRefProviderRequest.set({
                      'customer_name': fullName_formController.text,
                      'address': address_formController.text,
                      'phone_number': phoneNumber_formController.text,
                      'email': email_formController.text,
                      'preferred_contact':
                          _isEmailChecked && _isPhoneChecked
                              ? 'Both'
                              : _isEmailChecked
                              ? 'Email'
                              : 'Phone',
                      //'date': date_formController.text,
                      'price': widget.price,
                      'additional_charge': widget.additionalCharge,
                      'provider_name': selectedProviderName ?? '',
                      'provider_ID': selectedProviderId,
                      //'time_slots': selectedTimeSlot ?? [],
                      'ordered_by_uid': uid ?? '',
                      'timestamp': FieldValue.serverTimestamp(),
                    }, SetOptions(merge: true));

                    if (selectedTimeSlot != null &&
                        selectedTimeSlot.isNotEmpty) {
                      await docRefProviderRequest.update({
                        'time_slots': FieldValue.arrayUnion(
                          selectedTimeSlot is List<String>
                              ? selectedTimeSlot
                              : [selectedTimeSlot],
                        ),
                        'timestamp': Timestamp.now(),
                      });
                    }

                    print("providerId : ${selectedProviderId}");
                    print("bookedSlots : $selectedTimeSlot");

                    final docRef = FirebaseFirestore.instance
                        .collection('providersBooked')
                        .doc(selectedProviderId);

                    // 1. Make sure the doc exists (create if not)
                    await docRef.set(
                      {
                        // 'userId': FirebaseAuth.instance.currentUser!.uid,
                        // 'userName': fullName_formController.text,
                        //'service': selectedServiceName,
                        //'timeslots': [], // initialize empty array if new
                        'timestamp': Timestamp.now(),
                      },
                      SetOptions(merge: true),
                    ); // merge so existing fields stay intact

                    // 2. Add new time slot(s) to timeslots array without removing old ones
                    if (selectedTimeSlot != null &&
                        selectedTimeSlot.isNotEmpty) {
                      await docRef.update({
                        'timeslots': FieldValue.arrayUnion(
                          selectedTimeSlot is List<String>
                              ? selectedTimeSlot
                              : [selectedTimeSlot],
                        ),
                        'timestamp': Timestamp.now(),
                      });
                    }

                    // submit Provider
                    final docRefCus = FirebaseFirestore.instance
                        .collection('customersBooked')
                        .doc(FirebaseAuth.instance.currentUser?.uid);

                    // 1. Make sure the doc exists (create if not)
                    await docRefCus.set(
                      {
                        // 'userId': FirebaseAuth.instance.currentUser!.uid,
                        // 'userName': fullName_formController.text,
                        
                        //'timeslots': [], // initialize empty array if new
                        'timestamp': Timestamp.now(),
                      },
                      SetOptions(merge: true),
                    ); // merge so existing fields stay intact

                    // 2. Add new time slot(s) to timeslots array without removing old ones
                    if (selectedTimeSlot != null &&
                        selectedTimeSlot.isNotEmpty) {
                          
                      await docRefCus.update({
                        'timeslots': FieldValue.arrayUnion(
                          selectedTimeSlot is List<String>
                              ? selectedTimeSlot
                              : [selectedTimeSlot],
                        ),
                        'timestamp': Timestamp.now(),
                      });
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Request submitted successfully!'),
                      ),
                    );

                    // Clear form controllers and state
                    fullName_formController.clear();
                    address_formController.clear();
                    phoneNumber_formController.clear();
                    //email_formController.clear();
                    date_formController.clear();
                    subject_formController.clear();
                    setState(() {
                      _isEmailChecked = false;
                      _isPhoneChecked = false;
                      selectedServiceName = null;
                      selectedProviderId = null;
                      selectedProviderName = null;
                    });

                    _dropdownKey.currentState?.markAsSubmitted();
                    _dropdownKey.currentState?.resetSelection();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Failed to submit request. Please try again.',
                        ),
                      ),
                    );
                    print('Firestore error: $e');
                  }
                },
                child: Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
