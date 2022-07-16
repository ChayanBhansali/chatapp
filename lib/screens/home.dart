import 'package:cc_chat_app/screens/searchscreen.dart';
import 'package:cc_chat_app/widget/grpmodal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../const.dart';
import '../services/authentication.dart';
import '../services/firestore.dart';
class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {


  @override
void initState() {
    // TODO: implement initState
    super.initState();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
        actions: [
          IconButton(onPressed: ()async{
           await Auth(auth: FirebaseAuth.instance).signout();
            print('signout worked');
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)

                  ),
                  hintText: "search",
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),

              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => searchScreen()));
              },
              autofocus: false,

            ),
          )
        ],
      ),
       floatingActionButton: FloatingActionButton(onPressed: () {
           showModalBottomSheet(context: context, builder: (context) =>grpui(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          )

             );
       },
       child: Icon(Icons.group_add),
         foregroundColor: Colors.grey[500],
         backgroundColor: Colors.grey[900],
       ),

    );
  }
}
