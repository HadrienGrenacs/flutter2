import 'package:cloud_firestore/cloud_firestore.dart';

class UserHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future getUser(id) {
    return _db
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        return documentSnapshot;
      } else {
        print('Document does not exist on the database');
      }
    }).catchError((error) => print("Failed to get user: $error"));
  }

  //   static Future updateUser(id, ) {
  //   return _db
  //       .collection('users')
  //       .doc(id)
  //       .update({'status': status})
  //       .then((value) => print("task Updated"))
  //       .catchError((error) => print("Failed to update user: $error"));
  // }
}
