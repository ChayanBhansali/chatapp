import 'package:cc_chat_app/screens/chatscreen.dart';
import 'package:cc_chat_app/screens/searchscreen.dart';
import 'package:cc_chat_app/services/chatservice.dart';
import 'package:cc_chat_app/widget/grpmodal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

String? usermail = FirebaseAuth.instance.currentUser?.email;
String? ownuid = FirebaseAuth.instance.currentUser?.uid;
Chat chatt = Chat();
String? ownName =FirebaseAuth.instance.currentUser?.displayName;
String otherchater = '';
 getOwnName() async {
  ownName = await chatt.usernamereturn(ownuid);

}


String otheruser(String? ownUserName,List users){
  for (int i =0 ; i<2 ; i++){
    if(users[i] != ownUserName){
      return users[i];
    }
  }
  return '';
}
@override
void initState() {
    // TODO: implement initState
    super.initState();
    // getOwnName();
print(ownName);
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
          ),
          Expanded(

              child:StreamBuilder<QuerySnapshot>(

                  stream: FirebaseFirestore.instance
                      .collection('dms')
                      .where('users' , arrayContains:  ownName.toString())
                      .snapshots(),
                  builder: (context, snapshot) {
                          if(!snapshot.hasData){
                            return Text('wow do empty!');
                          }
                          final data = snapshot.data?.docs;
                          return ListView.builder(
                              itemCount: data?.length,
                              itemBuilder: (context,index) {
                                otherchater = otheruser(ownName, data![index]['users']) ;
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=> chat(chattername: otherchater, chatroomid: data[index]['chatroomid'])));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(otherchater),
                                    ],
                                  ),

                                ),
                              ),
                            );
                          });
              }
              )


          ),
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
