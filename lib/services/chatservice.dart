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
}