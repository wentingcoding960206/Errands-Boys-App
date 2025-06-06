import 'package:flutter/material.dart';

class SlowPageScrollPhysics extends PageScrollPhysics {
  const SlowPageScrollPhysics({super.parent});

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 100,      // Increased mass makes it heavier/slower
        stiffness: 400, // Reduced stiffness makes it more fluid
        damping: 1,    // Reduced damping makes it smoother
      );

  @override
  SlowPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SlowPageScrollPhysics(parent: buildParent(ancestor));
  }
}

class PopularServicesCard extends StatelessWidget {
  final PageController pageController;
  final Function(int) onPageChanged;

  const PopularServicesCard({
    super.key,
    required this.pageController,
    required this.onPageChanged,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: PageView.builder(
        controller: pageController,
        onPageChanged: onPageChanged,
        itemCount: 6, // Match with numberOfDots
        physics: const PageScrollPhysics(),
        pageSnapping: true,
        allowImplicitScrolling: false,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                'Popular Services Card ${index + 1}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          );
        },
      ),
    );
  }
}
