import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   context.read<DBHelper>().getUser();
  // }

  @override
  Widget build(BuildContext context) {
    // final users = Provider.of<DBHelper>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: dbHelper.getUser(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
            if(!snapshot.hasData){
              return Center(child: Text("Loading..."),);
            }
            return snapshot.data!.isEmpty ?
            Center(child: Text("No User Found"),)
            : ListView(
              children: snapshot.data!.map((e) {
                return Center(
                  child: ListTile(
                    title: Text(e.username),
                  ),
                );
              }).toList(),
            );
          }
        )
      ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       Consumer<DBHelper>(builder: (BuildContext context, value, child) => 

      //       ))
      //       // Text(users[0].id.toString()),
      //       // Text(users[0].username),
      //       // Text(users[0].email)
      //     ]
      //   ),
      // ),
    );
  }
}