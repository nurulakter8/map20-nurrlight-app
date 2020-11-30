import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nurrlight/controller/authmethods_controller.dart';
import 'package:nurrlight/controller/constants.dart';
import 'package:nurrlight/model/feedphotos.dart';
import 'package:nurrlight/model/user.dart';
import 'package:nurrlight/screens/add_screen.dart';
import 'package:nurrlight/screens/moreinfo_screen.dart';
import 'package:nurrlight/screens/search_screen.dart';
import 'package:nurrlight/screens/signin_screen.dart';

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
  User user1 = new User();
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
    Map arg = ModalRoute.of(context).settings.arguments;
    user1 ??= arg['user'];
    feedPhotos ??= arg['feedPhotoList'];

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
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
                    " User: ${Constants.myName}", 
                    textAlign: TextAlign.center, 
                    style: TextStyle(fontSize: 25),
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
        floatingActionButton: FloatingActionButton(
          onPressed: con.addButton,
          child: Icon(Icons.add),
          foregroundColor: Colors.white,
          backgroundColor: Colors.brown[300],
        ),
        body: //Center(child: Text("Welcome!! Number of docs ${feedPhotos.length}",style: TextStyle(fontSize: 40),),),
            feedPhotos.length == 0
                ? Center(
                    child: Text('No Posts', style: TextStyle(fontSize: 30.0)))
                : ListView.builder(
                    itemCount: feedPhotos.length,
                    itemBuilder: (BuildContext context, int index) => Container(
                      // wrapping with container for color on listtile
                      color: con.delIndex != null && con.delIndex == index
                          ? Colors.red[200]
                          : Colors
                              .white, // on long press it will turn red to delete
                      child: GestureDetector(
                        onTap: () => SearchScreen.routeName,
                        child: Card(
                          margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                          color: Colors.white,
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: InkWell(
                            onTap: con.moreInfo,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                                Center(
                                  child: Text(
                                      'Caption: ${feedPhotos[index].caption}',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                      )),
                                ),
                                Center(
                                  child: Text(
                                      'Author: ${feedPhotos[index].createdBy}',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                      )),
                                ),
                                Center(
                                  child:
                                      Text('Price: ${feedPhotos[index].price}',
                                          style: TextStyle(
                                            fontSize: 25.0,
                                          )),
                                ),
                              ],
                            ),
                          ),
                        ),
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
  int index = 0;

  void addButton() async {
    await Navigator.pushNamed(_state.context, AddScreen.routeName,
        arguments: {'user': _state.user, 'feedPhotoList': _state.feedPhotos});

    _state.render(() {}); // redraw the screen
  }

  void moreInfo() async {
    Navigator.pushNamed(_state.context, MoreInfoScreen.routeName,
        arguments: {'user': _state.user, 'feedPhotoList': _state.feedPhotos});
    _state.render(() {});
  }
}
