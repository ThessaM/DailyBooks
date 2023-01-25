// import 'package:flutter/widgets.dart';
// import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:project_mcc_lec/class/cartprovider.dart';
import 'package:project_mcc_lec/class/route.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: Builder(
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  // primarySwatch: Colors.blue,
                  // primarySwatch: Colors.deepOrange,
                  // canvasColor: Color.fromARGB(255, 41, 41, 41),
                  // canvasColor: Color(0xff121212),
                  colorScheme: ColorScheme.dark(
                      primary: Colors.deepOrange,
                      onPrimary: Colors.white,
                      secondary: Colors.deepOrange,
                      onSecondary: Colors.white,
                      surface: Colors.deepOrange)),
              // home: const Register(),
              onGenerateRoute: RouterGenerator.generateRoute,
              // initialRoute: , --> ini buat inisialisasi page pertama
            );
          },
        ));
  }
}





// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // home: const Register(),
//       onGenerateRoute: RouterGenerator.generateRoute,
//       // initialRoute: , --> ini buat inisialisasi page pertama
//     );
//   }
// }