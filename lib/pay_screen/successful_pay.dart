import 'package:flutter/material.dart';


class SuccessfulPay extends StatelessWidget {
  const SuccessfulPay({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Icon(
              Icons.check_circle,
              size: 250,
              color: const Color.fromARGB(255, 11, 243, 77)
            ),

            const SizedBox(height: 35),

            Text(
              'Payment\n'
              'Successful',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              )
            ),

            Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black
              ),
              onPressed: () {
                print('Payment Successful Button Pressed');
              }, 
              child: SizedBox(
                width: 250,
                height: 50,
                child: Center(
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25
                    )
                  ),
                )          
              )
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
