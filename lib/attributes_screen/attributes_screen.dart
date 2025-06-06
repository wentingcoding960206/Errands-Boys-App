import 'package:flutter/material.dart';
import 'package:errands_boys/bottom_nav_bar.dart';

class AttributesScreen extends StatefulWidget {
  const AttributesScreen({super.key});

  @override
  State<AttributesScreen> createState() => _AttributesScreen();
}

class _AttributesScreen extends State<AttributesScreen> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('Bottom Nav Bar Icon $index pressed');
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'About us & Attributes',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold
          ),
        )
      ),
           
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'At Errand Boys, our mission is to create a reliable platform that connects teenagers with local job opportunities. We believe in empowering youth, fostering community support, and ensuring safety and trust in every interaction.'
              ),

              const SizedBox(height: 10,),

              Text(
                'Our goal is to provide young individuals with valuable work experience while helping community members find dependable assistance for everyday tasks. By bridging the gap between those who need help and those eager to work, we promote responsibility, financial independence, and strong neighborhood connections.'
              ),

              const SizedBox(height: 10),

              Text(
                'With a focus on convenience and security, we strive to build a seamless and trustworthy experience for both job seekers and service requesters. Whether it\'s lawn mowing, snow shoveling, or running errands, Errand Boys is committed to making local job opportunities accessible, efficient, and rewarding for everyone involved.'
              )
            ],
          ),
        )
      ),
      
      bottomNavigationBar: BottomNavBar(
        navBarOnTap: _onItemTapped,
        navBarSelectedIndex: _selectedIndex,
      ),
    );
  }
}
