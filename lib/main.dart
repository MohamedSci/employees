
import 'package:company_employees0/screens/employee_screen.dart';
import 'package:company_employees0/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notifier/auth_notifier.dart';
import 'notifier/employee_notifier.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthNotifier(),),
        ChangeNotifierProvider(create: (context) => EmployeeNotifier(),)
                ],
      child: const MyApp(),
                  ),
        );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
     FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const RefreshProgressIndicator();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MediaQuery(
              data: const MediaQueryData(),
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Zaghlol',
                  theme: ThemeData(
                      primaryColor:  Colors.green,
                      colorScheme: ColorScheme.fromSwatch()
                          .copyWith(secondary: Colors.white)),
                  home: Consumer<AuthNotifier>(
                    builder: (context, notifier, child) {
                      return notifier.user != null ?  EmployeeScreen() :  EmployeeScreen();
                    },
                  ),));
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const SizedBox();
      },
     );
  }
}
