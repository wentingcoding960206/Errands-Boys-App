import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  _AvailabilityScreenState createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  final List<String> daysOfWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  Map<String, List<TimeSlot>> availability = {};

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAvailability();
  }

  void loadAvailability() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null || user.email == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("User not logged in")));
      return;
    }

    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('availabilities')
              .doc(user.email)
              .get();

      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data()!;
        Map<String, dynamic> savedAvailability = data['availability'] ?? {};

        for (var day in daysOfWeek) {
          List<TimeSlot> slots = generateTimeSlots();
          List<String> selectedTimes = List<String>.from(
            savedAvailability[day] ?? [],
          );
          for (var slot in slots) {
            if (selectedTimes.contains(slot.time)) {
              slot.isSelected = true;
            }
          }
          availability[day] = slots;
        }
      } else {
        initializeAvailability();
      }
    } catch (e) {
      print("Error loading availability: $e");
      initializeAvailability();
    }

    setState(() {
      isLoading = false;
    });
  }

  void initializeAvailability() {
    for (var day in daysOfWeek) {
      availability[day] = generateTimeSlots();
    }
  }

  List<TimeSlot> generateTimeSlots() {
    List<TimeSlot> slots = [];
    int startHour = 9;
    int endHour = 21;
    for (int hour = startHour; hour < endHour; hour++) {
      slots.add(TimeSlot(time: '${formatHour(hour)}:00'));
      slots.add(TimeSlot(time: '${formatHour(hour)}:30'));
    }
    return slots;
  }

  String formatHour(int hour) {
    return hour < 10 ? '0$hour' : '$hour';
  }

  Widget buildDayColumn(String day, List<TimeSlot> slots) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Set Weekly Availability", style: TextStyle(fontWeight: FontWeight.bold),)),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // ensures center alignment
      children: [
        Text(
          day,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: slots.length,
            itemBuilder: (context, index) {
              final slot = slots[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    slot.isSelected = !slot.isSelected;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Center(
                    // center each time text
                    child: Text(
                      slot.time,
                      style: TextStyle(
                        color: slot.isSelected ? Colors.blue : Colors.black,
                        fontWeight:
                            slot.isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                        decoration:
                            slot.isSelected ? TextDecoration.underline : null,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void saveAvailability() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null || user.email == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not logged in or email missing")),
      );
      return;
    }

    final selected = availability.map(
      (day, slots) => MapEntry(
        day,
        slots.where((s) => s.isSelected).map((s) => s.time).toList(),
      ),
    );

    try {
      await FirebaseFirestore.instance
          .collection('availabilities')
          .doc(user.email) // use email as document ID
          .set({
            'email': user.email,
            'availability': selected,
            'timestamp': FieldValue.serverTimestamp(),
          });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Availability saved!")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error saving: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set Weekly Availability", style: TextStyle(fontWeight: FontWeight.bold),), toolbarHeight: 80),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      daysOfWeek.map((day) {
                        return Container(
                          width: 100,
                          height: MediaQuery.of(context).size.height - 100,
                          margin: EdgeInsets.all(8),
                          child: buildDayColumn(day, availability[day] ?? []),
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveAvailability,
        child: Icon(Icons.save),
      ),
    );
  }
}

class TimeSlot {
  final String time;
  bool isSelected;

  TimeSlot({required this.time, this.isSelected = false});
}
