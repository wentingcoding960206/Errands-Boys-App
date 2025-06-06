import 'package:errands_boys/bottom_nav_bar.dart';
import 'package:errands_boys/categories_screen/acade_items.dart';
import 'package:errands_boys/categories_screen/aes_items.dart';
import 'package:errands_boys/categories_screen/indoor_chores_item.dart';
import 'package:errands_boys/categories_screen/outdoor_chores_item.dart';
import 'package:errands_boys/price_screen/price_screen.dart';
import 'package:errands_boys/screen_manager.dart';
import 'package:flutter/material.dart';
import 'package:errands_boys/categories_screen/table.dart';

class CategoriesScreen extends StatefulWidget {
  final String title;

  const CategoriesScreen({super.key, required this.title});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreen();
}

class _CategoriesScreen extends State<CategoriesScreen> {
  final int _selectedIndex = 0;
  // Declare a global key to control the state of ScreenManager

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

  void tutoringAppli(BuildContext context) {
    print('tutorialAppli');
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => PriceScreen(
              title: "Tutoring",
              additionalCharge: "N/A",
              price: 15,
              firebaseCollection: 'tutoring_request',
              table: tutoringTable
            ),
      ),
    );
  }

  void snowShoveling(BuildContext context) {
    print('snowShoveling');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => PriceScreen(
              title: "Snow Shoveling",
              price: 17,
              additionalCharge: "\$ 15",
              firebaseCollection: 'snow_shoveling_request',
              table: snowShovelingTable
            ),
      ),
    );
  }

  void babySitting(BuildContext context) {
    print('babySitting');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => PriceScreen(
              title: "Babysitting",
              price: 15,
              additionalCharge: "N/A",
              firebaseCollection: "baby_sitting_request",
              table: babySittingTable,
            ),
      ),
    );
  }

  void dogWalkingSitting(BuildContext context) {
    print('dogWalkingSitting');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => PriceScreen(
              title: "Dog Walking / Sitting",
              price: 15,
              additionalCharge: "N/A",
              firebaseCollection: "dog_walking_sitting_request",
              table: petWalkingSitting,
            ),
      ),
    );
  }

  void groceryShopping(BuildContext context) {
    print('groceryShopping');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: 
          (context) => PriceScreen(
            title: "Grocery Shopping", 
            price: 18, 
            additionalCharge: "N/A", 
            firebaseCollection: 'grocery_helping_request',
            table: groceryShoppingTable
          )
      )
    );
  }

  void lawnMowing(BuildContext context) {
    print('lawnMowing');
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: 
          (context) => PriceScreen(
            title: "Lawn Mowing", 
            price: 20, 
            additionalCharge: "N/A", 
            firebaseCollection: 'lawn_mowing_request',
            table: lawnMowingTable,
          )
      )
    );
  }

  void carWashing(BuildContext context) {
    print('carWashing');
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: 
          (context) => PriceScreen(
            title: "Car Washing", 
            price: 16, 
            additionalCharge: "N/A", 
            firebaseCollection: 'car_washing_request',
            table: carWashingTable
          )
      )
    );
  }

  void houseCleaning(BuildContext context) {
    print('houseCleaning');
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: 
          (context) => PriceScreen(
            title: "House Cleaning", 
            price: 18, 
            additionalCharge: "N/A", 
            firebaseCollection: 'house_cleaning_request',
            table: houseCleaningTable,
          )
      )
    );
  }

  void furnitureAssembly(BuildContext context) {
    print('furnitureAssembly');
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: 
          (context) => PriceScreen(
            title: "Furniture Assembly", 
            price: 16, 
            additionalCharge: "N/A", 
            firebaseCollection: 'furniture_assembly_request',
            table: furnitureAssemblyTable,
          )
      )
    );
  }

  void holidayHelp(BuildContext context) {
    print('holidayHelp');
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: 
          (context) => PriceScreen(
            title: "Holiday Help", 
            price: 15, 
            additionalCharge: "N/A", 
            firebaseCollection: 'holiday_help_request',
            table: holidayHelpTable
          )
      )
    );
  }

  void painting(BuildContext context) {
    print('painting');
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: 
          (context) => PriceScreen(
            title: "painting", 
            price: 18, 
            additionalCharge: "N/A", 
            firebaseCollection: 'painting_request',
            table: paintingTable,
          )
      )
    );
  }

  void packingMoving(BuildContext context) {
    print('packingMoving');
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: 
          (context) => PriceScreen(
            title: "Packing & Moving", 
            price: 16, 
            additionalCharge: "N/A", 
            firebaseCollection: 'packing_moving_request',
            table: packingMovingTable
          )
      )
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Widget itemsWidget;

    if (widget.title == 'Academics') {
      itemsWidget = AcadeItems(
        title: "1 - 1 Tutoring",
        price: 'Starting at \$15 / hr',
        description:
            'Subjects include math, science, English, or any preferred subject of your choice.\n'
            '• Flexible scheduling\n'
            '• Experienced teen tutors with a 90% avg.',
        onTap: () => tutoringAppli(context),
      );
    } else if (widget.title == 'Aesthetics') {
      itemsWidget = Column(
        children: [
          AesItems(
            title: "Painting",
            price: 'Starting at \$18',
            description:
                '• Reliable and detail-oriented service\n'
                '• Affordable rates with no hidden fees\n'
                '• Hardworking and customer-focused',
            onTap: () => painting(context),
          ),

          SizedBox(height: 20),

          AesItems(
            title: "Holiday Help",
            price: 'Starting at \$15',
            description:
                '• Reliable and detail-oriented service\n'
                '• Affordable rates with no hidden fees\n'
                '• Hardworking and customer-focused',
            onTap: () => holidayHelp(context),
          ),
        ],
      );
    } else if (widget.title == 'Outdoor Chores') {
      itemsWidget = Column(
        children: [
          OutdoorChoresItem(
            title: "Snow Shoveling",
            price: 'Starting at \$17',
            description:
                'Perfect for winter weather needs.\n'
                '• Available during winter months\n'
                '• Quick response time\n'
                '• Satisfaction guaranteed',
            onTap: () => snowShoveling(context),
          ),

          SizedBox(height: 20),

          OutdoorChoresItem(
            title: "Dog Walking / Sitting",
            price: 'Starting at \$17',
            description:
                'Reliable care for your furry friends.\n'
                '• Flexible scheduling\n'
                '• Pet first-aid trained\n'
                '• Satisfaction guaranteed',
            onTap: () => dogWalkingSitting(context),
          ),

          SizedBox(height: 20),

          OutdoorChoresItem(
            title: "Grocery Shopping",
            price: 'Starting at \$18',
            description:
                'We take care of your grocery shopping for you!\n'
                '• Flexible scheduling\n'
                '• Quick turnaround time\n'
                '• Affordable rates',
            onTap: () => groceryShopping(context),
          ),
          
          SizedBox(height: 20),

          OutdoorChoresItem(
            title: "Lawn Mowing",
            price: 'Starting at \$20',
            description:
                'Keep your lawn fresh and well-maintained.\n'
                '• Available year-round\n'
                '• Quick and efficient service\n'
                '• Fully insured and reliable',
            onTap: () => lawnMowing(context),
          ),

          SizedBox(height: 20),

          OutdoorChoresItem(
            title: "Car Washing",
            price: 'Starting at \$16',
            description:
                '• Reliable and detail-oriented service\n'
                '• Affordable rates with no hidden fees\n'
                '• Hardworking and customer-focused',
            onTap: () => carWashing(context),
          ),
        ],
      );
    } else if (widget.title == 'Indoor Chores') {
      itemsWidget = Column(
        children: [
          IndoorChoresItem(
            title: 'Babysitting',
            price: 'Starting at \$15',
            description:
                'Safe and reliable childcare.\n'
                '• CPR certified babysitters\n'
                '• Flexible hours on weekends and holidays\n'
                '• Satisfaction guaranteed',
            onTap: () => babySitting(context),
          ),

          SizedBox(height: 20),

          IndoorChoresItem(
            title: 'House Cleaning',
            price: 'Starting at \$18',
            description:
                '• Reliable and detail-oriented service\n'
                '• Affordable rates with no hidden fees\n'
                '• Hardworking and customer-focused',
            onTap: () => houseCleaning(context),
          ),

          SizedBox(height: 20),

          IndoorChoresItem(
            title: 'Furniture Assembly',
            price: 'Starting at \$18',
            description:
                '• Reliable and detail-oriented service\n'
                '• Affordable rates with no hidden fees\n'
                '• Hardworking and customer-focused',
            onTap: () => furnitureAssembly(context),
          ),

          SizedBox(height: 20),

          IndoorChoresItem(
            title: 'Packing & Moving',
            price: 'Starting at \$18',
            description:
                '• Reliable and detail-oriented service\n'
                '• Affordable rates with no hidden fees\n'
                '• Hardworking and customer-focused',
            onTap: () => packingMoving(context),
          ),
        ],
      );
    } else {
      itemsWidget = SizedBox.shrink();
    }

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
          child: Column(children: [itemsWidget]),
        ),
      ),

      bottomNavigationBar: BottomNavBar(
        navBarOnTap: _onItemTapped,
        navBarSelectedIndex: _selectedIndex,
      ),
    );
  }
}
