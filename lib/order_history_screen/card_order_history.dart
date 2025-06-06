import 'package:flutter/material.dart';

class CardOrderHistory extends StatelessWidget {
  final String nameOrdersCard;
  final String totalTimeOrdersCard;
  final String dateOrdersCard;
  final double priceOrdersCard;

  const CardOrderHistory({
    super.key,
    required this.nameOrdersCard,
    required this.totalTimeOrdersCard,
    required this.dateOrdersCard,
    required this.priceOrdersCard
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 75,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(83, 158, 158, 158),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.book, size: 30),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$nameOrdersCard ($totalTimeOrdersCard hr)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                
                    const SizedBox(height: 5),
                
                    Row(
                      children: [
                        Text(dateOrdersCard),
                
                        Spacer(),
                
                        Text('\$ $priceOrdersCard')
                      ],
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
