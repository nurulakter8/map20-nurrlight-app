import 'package:flutter/material.dart';
import 'package:nurrlight/controller/authmethods_controller.dart';
import 'package:nurrlight/controller/constants.dart';
import 'package:nurrlight/controller/helper_controller.dart';
import 'package:nurrlight/model/user.dart';
import 'package:nurrlight/screens/signin_screen.dart';
import 'package:nurrlight/screens/usersearch_screen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/homeScreen/searchScreen';

  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<SearchScreen> {
  _Controller con;
  AuthMethodsController authMethodsController = new AuthMethodsController();
  User user = new User();

  @override
  void initState() {
    getUserInfo();
    super.initState();
    con = _Controller(this);
  }

  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(320, 490, 10, 10),
        child: FloatingActionButton(
          onPressed: ()=> Navigator.pushNamed(context, UserSearchScreen.routeName),
          child: Icon(Icons.search),
          backgroundColor: Colors.brown[300],
          
        ),
      ),

    );
  }
}

class _Controller {
  _SearchState _state;
  _Controller(this._state);
}
