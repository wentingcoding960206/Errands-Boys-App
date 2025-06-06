import 'package:errands_boys/bottom_nav_bar.dart';
import 'package:errands_boys/reserved_requested_screen/button_reserve_requested_screen.dart';
import 'package:errands_boys/reserved_requested_screen/firebase_helper_reserved_request.dart';
import 'package:errands_boys/reserved_requested_screen/list_reserved_requested.dart';
import 'package:errands_boys/screen_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservedScreen extends StatefulWidget {
  const ReservedScreen({super.key});

  @override
  State<ReservedScreen> createState() => _ReservedScreen();
}

class _ReservedScreen extends State<ReservedScreen> {
  int _selectedIndex = 0;
  int _activeIndex = 0;
  bool isLoading = true;

  Map<String, List<ReservedService>> reservedService = {
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

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _loadServices();
  //   });
  // }

  Future<void> _loadServices() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    print('Fetching data for uid: $uid');

    final fetchedData = await fetchReservedServices(uid.toString());

    print('Fetched data: $fetchedData');
    setState(() {
      reservedService = fetchedData;
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
    //final categorizedServices = context.watch<ReservedData>().categorizedServices;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'Service Reserved',
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
                                    (reservedService['Academics'] ?? [])
                                        .map(
                                          (service) => ListReservedRequested(
                                            serviceName: service.serviceName,
                                            serviceTime: service.timeSlot,
                                            serviceProvider:
                                                service.serviceProvider,
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),

                            // Aesthetics
                            SingleChildScrollView(
                              child: Column(
                                children:
                                    (reservedService['Aesthetics'] ?? [])
                                        .map(
                                          (service) => ListReservedRequested(
                                            serviceName: service.serviceName,
                                            serviceTime: service.timeSlot,
                                            serviceProvider:
                                                service.serviceProvider,
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),

                            // Outdoor Chores
                            SingleChildScrollView(
                              child: Column(
                                children:
                                    (reservedService['Outdoor Chores'] ?? [])
                                        .map(
                                          (service) => ListReservedRequested(
                                            serviceName: service.serviceName,
                                            serviceTime: service.timeSlot,
                                            serviceProvider:
                                                service.serviceProvider,
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),

                            // Indoor Chores
                            SingleChildScrollView(
                              child: Column(
                                children:
                                    (reservedService['Indoor Chores'] ?? [])
                                        .map(
                                          (service) => ListReservedRequested(
                                            serviceName: service.serviceName,
                                            serviceTime: service.timeSlot,
                                            serviceProvider:
                                                service.serviceProvider,
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
