import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_mcc_lec/class/cart_model.dart';
import 'package:project_mcc_lec/class/cartprovider.dart';
import 'package:project_mcc_lec/class/db_helper.dart';
import 'package:project_mcc_lec/class/user.dart';
import 'package:provider/provider.dart';


//buat ngecek data register udh masuk ke database

class TempPage extends StatefulWidget {
  const TempPage({Key? key}) : super(key: key);

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {

  
  DBHelper dbHelper = DBHelper();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder<List<Cart>>(
          future: dbHelper.getCartList(),
          builder: (BuildContext context, AsyncSnapshot<List<Cart>> snapshot){
            if(!snapshot.hasData){
              return Center(child: Text("Loading..."),);
            }
            return snapshot.data!.isEmpty ?
            Center(child: Text("No User Found"),)
            : ListView(
              children: snapshot.data!.map((e) {
                return Center(
                  child: ListTile(
                    title: Text(e.bookTitle!),
                    subtitle: Text(e.quantity!.value.toString()),
                  ),
                );
              }).toList(),
            );
          }
        )
      ),
    );
  }
}