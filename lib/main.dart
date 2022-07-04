import 'package:cc_chat_app/screens/home.dart';
import 'package:cc_chat_app/screens/loginscreen.dart';
import 'package:cc_chat_app/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

    brightness: Brightness.dark,
        primaryColor: Colors.indigo
      ),
      home: StreamBuilder(
        stream: Auth(auth:FirebaseAuth.instance).user,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.hasData){
            return const homeScreen();
          }else {
            return loginScreen();
          }
        },

      )
    );
  }
}

