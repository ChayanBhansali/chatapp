import 'package:cc_chat_app/screens/chatscreen.dart';
import 'package:cc_chat_app/services/chatservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({Key? key}) : super(key: key);

  @override
  _searchScreenState createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  late Stream<QuerySnapshot> userStream = FirebaseFirestore.instance
                                                    .collection('users')
                                                    .snapshots();
  late String username;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                autofocus: true,
                onChanged: (value){
                      setState(() {
                        userStream = FirebaseFirestore.instance
                                .collection('users')
                        .where('userName' , isGreaterThanOrEqualTo: value) 
                        .where('userName' , isLessThan: value +'z')
                        .snapshots();
                      });
                }

              ),
            ),
            Expanded(child: StreamBuilder<QuerySnapshot>(
                stream: userStream ,
                builder: (context , snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator(),);
                  final doc = snapshot.data?.docs;
                  return ListView.builder(
                      itemCount: doc?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(backgroundColor: Colors.grey,),
                            title: GestureDetector(
                              onTap: () async{
                               Chat chatt = new Chat();
                             String? userid = FirebaseAuth.instance.currentUser?.uid;
                             String tt = await chatt.dmgenerator(userid, doc[index].id);


                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> chat(uid: doc[index].id, chatroomid: tt,)));


                                // print(doc[index]['userName']);
                                print(doc[index].id);
                              },
                              child: Text(doc![index]['userName']),
                            ),
                              // trailing: IconButton( onPressed: () {  }, icon: const Icon(Icons.add),),
                            ),
                          ),
                        );
                      });
                }
                )
            )
          ],
        ),
      ),
    );
  }
}



