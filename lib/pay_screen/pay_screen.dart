import 'package:errands_boys/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreen();
}

class _PayScreen extends State<PayScreen> {
  int _selectedIndex = 0;
  int? _selectedOption = 1;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('Bottom Nav Bar Icon $index pressed');
    });
  }

  void _handleSelectedOption(int ? value) {
    setState(() {
      _selectedOption = value;
    });
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70,),
              Center(
                child: Text(
                  '\$ 15',
                  style: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
          
              Center(
                child: Text(
                  'Tutoring: Math',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
        
              const SizedBox(height: 10),
          
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                  ),
          
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Pay With",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
          
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                  ),
          
                ],
              ),
          
              const SizedBox(height: 10),
          
              Text(
                'How would you like to pay ?',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                )
              ),
              const SizedBox(height: 10,),
        
              ListTile(
                leading: Radio<int>(
                  value: 1,
                  groupValue: _selectedOption,
                  onChanged: _handleSelectedOption,
                ),
                title: Text('Credit or Debit Card')
              ),
        
              ListTile(
                leading: Radio<int>(
                  value: 2,
                  groupValue: _selectedOption,
                  onChanged: _handleSelectedOption,
                ),
                title: Text('Bank')
              ),
        
        
              const SizedBox(height: 10),
              
              Divider(
                color: Colors.black,
                thickness: 2,
              )
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
