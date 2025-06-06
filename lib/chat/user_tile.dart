import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Timestamp? time;
  final String? message;

  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
    required this.time,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    String formattedTime = time != null
        ? TimeOfDay.fromDateTime(time!.toDate()).format(context)
        : '';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(12)
        ),

        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.person),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  Text(text),
                  const SizedBox(height: 10),
                  Text(
                    message ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: const Color.fromARGB(255, 78, 78, 78)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),

            Text(formattedTime),
          ],
        )
      )
    );
  }
}