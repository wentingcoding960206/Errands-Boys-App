import 'package:flutter/material.dart';

class ListReservedRequested extends StatelessWidget {
  final String serviceTime;
  final String serviceName;
  final String serviceProvider;
  const ListReservedRequested({
    super.key,
    required this.serviceName,
    required this.serviceTime,
    required this.serviceProvider
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              color: const Color.fromARGB(54, 158, 158, 158),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            serviceName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Spacer(),

                          Text(
                            serviceProvider,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Text(serviceTime)],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
