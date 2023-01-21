// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_mcc_lec/class/db_helper.dart';
import 'package:project_mcc_lec/class/route.dart';
import 'package:project_mcc_lec/class/user.dart';
// import 'package:project_mcc_lec/page/temppage.dart';


/*
[v] validasi (login) & API -- username + password
[v] API Google Sign in
*/


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  DBHelper dbHelper = DBHelper();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text('Login'),
      // ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
          // crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
      
              SizedBox(
                height: 150,
              ),
      
              Container( // logo
                height: 100,
                // child: SvgPicture.asset('assets/logo/Logo HE FISH (2).svg'),
                // child: Image(image: AssetImage('assets/Logo/Logo_HE_FISH.png', package: 'assets/Logo')),
                child: Image.asset('assets/Logo/Logo.png'),
              ),
      
              SizedBox( // spacing
                height: 80,
              ),
      
              TextFormField( // username
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: "Input your Username",
                    labelText: "Username"
                ),
                controller: usernameController,
              ),
      
              SizedBox( // spacing
                height: 24,
              ),
      
              TextFormField( // password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  hintText: "Input your password",
                  labelText: "Password",
                  // suffixIcon: Icon(Icons.remove_red_eye_rounded)
                ),
                obscureText: true,
                controller: passwordController,
              ),
      
              SizedBox( // spacing
                height: 44,
              ),
      
              ElevatedButton( // login button
                onPressed: () async{
                  // masukin validasi
                  if(validasi(usernameController, passwordController, context)){
                    List<User> users = await dbHelper.getUser();
                    bool found = false;

                    if(users.isNotEmpty){
                      for(int i = 0; i<users.length; i++){
                        if(usernameController.text == users[i].username && passwordController.text == users[i].password){
                          accessSuccessSnackbar(context);
                          Navigator.push(context, RouterGenerator.generateRoute(
                              RouteSettings(
                                name: '/home',
                              )
                            )
                          );
                          found = true;
                          break;
                        }
                      }
                      if(found == false) accessDeniedSnackbar(context);
                    }else{
                      accessDeniedSnackbar(context);
                    }
                  }
                }, 
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)
                  ),
                  minimumSize: Size(100, 50)
                ), 
              ),
      
              SizedBox( // spacing
                height: 24,
              ),
      
              Text('or'), // text 'or'
      
              SizedBox( // spacing
                height: 24,
              ),
              
              ElevatedButton( // google login button
                onPressed: () {
                  // masukin validasi
                  Navigator.push(context, RouterGenerator.generateRoute(
                      RouteSettings(
                        name: '/',
                      )
                    )
                  );
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => TempPage()));
                }, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/Logo/logo_Google.png'),
                    Text(
                      "Login with Google",
                      style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  primary: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)
                  ),
                  minimumSize: Size(100, 50),
                  maximumSize: Size(220, 70)
                ), 
              ),
      
              SizedBox( // spacing
                height: 44,
              ),
      
              Row( // ke register
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: TextStyle(fontSize: 16),),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, RouterGenerator.generateRoute(
                          RouteSettings(
                            name: '/register'
                          )
                        )
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => TempPage()));
                    }, 
                    child: Text(
                      'Register Now',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}


bool validasi(TextEditingController usernameController, TextEditingController passwordController, context){

  if(usernameController.text.isEmpty||passwordController.text.isEmpty){
    const snackBar = SnackBar(
      content: DefaultSnackBar(title: "All fields must be filled!"),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return false;
  }

  return true;            
}


void accessDeniedSnackbar(context){
  const snackbar = SnackBar(
    content: DefaultSnackBar(title: "Username or Password is wrong"), 
    duration: Duration(seconds: 1),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}


void accessSuccessSnackbar(context){
  const snackbar = SnackBar(
    content: DefaultSnackBar(title: "Login Success"),
    duration: Duration(seconds: 1),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

class DefaultSnackBar extends StatelessWidget {
  const DefaultSnackBar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
        title, 
        style: TextStyle(color: Colors.deepOrange)
    );
  }
}
