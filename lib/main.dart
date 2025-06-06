
import 'package:errands_boys/auth_gate.dart';
import 'package:errands_boys/categories_screen/categories_screen.dart';
import 'package:errands_boys/chat/chat_page.dart';
import 'package:errands_boys/chat/chat_screen.dart';
import 'package:errands_boys/reserved_requested_screen/reserved_screen.dart';
import 'package:errands_boys/test_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


// void main() {
//   runApp(const MyApp());
// }
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Optional if you use Firebase CLI configuration
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromARGB(135, 158, 158, 158),
          )
        ),
        home: AuthGate()
        //home: ChatScreen()
        
      );
  }
}
