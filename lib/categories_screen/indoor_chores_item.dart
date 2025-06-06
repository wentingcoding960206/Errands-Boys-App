import 'package:flutter/material.dart';

class IndoorChoresItem extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final void Function()? onTap;

  const IndoorChoresItem({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    required this.onTap
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(61, 158, 158, 158),
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),

                  Spacer(),

                  Text(
                    price,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 7),

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Aligns text to the top
                children: [
                  Expanded(
                    // Ensures text takes available space and pushes button to the right
                    child: Container(
                      height: 70,
                      alignment:
                          Alignment.centerLeft, // Aligns text to the left
                      child: Text(
                        description,
                        softWrap: true, // Ensures text wraps properly
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10), // Adds space between text and button

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(75,75,), 
                      fixedSize: Size(75,75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.zero
                    ),
                    onPressed: onTap,
                    child: FittedBox(
                      child: Text(
                        'Check \nPrice \nList',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
