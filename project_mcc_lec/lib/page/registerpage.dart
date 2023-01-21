

import 'package:flutter/material.dart';
import 'package:project_mcc_lec/class/db_helper.dart';
import 'package:project_mcc_lec/class/route.dart';
import 'package:project_mcc_lec/class/user.dart';
import 'package:project_mcc_lec/page/loginpage.dart';
import 'package:sqflite/sqflite.dart';

/*
[v] database + API sqflite
*/

class Register extends StatelessWidget {
  Register({super.key});

  DBHelper dbHelper = DBHelper();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // late User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text('Create New Account'),
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                "CREATE NEW ACCOUNT",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(
                height: 70,
              ),
              TextFormField(
                maxLength: 25,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: "Input your Username",
                    labelText: "Username"),
                controller: usernameController,
              ),
              SeparatorSizedBoxRegisterPage(),
              TextFormField(
                maxLength: 50,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: "Input your email",
                    labelText: "Email"),
                controller: emailController,
              ),
              SeparatorSizedBoxRegisterPage(),
              TextFormField(
                maxLength: 50,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: "Input your password",
                    labelText: "Password"),
                controller: passwordController,
              ),
              SeparatorSizedBoxRegisterPage(),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: "Input your password again",
                    labelText: "Password Confirmation"),
                controller: confirmPasswordController,
              ),
              
              SizedBox( // spacing
                height: 44,
              ),
      
              ElevatedButton( // register button
                onPressed: () async {
                  // List<User> users = await dbHelper.getUser();
                  // detail validasinya di paling bawah
                  if(validasi(usernameController, emailController, passwordController,
                  confirmPasswordController, context)){
                    // user = User(usernameController.text, emailController.text, passwordController.text);
                    //buat cek kalo kesimpen di variabelnya
                    // print(user.username + " " + user.email + " " + user.password);

                    await dbHelper.addUser(
                      User(
                        id: await dbHelper.getAmountUser(), 
                        username: usernameController.text, 
                        email: emailController.text, 
                        password: passwordController.text,
                        profileImage: 'assets/Logo/profile_default.jpg' 
                      )
                    );

                    Navigator.push(context, RouterGenerator.generateRoute(
                      RouteSettings(
                        name: '/',
                      )
                    ));
                  }

                }, 
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)
                  ),
                  minimumSize: Size(110, 50)
                ), 
              ),
      
              SizedBox( // spacing
                height: 44,
              ),
      
              Row( // ke login
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: TextStyle(fontSize: 16),),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, RouterGenerator.generateRoute(
                          RouteSettings(
                            name: '/'
                          )
                        )
                      );
                    }, 
                    child: Text(
                      'Login Now',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }
}


class SeparatorSizedBoxRegisterPage extends StatelessWidget {
  const SeparatorSizedBoxRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
    );
  }
}


// buat validasinya
bool validasi(TextEditingController usernameController, TextEditingController emailController, TextEditingController passwordController, TextEditingController confirmPasswordController, context){

  String pattern = r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
  RegExp regex = RegExp(pattern);

  if(usernameController.text.isEmpty||emailController.text.isEmpty||
  passwordController.text.isEmpty||confirmPasswordController.text.isEmpty){
    const snackBar = SnackBar(
      content: DefaultSnackBar(title: "All fields must be filled!"),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return false;
  }
    
  else if(usernameController.text.length<4){
    const snackBar = SnackBar(
      content: DefaultSnackBar(title: "Username must be at least 4 characters long"),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return false;
  }
  
  else if(!regex.hasMatch(passwordController.text)){
    const snackBar = SnackBar(
      content: DefaultSnackBar(title: "Password must contains at least 1 upper, lower, and number character"),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return false;
  }
                  
  else if(confirmPasswordController.text!=passwordController.text){
    const snackBar = SnackBar(
      content: DefaultSnackBar(title: "The field Confirm Password is not the same as Password"),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return false;
  }

  return true;            

}