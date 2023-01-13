
import 'package:flutter/material.dart';
import 'package:project_mcc_lec/homepage.dart';
import 'package:project_mcc_lec/loginpage.dart';
import 'package:project_mcc_lec/registerpage.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => Register());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text(
                          'Tidak ada route yang ditemukan untuk ${settings.name}')),
                ));
    }
  }
}