import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nurrlight/controller/authmethods_controller.dart';
import 'package:nurrlight/controller/data_controller.dart';
import 'package:nurrlight/model/feedphotos.dart';
import 'package:nurrlight/model/user.dart';

class AddScreen extends StatefulWidget {
  static const routeName = '/homeScreen/addScreen';

  @override
  State<StatefulWidget> createState() {
    return _AddState();
  }
}

class _AddState extends State<AddScreen> {
  _Controller con;
  AuthMethodsController authMethodsController = new AuthMethodsController();
    TextEditingController emailEditingController = new TextEditingController();

    //User user = new User();
  File image; // variable to upload images
  var formkey = GlobalKey<FormState>();  
  FirebaseUser user;
  List<FeedPhotos> feedPhotos;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    user ??= args['user'];
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
        actions: [
          GestureDetector(
            onTap: con.save,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                  child: Text(
                'Post your Item!',
                style: TextStyle(fontSize: 36, color: Colors.brown[300]),
              )),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  fillColor: Colors.brown[100],
                  filled: true,
                  focusColor: Colors.brown[100],
                ),
                autocorrect: true,
                validator: con.validatorUser,
                onSaved: con.onSavedUser,
                controller: emailEditingController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Price',
                  fillColor: Colors.brown[100],
                  filled: true,
                  focusColor: Colors.brown[100],
                ),
                autocorrect: true,
                validator: con.validatorPrice,
                onSaved: con.onSavedPrice,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Caption',
                  fillColor: Colors.brown[100],
                  filled: true,
                  focusColor: Colors.brown[100],
                ),
                autocorrect: true,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                validator: con.validatorCaption,
                onSaved: con.onSavedCaption,
              ),
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context)
                        .size
                        .width, // utilize full width screeen
                    child: image == null
                        ? Icon(
                            Icons.camera,
                            size: 300,
                          )
                        : Image.file(image, fit: BoxFit.fill),
                  ),
                  Positioned(
                    right: 0.0,
                    bottom: 0.0,
                    child: Container(
                      color: Colors.brown[200],
                      child: PopupMenuButton<String>(
                        onSelected: con.getPicture,
                        itemBuilder: (context) => <PopupMenuEntry<String>>[
                          PopupMenuItem(
                            value: 'camera',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.photo_camera),
                                Text('camera'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'gallery',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.photo_album),
                                Text('Gallery'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _AddState _state;
  _Controller(this._state);
  String caption;
  String price;
  String email;

  void save() async {
    if (!_state.formkey.currentState.validate()) {
      return;
    }
    _state.formkey.currentState.save();
    Map<String, String> photoInfo = await DataController.uploadStorage(
      image: _state.image,
      uid: 'abcds',
    );

    var p = FeedPhotos(
        caption: caption,
        price: price,
        photoPath: photoInfo['path'],
        photoURL: photoInfo['url'],
        createdBy: _state.emailEditingController.text,
        updatedAt: DateTime.now(),
      );

      p.docId = await DataController.addPhotoMemo(p);
      _state.feedPhotos.insert(0, p); // adds to first position
      Navigator.pop(_state.context);

    // print('==========: ${photoInfo["path"]}');
    // print('==========: ${photoInfo["url"]}');
  }

  void getPicture(String src) async {
    try {
      PickedFile _imageFile;
      if (src == 'camera') {
        _imageFile = await ImagePicker().getImage(source: ImageSource.camera);
      } else {
        _imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
      }
      _state.render(() {
        _state.image = File(_imageFile.path);
      });
    } catch (e) {}
  }

  String validatorCaption(String value) {
    if (value == null || value.trim().length < 2) {
      return 'min 2 chars';
    } else {
      return null;
    }
  }

  void onSavedCaption(String value) {
    this.caption = value;
  }

  String validatorPrice(String value) {
    if (value == null || value.trim().length < 1) {
      return 'min 1 number';
    } else {
      return null;
    }
  }

  void onSavedPrice(String value) {
    this.price = value;
  }

  String validatorUser(String value) {
    return null;
  }

  void onSavedUser(String value) {}
}
