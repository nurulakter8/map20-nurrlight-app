import 'package:flutter/material.dart';
import 'package:nurrlight/controller/authmethods_controller.dart';
import 'package:nurrlight/model/user.dart';
import 'package:nurrlight/screens/homefeed_screen.dart';
import 'package:nurrlight/screens/signin_screen.dart';

class UserSearchScreen extends StatefulWidget {
  static const routeName = '/searchScreen/userSearchScreen';

  @override
  State<StatefulWidget> createState() {
    return _UserSearchState();
  }
}

class _UserSearchState extends State<UserSearchScreen> {
  _Controller con;
  AuthMethodsController authMethodsController = new AuthMethodsController();
  User user = new User();

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
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
                  Icons.pages,
                  color: Colors.white,
                ),
                title: Text('Feed'),
                onTap: () {
                  Navigator.pushNamed(context, HomeFeedScreen.routeName);
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
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.brown[300],
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16 ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search Username...",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  Image.asset("assets/images.searchLogo.png"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Controller {
  _UserSearchState _state;
  _Controller(this._state);
}
