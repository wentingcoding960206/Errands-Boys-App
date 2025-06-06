import 'package:flutter/material.dart';

class CategoriesCard extends StatelessWidget {
  final String titleCategories;
  final String discriptionCategories;
  final IconData iconCategories;
  final double distanceIconText;
  final double distanceIconBorder;
  final Color colorCategories;
  final void Function()? onTap;


  const CategoriesCard({
    super.key,
    required this.titleCategories,
    required this.discriptionCategories,
    required this.iconCategories,
    required this.distanceIconText,
    required this.distanceIconBorder,
    required this.colorCategories,
    required this.onTap,
  });


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.zero,
        backgroundColor: colorCategories,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: colorCategories,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: distanceIconBorder),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconCategories,
                size: 40
              ),
              SizedBox(width: distanceIconText),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titleCategories,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
          
                  discriptionCategories.isNotEmpty 
                    ? Text(discriptionCategories)
                    : SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}