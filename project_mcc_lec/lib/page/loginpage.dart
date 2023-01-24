// import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_mcc_lec/class/auth_service.dart';
import 'package:project_mcc_lec/class/route.dart';

/*
[] validasi (login) & API 
*/

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // Future<FirebaseApp> _initializeFirebase() async {
  //   FirebaseApp firebaseApp = await Firebase.initializeApp();
  //   return firebaseApp;
  // }

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
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                ),

                Container(
                  // logo
                  height: 100,
                  // child: SvgPicture.asset('assets/logo/Logo HE FISH (2).svg'),
                  // child: Image(image: AssetImage('assets/Logo/Logo_HE_FISH.png', package: 'assets/Logo')),
                  child: Image.asset('assets/Logo/Logo.png'),
                ),

                SizedBox(
                  // spacing
                  height: 80,
                ),

                TextFormField(
                  // username
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Input your Username",
                      labelText: "Username"),
                ),

                SizedBox(
                  // spacing
                  height: 24,
                ),

                TextFormField(
                  // password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: "Input your password",
                    labelText: "Password",
                    // suffixIcon: Icon(Icons.remove_red_eye_rounded)
                  ),
                  obscureText: true,
                ),

                SizedBox(
                  // spacing
                  height: 44,
                ),

                ElevatedButton(
                  // login button
                  onPressed: () async {
                    // masukin validasi
                    // Navigator.push(context, RouterGenerator.generateRoute(
                    //     RouteSettings(
                    //       name: '/home',
                    //     )
                    // )
                    // );
                    // AuthService.signInAnunymous();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      minimumSize: Size(100, 50)),
                ),

                SizedBox(
                  // spacing
                  height: 24,
                ),

                Text('or'), // text 'or'

                SizedBox(
                  // spacing
                  height: 24,
                ),

                ElevatedButton(
                  // google login button
                  onPressed: () {
                    // masukin validasi
                    Navigator.push(
                        context,
                        RouterGenerator.generateRoute(RouteSettings(
                          name: '/',
                        )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/Logo/logo_Google.png'),
                      Text("Login with Google",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      primary: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      minimumSize: Size(100, 50),
                      maximumSize: Size(220, 70)),
                ),

                SizedBox(
                  // spacing
                  height: 44,
                ),

                Row(
                  // ke register
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            RouterGenerator.generateRoute(
                                RouteSettings(name: '/register')));
                      },
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
