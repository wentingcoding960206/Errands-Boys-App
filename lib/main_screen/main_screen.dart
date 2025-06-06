import 'package:errands_boys/auth_service.dart';
import 'package:errands_boys/categories_screen/categories_screen.dart';
import 'package:errands_boys/main.dart';
import 'package:errands_boys/main_screen/categories_card.dart';
import 'package:errands_boys/reserved_requested_screen/firebase_helper_reserved_request.dart';
import 'package:errands_boys/reserved_requested_screen/requested_screen.dart';
import 'package:errands_boys/reserved_requested_screen/reserved_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:errands_boys/reserved_requested_screen/firebase_helper_reserved_request.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with RouteAware {
  final TextEditingController searchController = TextEditingController();
  final PageController popularServiceController = PageController();
  final int numOfPopularServices = 6;
  int _selectedIndex = 0;
  int _activeDotIndex = 0;
  int totalReservedServices = 0;
  int totalRequestedServices = 0;

  Map<String, List<ReservedService>> categorizedServices = {
    'Academics': [],
    'Aesthetics': [],
    'Outdoor Chores': [],
    'Indoor Chores': [],
  };
  Map<String, List<RequestedService>> providerCategorizedServices = {
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    searchController.dispose();
    popularServiceController.dispose();
    super.dispose();
  }

  // Called when this route is pushed onto navigator
  @override
  void didPush() {
    _loadServices();
  }

  // Called when coming back to this route (e.g. from another screen popped)
  @override
  void didPopNext() {
    _loadServices();
  }

  Future<void> _loadServices() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      print('User not logged in!');
      return;
    }
    print('Fetching services for user: $uid');

    try {
      final fetchedData = await fetchReservedServices(uid);
      final fetchedProviderRequested = await fetchRequestedServices(uid);
      print('Fetched data: $fetchedData');
      print('Fetched Provider Requested Date: $fetchedProviderRequested');
      setState(() {
        categorizedServices = fetchedData;
        totalReservedServices = categorizedServices.values.fold(
          0,
          (sum, list) => sum + list.length,
        );
        providerCategorizedServices = fetchedProviderRequested;
        totalRequestedServices = providerCategorizedServices.values.fold(
          0,
          (sum, list) => sum + list.length,
        );
      });
    } catch (e) {
      print('Error fetching services: $e');
    }
  }

  void updateActiveDot(int index) {
    setState(() {
      _activeDotIndex = index;
      print('Dot tapped: $index');
      print('Active dot index: $_activeDotIndex');
    });

    final page = index.toDouble();
    popularServiceController.jumpTo(page * MediaQuery.of(context).size.width);
  }

  void logout() {
    final authservice = AuthService();
    authservice.signOut();
    print("logout logout");
  }

  void academicsOnTap(BuildContext context) {
    print('academicsOnTap Pressed');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriesScreen(title: 'Academics'),
      ),
    );
  }

  void aestheticsOnTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriesScreen(title: 'Aesthetics'),
      ),
    );
  }

  void outDoorOnTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriesScreen(title: 'Outdoor Chores'),
      ),
    );
  }

  void InDoorOnTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriesScreen(title: 'Indoor Chores'),
      ),
    );
  }

  void reservedOnTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReservedScreen()),
    );
  }

  void requestedOnTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RequestedScreen()),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end, // push icon to the right
          children: [
            Text(
              'Main Screen',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 65,),
            IconButton(
              onPressed: () {
                logout();
                print("Exit Pressed");
              },
              icon: Icon(Icons.logout),
              tooltip: 'Logout',
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Title(
                color: Colors.black,
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CategoriesCard(
                        titleCategories: 'Academics',
                        discriptionCategories: 'Tutoring',
                        iconCategories: Icons.book,
                        distanceIconText: 10,
                        distanceIconBorder: 15,
                        colorCategories: Colors.cyanAccent,
                        onTap: () => academicsOnTap(context),
                      ),
                      CategoriesCard(
                        titleCategories: 'Aesthetics',
                        discriptionCategories: 'Painting & Party',
                        iconCategories: Icons.format_paint,
                        distanceIconText: 10,
                        distanceIconBorder: 15,
                        colorCategories: Colors.yellow,
                        onTap: () => aestheticsOnTap(context),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CategoriesCard(
                        titleCategories: 'Outdoor \n    Chores',
                        discriptionCategories: '',
                        iconCategories: Icons.pets,
                        distanceIconText: 20,
                        distanceIconBorder: 15,
                        colorCategories: Colors.orangeAccent,
                        onTap: () => outDoorOnTap(context),
                      ),
                      CategoriesCard(
                        titleCategories: 'Indoors \n    Chores',
                        discriptionCategories: '',
                        iconCategories: Icons.home,
                        distanceIconText: 20,
                        distanceIconBorder: 15,
                        colorCategories: Colors.lightGreenAccent,
                        onTap: () => InDoorOnTap(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: Text(
                'Services',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 175,
                    height: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Service Reserved List Button Pressed');
                        print('$totalReservedServices number reserved');
                        reservedOnTap(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$totalReservedServices',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '  Service \nReserved',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 175,
                    height: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Service Requested List Button Pressed');
                        print('$totalRequestedServices number reserved');
                        requestedOnTap(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$totalRequestedServices',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '   Service \nRequested',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: BottomNavBar(
      //   navBarOnTap: _onItemTapped,
      //   navBarSelectedIndex: _selectedIndex,
      // ),
    );
  }
}
