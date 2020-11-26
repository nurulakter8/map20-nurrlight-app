import 'package:flutter/material.dart';
import 'package:nurrlight/controller/authmethods_controller.dart';
import 'package:nurrlight/model/user.dart';
import 'package:nurrlight/screens/homefeed_screen.dart';
import 'package:nurrlight/screens/signin_screen.dart';
import 'package:nurrlight/screens/usersearch_screen.dart';

class ChatroomScreen extends StatefulWidget {
  static const routeName = '/userSearchScreen/chatroomScreen';

  @override
  State<StatefulWidget> createState() {
    return _ChatState();
  }
}

class _ChatState extends State<ChatroomScreen> {
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
      body: Container(
        alignment: Alignment.center,
        child: Text("Let's Chat!! ", style: TextStyle(color: Colors.brown[300], fontSize: 70),),
      )

    );
  }
}

class _Controller {
  _ChatState _state;
  _Controller(this._state);
}
