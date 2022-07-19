

import 'dart:async';
import 'dart:async';

import 'package:cc_chat_app/const.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth auth;
  Auth({required this.auth});

  Stream<User?> get user => auth.authStateChanges();

  Future<String?> createAccount(String email, String password , String username) async{
    try{

      await auth.createUserWithEmailAndPassword(email: email, password: password);
      await  FirebaseAuth.instance.currentUser?.updateDisplayName(username);
      print("create clicked");
      return "Account created";
    } on FirebaseAuthException catch(e){
      return e.message;
    } catch(e){
      return e.toString();
    }
  }

Future<String?> signin(String email ,String password ) async{
    try{
      auth.signInWithEmailAndPassword(email: email, password: password);


      return "sign in complete";
    }on FirebaseException catch(e){
      return e.message;
    } catch(e){
      return e.toString();
    }
}

Future<String?> signout() async{
    try {
      await auth.signOut();
      return "sign out successful";
    }on FirebaseException catch(e){
      return e.message;
    }
}



}