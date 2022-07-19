import 'package:cc_chat_app/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import"package:flutter/material.dart";

import '../const.dart';
import '../services/authentication.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            

            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)

                  ),
                  hintText: "Enter your email",
                  hintStyle: TextStyle(
                    fontSize: 20
                  )
                ),
                controller: emailController,
              ),
            ),


            // username field
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)

                    ),
                    hintText: "Enter your username",
                    hintStyle: TextStyle(
                        fontSize: 20
                    )
                ),
                controller: usernameController,
              ),
            ),


            Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)

                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(
                        fontSize: 20
                    )
                ),
                controller: passwordController,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[700]
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.08,
                child: MaterialButton(
                  onPressed: () async{
                    print('$emailController');
                    Auth auth = new Auth( auth: FirebaseAuth.instance);
                   String? msg =   await auth.signin(emailController.text, passwordController.text,) ;
                    final snackBar = SnackBar(
                      content:  Text(msg!),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text('Sign In',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[700]
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.08,
                child: MaterialButton(
                  onPressed: () async{
                    print('$emailController');
                    Auth auth = new Auth( auth: FirebaseAuth.instance);
                    String? msg = await auth.createAccount(emailController.text, passwordController.text,usernameController.text);
                    Store store = new Store(auth: FirebaseAuth.instance, username: usernameController.text);
                    String? jk = await store.addUserToFirestore();
                    print(jk);
                    final snackBar = SnackBar(
                      content:  Text(msg!),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  },
                  child: Text('Create Account',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),

           
          ],
        ),
      ),
    );
  }
}
