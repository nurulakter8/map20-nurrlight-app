import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
        .where(FeedPhotos.CREATED_BY)
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

  static Future<Map<String, String>> uploadStorage({
    @required File image,
    String filePath,
    @required String uid,
    //@required Function listner,
  }) async {
    filePath ??= '${FeedPhotos.IMAGE_FOLDER}/$uid/${DateTime.now()}';
    StorageUploadTask task =
        FirebaseStorage.instance.ref().child(filePath).putFile(image);

    // task.events.listen((event) {
    //   double percentage = (event.snapshot.bytesTransferred.toDouble() /
    //           event.snapshot.totalByteCount.toDouble()) *
    //       100;
    //   listner(percentage);
    // });
    var download = await task.onComplete;
    String url = await download.ref.getDownloadURL();
    print('+++++++++ URL: $url');
    return {'url': url, 'path': filePath};
  }

    static Future<String> addPhotoMemo(FeedPhotos feedPhotos) async {
    feedPhotos.updatedAt = DateTime.now();
    DocumentReference ref = await Firestore.instance
        .collection(FeedPhotos.COLLECTION)
        .add(feedPhotos.serialized());
    return ref.documentID;
  }

}
