import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nurrlight/controller/authmethods_controller.dart';
import 'package:nurrlight/controller/constants.dart';
import 'package:nurrlight/controller/data_controller.dart';
import 'package:nurrlight/model/user.dart';
import 'package:nurrlight/screens/signin_screen.dart';

import 'chatroom_screen.dart';

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
  DataController dataController = new DataController();
  QuerySnapshot searchSnapShot;

  TextEditingController searchEditingController = new TextEditingController();

  // chatroom to send user
  createChatRoomToStartConvo({ String userName,  }) {
    if (userName != Constants.myName){ // can't send message myself
      String chatRoomId = getChatRoomId(userName, Constants.myName);

    List<String> users = [userName, Constants.myName];
    Map<String, dynamic> chatroomMap = {
      "users": users,
      "chatroomId": chatRoomId,
    };
    DataController().createChatRoom(chatRoomId, chatroomMap);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatroomScreen(),
        ));
    }else{
      print("Can't send message to same user");
    }
  }

  Widget SearchTile({String userName,
   String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(fontSize: 20, color: Colors.brown[300]),
              ),
              Text(
                userEmail,
                style: TextStyle(fontSize: 20, color: Colors.brown[300]),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomToStartConvo( userName: userName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.brown[300],
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 14),
              child: Text(
                "Chat",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  void initState() {
    super.initState();

    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  Widget searchList() {
    return searchSnapShot != null
        ? ListView.builder(
            itemCount: searchSnapShot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                userName: searchSnapShot.documents[index].data["name"],
                userEmail: searchSnapShot.documents[index].data["email"],
              );
            })
        : Container(
            // child: Text(
            //   "No Search Result",
            //   style: TextStyle(color: Colors.brown),
            // ),
            );
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
        child: Column(
          children: [
            Container(
              color: Colors.brown[300],
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchEditingController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "Search Username...",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: con.userInfo,
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(8),
                      child: Image.asset(
                        "assets/images/searchLogo.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

class _Controller {
  _UserSearchState _state;
  _Controller(this._state);

  void userInfo() {
    initiateSearch();
  }

  void initiateSearch() {
    _state.dataController
        .getUserByUsername(_state.searchEditingController.text)
        .then((value) {
      _state.render(() {
        _state.searchSnapShot = value;
      });
    });
  }
}
