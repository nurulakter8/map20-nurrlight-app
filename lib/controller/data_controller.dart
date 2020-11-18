import 'package:cloud_firestore/cloud_firestore.dart';

class DataController {
  getUserByUsername(String username) async{
   return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  uploadUserInfo(userMap) {
    // collection of map
    Firestore.instance.collection("users").add(userMap);
  }
}
