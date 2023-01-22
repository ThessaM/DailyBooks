
import 'package:flutter/material.dart';
import 'package:project_mcc_lec/page/historypage.dart';
import 'package:project_mcc_lec/page/homepage.dart';
import 'package:project_mcc_lec/page/loginpage.dart';
import 'package:project_mcc_lec/page/paymentpage.dart';
import 'package:project_mcc_lec/page/registerpage.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        // return MaterialPageRoute(builder: (_) => LoginPage());
        return MaterialPageRoute(builder: (_) => HomePage(currentUserId: 1));
      case '/register':
        return MaterialPageRoute(builder: (_) => Register());
      // case '/home':
      //   return MaterialPageRoute(builder: (_) => HomePage());
      // case '/payment':
      //   return MaterialPageRoute(builder: (_) => PaymentPage());
      // case '/history/${userId}':
      //   int userId;
      //   return MaterialPageRoute(builder: (_) => HistoryPage(currentUserId: userId));
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