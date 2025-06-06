import 'package:errands_boys/bottom_nav_bar.dart';
import 'package:errands_boys/reserved_requested_screen/button_reserve_requested_screen.dart';
import 'package:errands_boys/reserved_requested_screen/firebase_helper_reserved_request.dart';
import 'package:errands_boys/reserved_requested_screen/list_reserved_requested.dart';
import 'package:errands_boys/screen_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestedScreen extends StatefulWidget {
  const RequestedScreen({super.key});

  @override
  State<RequestedScreen> createState() => _RequestedScreen();
}

class _RequestedScreen extends State<RequestedScreen> {
  int _selectedIndex = 0;
  int _activeIndex = 0;
  bool isLoading = true;

  Map<String, List<RequestedService>> requestedService = {
    'Academics': [],
    'Aesthetics': [],
    'Outdoor Chores': [],
    'Indoor Chores': [],
  };

  @override
  void initState() {
    super.initState();
    _loadServices(); // your method to fetch
  }

  Future<void> _loadServices() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    print('Fetching data for uid: $uid');

    final fetchedData = await fetchRequestedServices(uid.toString());

    print('Fetched data: $fetchedData');
    setState(() {
      requestedService = fetchedData;
      isLoading = false;
    });
  }

  void _onItemTapped(int selectedTabIndex) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder:
            (_) => ScreenManager(
              initialSelectedTabIndex:
                  selectedTabIndex, // Pass the selected tab index
            ),
      ),
      (route) => false, // Remove all previous routes
    );
  }

  void _onButtonTap(int index) {
    if (_activeIndex != index) {
      // Prevent unnecessary rebuilds
      setState(() {
        _activeIndex = index;
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'Service Requested',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),

      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20.0,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      91,
                                      158,
                                      158,
                                      158,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ButtonReserveRequestedScreen(
                                    index: 0,
                                    nameCategories: 'Academics',
                                    heightCategories: 40,
                                    widthCategories: 130,
                                    onButtonTap: _onButtonTap,
                                    isButtonActive: _activeIndex == 0,
                                  ),

                                  const SizedBox(width: 10),

                                  ButtonReserveRequestedScreen(
                                    index: 1,
                                    nameCategories: 'Aesthetics',
                                    heightCategories: 40,
                                    widthCategories: 125,
                                    onButtonTap: _onButtonTap,
                                    isButtonActive: _activeIndex == 1,
                                  ),

                                  const SizedBox(width: 10),

                                  ButtonReserveRequestedScreen(
                                    nameCategories: 'Outdoor Chores',
                                    index: 2,
                                    heightCategories: 40,
                                    widthCategories: 165,
                                    onButtonTap: _onButtonTap,
                                    isButtonActive: _activeIndex == 2,
                                  ),

                                  const SizedBox(width: 10),

                                  ButtonReserveRequestedScreen(
                                    index: 3,
                                    nameCategories: 'Indoor Chores',
                                    heightCategories: 40,
                                    widthCategories: 150,
                                    onButtonTap: _onButtonTap,
                                    isButtonActive: _activeIndex == 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Expanded(
                        child: IndexedStack(
                          index: _activeIndex,

                          children: [
                            // Academics
                            SingleChildScrollView(
                              child: Column(
                                children:
                                    (requestedService['Academics'] ?? [])
                                        .map(
                                          (service) => ListReservedRequested(
                                            serviceName: service.serviceName,
                                            serviceTime: service.timeSlot,
                                            serviceProvider:
                                                service.serviceCustomer,
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),

                            // Aesthetics
                            SingleChildScrollView(
                              child: Column(
                                children:
                                    (requestedService['Aesthetics'] ?? [])
                                        .map(
                                          (service) => ListReservedRequested(
                                            serviceName: service.serviceName,
                                            serviceTime: service.timeSlot,
                                            serviceProvider:
                                                service.serviceCustomer,
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),

                            // Outdoor Chores
                            SingleChildScrollView(
                              child: Column(
                                children:
                                    (requestedService['Outdoor Chores'] ?? [])
                                        .map(
                                          (service) => ListReservedRequested(
                                            serviceName: service.serviceName,
                                            serviceTime: service.timeSlot,
                                            serviceProvider:
                                                service.serviceCustomer,
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),

                            // Indoor Chores
                            SingleChildScrollView(
                              child: Column(
                                children:
                                    (requestedService['Indoor Chores'] ?? [])
                                        .map(
                                          (service) => ListReservedRequested(
                                            serviceName: service.serviceName,
                                            serviceTime: service.timeSlot,
                                            serviceProvider:
                                                service.serviceCustomer,
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

      bottomNavigationBar: BottomNavBar(
        navBarOnTap: _onItemTapped,
        navBarSelectedIndex: _selectedIndex,
      ),
    );
  }
}
