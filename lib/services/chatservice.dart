import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chat {
Future<String>dmgenerator ( String? ownuid , String? otheruid) async{
  String? ownmail = await emailreturn(ownuid);
  String? othermail = await emailreturn(otheruid);
  String? ownname = await usernamereturn(ownuid);
  String? othername = await usernamereturn(otheruid);
  try {
    await FirebaseFirestore.instance
        .collection('dms')
        .doc('${ownmail}_$othermail')
        .set({
      'chatroomid': '${ownmail}_$othermail',
      'users': [ownname, othername]
    });

    await setRoomId(ownuid!,'${ownmail}_$othermail' );
    await setRoomId(otheruid!, '${ownmail}_$othermail');
    return '${ownmail}_$othermail';
  }catch(e){
    return e.toString();
  }

}
Future<String?>usernamereturn(String? uid) async{
  var data ;
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get().then((DocumentSnapshot doc) {
        data = doc.data() as Map;
        return data['userName'];
    }
    );
  }catch(e){
    return e.toString();
  }
  return data['userName'];
  }

Future<String?>emailreturn(String? uid) async{
  var data;
  try {
   await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get().then((DocumentSnapshot doc) {
       data = doc.data() as Map;

    });
  }catch(e){
    return e.toString();
  }
  return data['userEmail'];
}

Future<String> message(String? chatroomid, String message , String? sendby , String time) async{
  var data;
  try {
    await FirebaseFirestore.instance
                           .collection('dms')
                           .doc(chatroomid)
                           .collection('CHATS')
                           .add({
                              'message' : message,
                              'sendBy' : sendby,
                              'time' : time,
                                   } );

return 'success';

  }catch(e){
    return e.toString();
  }
}




setRoomId(String uid , String roomId)async{
  List list = [roomId];
  try{
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'rooms': FieldValue.arrayUnion(list)});
  }catch(e){
    return e.toString();
  }
}
}