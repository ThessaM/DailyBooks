
import 'package:flutter/material.dart';
import 'package:project_mcc_lec/class/animate_back.dart';
import 'package:project_mcc_lec/class/db_helper.dart';
import 'package:project_mcc_lec/class/route.dart';
import 'package:project_mcc_lec/class/user.dart';
import 'package:project_mcc_lec/page/homepage.dart';


/*
[v] validasi (login) & API -- username + password
[] API Google Sign in
*/


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 850,
              child: AnimatedBackgroundCustom()
            ),
            Column(
              children: [
                SizedBox(height: 40,),
                LoginPageCard(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LoginPageCard extends StatefulWidget {
  const LoginPageCard({Key? key}) : super(key: key);

  @override
  State<LoginPageCard> createState() => _LoginPageCardState();
}

class _LoginPageCardState extends State<LoginPageCard> {

  DBHelper dbHelper = DBHelper();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: 
        Container(
          height: 530,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 65, 65, 65),
            borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
          // crossAxisAlignment: CrossAxisAlignment.center, 
            children: [  
              // SizedBox(
              //   height: 10,
              // ), 
                                
              Container( // logo
                height: 80,
                child: Image.asset('assets/Logo/Logo.png'),
              ),

              SizedBox( // spacing
                height: 10,
              ),

              Text(
                "DailyBooks",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),

              SizedBox( // spacing
                height: 40,
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
                  suffixIcon: IconButton(
                    icon: Icon(!_isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ), 
                ),
                obscureText: _isObscure,
                controller: passwordController, 
              ),
  
              SizedBox( // spacing
                height: 10,
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
              ),
        
              SizedBox( // spacing
                height: 30,
              ),
        
              ElevatedButton( // login button
                onPressed: () async{
                  // masukin validasi
                  if(validasi(usernameController, passwordController, context)){
                    List<User> users = await dbHelper.getUser();
                    bool foundUsername = false;
                    bool found = false;
  
                    if(users.isNotEmpty){
                      for(int i = 0; i<users.length; i++){
                        if(usernameController.text == users[i].username && passwordController.text == users[i].password){
                          accessSuccessSnackbar(context);
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => HomePage(currentUserId: users[i].id))
                          );
                          found = true;
                          foundUsername = true;
                          break;
                        }else if(usernameController.text == users[i].username){
                          foundUsername = true;
                        }
                      }
                      if(foundUsername == false) userNotFoundSnackbar(context);
                      else if (found == false && foundUsername == true) accessDeniedSnackbar(context);
                    }else{
                      userNotFoundSnackbar(context);
                    }
                    // if(found == false) accessDeniedSnackbar(context);
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
        
              // SizedBox( // spacing
              //   height: 24,
              // ),           
              // Text('or'), // text 'or'           
              // SizedBox( // spacing
              //   height: 24,
              // ),      
              // ElevatedButton( // google login button
              //   onPressed: () {
              //     // masukin validasi
              //     Navigator.push(context, RouterGenerator.generateRoute(
              //         RouteSettings(
              //           name: '/',
              //         )
              //       )
              //     );
              //     // Navigator.push(context, MaterialPageRoute(builder: (context) => TempPage()));
              //   }, 
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       Image.asset('assets/Logo/logo_Google.png'),
              //       Text(
              //         "Login with Google",
              //         style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)
              //       ),
              //     ],
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     alignment: Alignment.center,
              //     primary: Colors.white,
              //     elevation: 3,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(32)
              //     ),
              //     minimumSize: Size(100, 50),
              //     maximumSize: Size(220, 70)
              //   ), 
              // ),
                        
              // SizedBox( // spacing
              //   height: 20,
              // ),
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

void userNotFoundSnackbar(context){
  const snackbar = SnackBar(
    content: DefaultSnackBar(title: "User Not Found"),
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
