
import 'package:flutter/material.dart';
import 'package:project_mcc_lec/page/homepage.dart';
import 'package:project_mcc_lec/page/loginpage.dart';
import 'package:project_mcc_lec/page/registerpage.dart';

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