import 'package:flutter/material.dart';

class DateTimePicker extends StatelessWidget {
  final TextEditingController dateController;
  //final TextEditingController timeController;

  const DateTimePicker({
    super.key,
    required this.dateController,
    //required this.timeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Date Picker
        InkWell(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
            }
          },
          child: IgnorePointer(
            child: TextFormField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Date'),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // // Time Picker
        // InkWell(
        //   onTap: () async {
        //     final TimeOfDay? pickedTime = await showTimePicker(
        //       context: context,
        //       initialTime: TimeOfDay.now(),
        //     );
        //     if (pickedTime != null) {
        //       timeController.text = pickedTime.format(context);
        //     }
        //   },
        //   child: IgnorePointer(
        //     child: TextFormField(
        //       controller: timeController,
        //       decoration: const InputDecoration(labelText: 'Preferred Time'),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
