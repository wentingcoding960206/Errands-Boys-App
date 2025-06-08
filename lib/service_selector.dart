import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errands_boys/firestore_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ServiceSelectorButton extends StatefulWidget {
  final void Function(
    String serviceName,
    String providerId,
    String providerName,
  )?
  onServiceSelected;

  final String? keyword;
  final String? currentUserId;
  final void Function(List<String> selectedTimeSlots)? onTimeSlotSelected;

  const ServiceSelectorButton({
    super.key,
    this.onServiceSelected,
    this.keyword,
    this.currentUserId,
    this.onTimeSlotSelected,
  });

  @override
  State<ServiceSelectorButton> createState() => ServiceSelectorButtonState();
}

class ServiceSelectorButtonState extends State<ServiceSelectorButton> {
  String? selectedService;
  Map<String, dynamic>? selectedProvider;
  List<String> availableServices = [];
  List<Map<String, dynamic>> providers = [];
  List<String> selectedTimeSlots = [];

  bool isSubmitted = false;
  bool hasPickedSlot = false;

  @override
  void initState() {
    super.initState();
    fetchAllAvailableServices().then((services) async {
      List<String> filteredServices = [];

      for (String service in services) {
        final providers = await fetchProvidersForService(service);
        final validProviders =
            providers.where((p) => p['id'] != widget.currentUserId).toList();
        if (validProviders.isNotEmpty) {
          filteredServices.add(service);
        }
      }

      setState(() {
        availableServices =
            widget.keyword != null
                ? filteredServices
                    .where(
                      (s) => s.toLowerCase().contains(
                        widget.keyword!.toLowerCase(),
                      ),
                    )
                    .toList()
                : filteredServices;
      });
    });
  }

  List<DateTime> getNext7DaysFromTomorrow() {
    final today = DateTime.now();
    return List.generate(7, (index) => today.add(Duration(days: index + 1)));
  }

  String weekdayShortName(DateTime date) {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return names[date.weekday - 1];
  }

  String formatDate(DateTime date) {
    return '${_monthName(date.month)} ${date.day}';
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month];
  }

  void resetSelection() {
    setState(() {
      selectedService = null;
      selectedProvider = null;
      selectedTimeSlots = [];
      hasPickedSlot = false;
      isSubmitted = false;
      providers.clear();
    });
  }

  void markAsSubmitted() {
    setState(() {
      isSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          hint: const Text("Select Service"),
          value: selectedService,
          items:
              availableServices.map((service) {
                return DropdownMenuItem<String>(
                  value: service,
                  child: Text(service),
                );
              }).toList(),
          onChanged: (value) async {
            if (value == null) return;
            setState(() {
              selectedService = value;
              selectedProvider = null;
              selectedTimeSlots = [];
              providers = [];
              hasPickedSlot = false;
              isSubmitted = false;
            });

            final result = await fetchProvidersForService(value);
            setState(() {
              providers =
                  result.where((p) => p['id'] != widget.currentUserId).toList();
            });
          },
        ),

        const SizedBox(height: 16),

        if (providers.isEmpty && selectedService != null)
          const Text("No verified providers found for this service."),

        if (providers.isNotEmpty && !isSubmitted)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select a Provider:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...providers.map((provider) {
                return ListTile(
                  title: Text(provider['fullName'] ?? 'No Name'),
                  subtitle: Text(provider['teenEmail'] ?? 'No Email'),
                  onTap: () async {
                    setState(() {
                      selectedProvider = provider;
                      selectedTimeSlots.clear();
                      hasPickedSlot = false;
                    });

                    final email = provider['teenEmail'];
                    if (email == null) return;

                    final availability = await fetchAvailability(email);
                    if (availability.isEmpty) {
                      showDialog(
                        context: context,
                        builder:
                            (_) => const AlertDialog(
                              title: Text("No Availability"),
                              content: Text(
                                "This provider has not added any availability.",
                              ),
                            ),
                      );
                      return;
                    }

                    final availabilityMap = <String, List<String>>{};
                    availability.forEach((day, times) {
                      availabilityMap[day] = List<String>.from(times);
                    });

                    final next7Days = getNext7DaysFromTomorrow();
                    final filteredEntries =
                        <MapEntry<DateTime, List<String>>>[];
                    final today = DateTime.now(); //
                    int daysChecked = 0; //
                    int daysWithAvailability = 0; //

                    while (daysWithAvailability < 7 && daysChecked < 30) {
                      final date = today.add(Duration(days: daysChecked + 1));
                      final weekday = weekdayShortName(date);

                      if (!availabilityMap.containsKey(weekday)) {
                        daysChecked++;
                        continue;
                      }

                      final allSlots = availabilityMap[weekday]!;

                      final booked = await fetchProvidersBookedSlots(
                        provider['id'],
                      );
                      final bookedCus = await fetchCustomersBookedSlots(
                        FirebaseAuth.instance.currentUser?.uid ?? "",
                      );

                      final label =
                          '${weekdayShortName(date)} (${formatDate(date)})';

                      final availableSlots =
                          allSlots.where((slot) {
                            final formattedSlot =
                                '$label at $slot'.toLowerCase();
                            final bookedLower =
                                booked
                                    .map((b) => b.trim().toLowerCase())
                                    .toList();
                            final bookedCusLower =
                                bookedCus
                                    .map((b) => b.trim().toLowerCase())
                                    .toList();
                            return !bookedLower.contains(formattedSlot) &&
                                !bookedCusLower.contains(formattedSlot);
                          }).toList();

                      if (availableSlots.isNotEmpty) {
                        filteredEntries.add(MapEntry(date, availableSlots));
                        daysWithAvailability++;
                      }

                      daysChecked++;
                    }

                    // for (final date in next7Days) {
                    //   final weekday = weekdayShortName(date);

                    //   if (!availabilityMap.containsKey(weekday)) continue;

                    //   print("selector button provider id: ${provider['id']}");
                    //   print(
                    //     "customer: ${FirebaseAuth.instance.currentUser?.uid}",
                    //   );

                    //   final allSlots = availabilityMap[weekday]!;

                    //   print("allSlots: $allSlots");
                    //   final booked = await fetchProvidersBookedSlots(
                    //     provider['id'],
                    //   ); // You'll define this

                    //   final bookedCus = await fetchCustomersBookedSlots(
                    //     FirebaseAuth.instance.currentUser?.uid ?? "",
                    //   );

                    //   final label =
                    //       '${weekdayShortName(date)} (${formatDate(date)})';

                    //   final availableSlots =
                    //       allSlots.where((slot) {
                    //         final formattedSlot =
                    //             '$label at $slot'.toLowerCase();
                    //         print("formattedSlot: $formattedSlot");

                    //         final bookedLower =
                    //             booked
                    //                 .map((b) => b.trim().toLowerCase())
                    //                 .toList();
                    //         print("bookedLower: $bookedLower");

                    //         final bookedCusLower =
                    //             bookedCus
                    //                 .map((b) => b.trim().toLowerCase())
                    //                 .toList();
                    //         return !bookedLower.contains(formattedSlot) &&
                    //             !bookedCusLower.contains(formattedSlot);
                    //       }).toList();

                    //   print("allSlots: $allSlots");
                    //   print("booked (provider): $booked");
                    //   print("book (customer): $bookedCus");
                    //   print("Available after filtering: $availableSlots");

                    //   if (availableSlots.isNotEmpty) {
                    //     filteredEntries.add(MapEntry(date, availableSlots));
                    //   }
                    // }

                    showDialog(
                      context: context,
                      builder: (_) {
                        return StatefulBuilder(
                          builder: (context, setStateDialog) {
                            return AlertDialog(
                              title: const Text("Select a Time Slot"),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: ListView(
                                  shrinkWrap: true,
                                  children:
                                      filteredEntries.map((entry) {
                                        final date = entry.key;
                                        final times = entry.value;
                                        final label =
                                            '${weekdayShortName(date)} (${formatDate(date)})';

                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                label,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Wrap(
                                                spacing: 10,
                                                runSpacing: 8,
                                                children:
                                                    times.map((time) {
                                                      final slot =
                                                          '$label at $time';
                                                      final selected =
                                                          selectedTimeSlots
                                                              .contains(slot);

                                                      return GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            if (selected) {
                                                              selectedTimeSlots
                                                                  .remove(slot);
                                                            } else {
                                                              selectedTimeSlots
                                                                  .add(slot);
                                                            }
                                                            hasPickedSlot =
                                                                selectedTimeSlots
                                                                    .isNotEmpty;
                                                          });

                                                          setStateDialog(() {});

                                                          widget
                                                              .onTimeSlotSelected
                                                              ?.call(
                                                                selectedTimeSlots,
                                                              );

                                                          if (widget.onServiceSelected !=
                                                                  null &&
                                                              selectedService !=
                                                                  null &&
                                                              provider['id'] !=
                                                                  null &&
                                                              provider['fullName'] !=
                                                                  null) {
                                                            widget
                                                                .onServiceSelected!(
                                                              selectedService!,
                                                              provider['id'],
                                                              provider['fullName'],
                                                            );
                                                          }
                                                        },
                                                        child: Text(
                                                          time,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            decoration:
                                                                selected
                                                                    ? TextDecoration
                                                                        .underline
                                                                    : TextDecoration
                                                                        .none,
                                                            color:
                                                                selected
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .blue,
                                                            fontWeight:
                                                                selected
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .normal,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              }).toList(),
            ],
          ),

        if (selectedProvider != null &&
            selectedTimeSlots.isNotEmpty &&
            hasPickedSlot &&
            !isSubmitted)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const Text(
                "Selected Service Provider:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text("Name: ${selectedProvider!['fullName'] ?? 'N/A'}"),
              Text("Email: ${selectedProvider!['teenEmail'] ?? 'N/A'}"),
              const SizedBox(height: 8),
              const Text("Selected Time Slots:"),
              const SizedBox(height: 4),
              ...selectedTimeSlots.map((slot) => Text("• $slot")),
            ],
          ),
      ],
    );
  }
}
