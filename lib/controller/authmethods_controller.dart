import 'package:firebase_auth/firebase_auth.dart';
import 'package:nurrlight/model/user.dart';

class AuthMethodsController{

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  
  static User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(UserID: user.uid) : null;
  }
  
  static Future signInWithEmailAndPassword (String email, String password) async{

    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print (e.toString());
    }
  }

  Future signUpWithEmailAndPassword (String email, String password) async {

    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);

    } catch (e) {
      print (e.toString());
    }
  }

  Future signOut () async{
    try {
      return await _auth.signOut();
    } catch (e) {
      print (e.toString());
    }
  }



}