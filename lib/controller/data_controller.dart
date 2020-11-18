import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nurrlight/model/feedphotos.dart';

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


    static Future<List<FeedPhotos>> getPhotoMemos(String email) async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(FeedPhotos.COLLECTION)
        .where(FeedPhotos.CREATED_BY, isEqualTo: email)
        .orderBy(FeedPhotos.UPDATED_AT, descending: true)
        .getDocuments(); // this way we read all the documents from fire base

    var result =
        <FeedPhotos>[]; // get from fire store and include in list of obj
    if (querySnapshot != null && querySnapshot.documents.length != 0) {
      for (var doc in querySnapshot.documents) {
        result.add(FeedPhotos.deserialize(doc.data, doc.documentID));
      }
    }
    return result;
  }

}
