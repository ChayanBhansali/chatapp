

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Store {
  final FirebaseAuth auth ;
  final String username;
  Store({required this.auth, required this.username});
  User? get user => auth.currentUser;
  String? get uid => user?.uid;

  Future<String> addUserToFirestore() async{
    try{
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({
        'userEmail' : user?.email,
        'userName'  : username,
      });
      print('stored successfully');
      return "user added to firebase";
    }catch(e){
      return e.toString();
    }
  }


}