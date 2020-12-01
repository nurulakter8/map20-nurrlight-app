import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nurrlight/controller/authmethods_controller.dart';
import 'package:nurrlight/model/feedphotos.dart';

class MoreInfoScreen extends StatefulWidget {
  static const routeName = '/addScreen/moreInfoScreen';

  @override
  State<StatefulWidget> createState() {
    return _MoreInfoState();
  }
}

class _MoreInfoState extends State<MoreInfoScreen> {
  _Controller con;
  AuthMethodsController authMethodsController = new AuthMethodsController();
  TextEditingController emailEditingController = new TextEditingController();

  //User user = new User();
  File image; // variable to upload images
  var formkey = GlobalKey<FormState>();
  FirebaseUser user;
  List<FeedPhotos> feedPhotos;
  //FeedPhotos feedPhotos;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    user ??= args['users'];
    feedPhotos ??= args['feedPhotoList'];

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/barLogo.png",
          height: 50,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.brown[300]),
      ),
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: <Widget>[
              Center(
                child: Image.network(
                  feedPhotos[index].photoURL,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 500, 0, 20),
                    child: Text(
                      'Author: ${feedPhotos[index].createdBy}',
                      style: TextStyle(
                        fontSize: 25.0, color: Colors.brown[300]
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: feedPhotos.length,

        autoplay: false,
        //duration: 300,
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Stack( // using stack to have multiple container, one for the image and the other one for the button
      //         children: <Widget>[
      //           Container(
      //             width: MediaQuery.of(context)
      //                 .size
      //                 .width, // uses full width image size
      //             child:
      //                // Image.network(photoMemo.photoURL), // picks the image url
      //                Image.network(feedPhotos.photoURL),
      //           ),
      //         ],
      //       ),

      //       Text(
      //         'Created By: ${feedPhotos.createdBy}',
      //         style: TextStyle(fontSize: 16), // display notes memo
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class _Controller {
  _MoreInfoState _state;
  _Controller(this._state);
}
