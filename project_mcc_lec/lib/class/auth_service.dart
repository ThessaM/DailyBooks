// MASIH ERROR

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // static Future signInAnunymous() async {
  //   try {
  //     AuthResult result = _auth.signInAnonymously();
  //     FirebaseUser firebaseUser = result.user;
  //   } catch (e) {
  //     return firebaseUser;

  //     return null;
  //   }
  // }
}
