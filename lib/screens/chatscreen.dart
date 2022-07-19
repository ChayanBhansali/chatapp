import 'package:cc_chat_app/services/chatservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class chat extends StatefulWidget {
  final String? chattername ;
  final String? chatroomid;
  const chat({Key? key, required this.chattername,required this.chatroomid}) : super(key: key);

  @override
  _chatState createState() => _chatState();
}

class _chatState extends State<chat> {
  Chat chat = Chat();
  String? username = 'username' ;
  String? othermail;
  String? ownmail = FirebaseAuth.instance.currentUser?.email;
  TextEditingController message = TextEditingController();

  // geting()async{
  //
  //     username = await chat.usernamereturn(widget.uid);
  //     othermail = await chat.emailreturn(widget.uid);
  //
  //
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // geting();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
      return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                  width: width,
                  color: Colors.grey[800],
                  child: Center(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20,
                      ),
                      title: Text(widget.chattername.toString(),style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                      trailing: IconButton(onPressed: () {
                        Navigator.pop(context);
                      }, icon: Icon(Icons.arrow_back_ios),),
                    ),
                  )
              ),
            ),
            Flexible(
              flex: 8,
              fit: FlexFit.tight,
              child: Container(
                width: width,
                color: Colors.grey,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                            .collection('dms')
                            .doc(widget.chatroomid.toString())
                            .collection('CHATS')
                            .orderBy("time", descending: false)
                            .snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                              child: Text('send a message'),
                            ),
                          ),
                        );
                      }
                      final data = snapshot.data?.docs;
                      return ListView.builder(
                          itemCount: data?.length,
                          itemBuilder: (context , index){
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text( data![index]['sendBy'],style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold
                                    ),),
                                    SizedBox(height: 5,),
                                    Text(data![index]['message'],style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold
                                    ),),

                                    // for time display widget

                                    // SizedBox(height: 5,),
                                    // Text(data![index]['message'],style: TextStyle(
                                    //   color: Colors.grey,
                                    //   fontSize: 12,
                                    //   // fontWeight: FontWeight.bold
                                    // ),),

                                  ],
                                )
                              ),
                            );
                          });
              }),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                width: width,
                color: Colors.grey[800],
                child: Row(
                  children:  [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "message",
                          hintStyle: const TextStyle(
                              fontSize: 20
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),



                        ),
                        controller: message,
                      ),
                    ),
                    IconButton(onPressed: ()async{
                              var time = DateTime.now();
                              String? user = await chat.usernamereturn(FirebaseAuth.instance.currentUser?.uid);
                              chat.message(widget.chatroomid, message.text, user, time.toString());
                              message.clear();
                    }, icon: Icon(Icons.send))
                  ],
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}
