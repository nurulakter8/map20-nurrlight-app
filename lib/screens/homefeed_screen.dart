import 'package:flutter/material.dart';
import 'package:nurrlight/controller/authmethods_controller.dart';
import 'package:nurrlight/model/feedphotos.dart';
import 'package:nurrlight/model/user.dart';
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
      body: Center(child: Text("Welcome!! Number of docs ${feedPhotos.length}",style: TextStyle(fontSize: 40),),),
    );
  }
}

class _Controller {
  _HomeState _state;
  _Controller(this._state);
}
