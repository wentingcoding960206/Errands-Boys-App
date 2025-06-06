import 'package:errands_boys/bottom_nav_bar.dart';
import 'package:errands_boys/order_history_screen/card_order_history.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreen();
}

class _OrderHistoryScreen extends State<OrderHistoryScreen> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('Bottom Nav Bar Icon $index pressed');
    });
  }

  List< String> nameOrders = [
    'Tutoring - Math',
    'Tutoring - Physics',
    'Tutoring - Chemistry',
    'Tutoring - English',
    'Gardening'
  ];

  List<String> totalTimeOrders = [
    '3 hr',
    '5 hr',
    '2 hr',
    '3 hr',
    '4 hr'
  ];

  List<String> dateOrders = [
    '2025 / 3 / 5',
    '2022 / 2 / 6',
    '2026 / 7 / 5',
    '2025 / 1 / 5',
    '2023 / 10 / 12'
  ];

  List<double> priceOrders = [
    45,
    75,
    30,
    45,
    60
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'Order History',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold
          ),
        )
      ),
           
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
        
                Column(
                  children: List.generate(nameOrders.length, (index) {
                    return CardOrderHistory(
                      nameOrdersCard: nameOrders[index],
                      totalTimeOrdersCard: totalTimeOrders[index],
                      dateOrdersCard: dateOrders[index],
                      priceOrdersCard: priceOrders[index],
                    );
                  })
                )
              ],
            ),
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
