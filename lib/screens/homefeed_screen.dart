import 'package:flutter/material.dart';
import 'package:nurrlight/controller/authmethods_controller.dart';
import 'package:nurrlight/model/feedphotos.dart';
import 'package:nurrlight/model/user.dart';
import 'package:nurrlight/screens/search_screen.dart';
import 'package:nurrlight/screens/signin_screen.dart';
import 'package:nurrlight/screens/views/imageframe_view.dart';

class HomeFeedScreen extends StatefulWidget {
  static const routeName = '/signInScreen/homeScreen';

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeFeedScreen> {
  _Controller con;
  AuthMethodsController authMethodsController = new AuthMethodsController();
  User user = new User();
  List<FeedPhotos> feedPhotos;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    Map arg = ModalRoute.of(context).settings.arguments;
    feedPhotos ??= arg['feedPhotoList'];

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
            onTap: () {
              authMethodsController.signOut();
              Navigator.pushReplacementNamed(context, SignInScreen.routeName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.brown[300],
          child: ListView(
            children: <Widget>[
              Container(
                child: DrawerHeader(
                    child: Center(
                        child: Text(
                  'User Id: ${user.UserID}',
                  textAlign: TextAlign.center,
                ))),
                color: Colors.grey[400],
              ),
              ListTile(
                leading: Icon(
                  Icons.message,
                  color: Colors.white,
                ),
                title: Text('Messages'),
                onTap: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                title: Text('About'),
                onTap: () {}, // sprint 2
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                title: Text('Sign out'),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, SignInScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
      body: //Center(child: Text("Welcome!! Number of docs ${feedPhotos.length}",style: TextStyle(fontSize: 40),),),
          feedPhotos.length == 0
              ? Text('No Photos', style: TextStyle(fontSize: 30.0))
              : ListView.builder(
                  itemCount: feedPhotos.length,
                  itemBuilder: (BuildContext context, int index) => Container(
                    // wrapping with container for color on listtile
                    color: con.delIndex != null && con.delIndex == index
                        ? Colors.red[200]
                        : Colors
                            .white, // on long press it will turn red to delete
                    // child: ListTile(
                    //   //leading: Image.network(photoMemos[index].photoURL),
                    //   leading: MyImageView.network(
                    //       imageUrl: feedPhotos[index].photoURL,
                    //       context:
                    //           context), // progress indicator based on how big is each image.
                    //   //trailing: Icon(Icons.keyboard_arrow_right),
                    //   title: Text(feedPhotos[index].caption),
                    //   subtitle: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: <Widget>[
                    //       Text('Created by: ${feedPhotos[index].createdBy}'),
                    //       Text('Updated at: ${feedPhotos[index].updatedAt}'),
                    //       Text("Price: ${feedPhotos[index].price} dollars"),
                    //     ],
                    //   ),
                    //   onTap: (){} ,// on tap funtion, part of listtile. goes to detailed page
                    // onLongPress: () {} // on long press we will permently delete the index
                    // ),
                    child: Card(
                      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                      color: Colors.white,
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.network(feedPhotos[index].photoURL,
                                  width: 300.0),
                              SizedBox(
                                width: 15.0,
                              ),
                            ],
                          ),
                          Text('Caption: ${feedPhotos[index].caption}',
                              style: TextStyle(
                                fontSize: 25.0,
                              )),
                          Text('Author: ${feedPhotos[index].createdBy}',
                              style: TextStyle(
                                fontSize: 25.0,
                              )),
                          Text('Price: ${feedPhotos[index].price}',
                              style: TextStyle(
                                fontSize: 25.0,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}

class _Controller {
  _HomeState _state;
  _Controller(this._state);
  int delIndex;
}
