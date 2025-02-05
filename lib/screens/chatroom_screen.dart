import 'package:flutter/material.dart';
import 'package:nurrlight/controller/authmethods_controller.dart';
import 'package:nurrlight/controller/constants.dart';
import 'package:nurrlight/controller/data_controller.dart';
import 'package:nurrlight/model/user.dart';
import 'package:nurrlight/screens/signin_screen.dart';

class ChatroomScreen extends StatefulWidget {
  static const routeName = '/userSearchScreen/chatroomScreen';
  final String chatRoomId;
  ChatroomScreen(this.chatRoomId);

  @override
  State<StatefulWidget> createState() {
    return _ChatState();
  }
}

class _ChatState extends State<ChatroomScreen> {
  _Controller con;
  AuthMethodsController authMethodsController = new AuthMethodsController();
  TextEditingController messageController = new TextEditingController();
  DataController dataController = new DataController();
  Stream chatmessageStream;

  User user = new User();

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatmessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      snapshot.data.documents[index].data["message"],
                      snapshot.data.documents[index].data["sendBy"] == Constants.myName);
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    dataController.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatmessageStream = value;
      });
    });
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
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                color: Colors.brown[200],
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      //controller: messageEditingController,
                      //style: simpleTextStyle(),
                      decoration: InputDecoration(
                        hintText: "Message ...",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                      controller: messageController,
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: con.sendMessage,
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36FFFFFF),
                                    const Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight),
                              borderRadius: BorderRadius.circular(40)),
                          padding: EdgeInsets.all(12),
                          child: Image.asset(
                            "assets/images/send.png",
                            height: 25,
                            width: 25,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: isSendByMe ? 0 : 24,
          right: isSendByMe ? 24 : 0),
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: isSendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: isSendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
        topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
          bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: isSendByMe ? [
                Colors.brown[300],
                Colors.brown[300]
              ]: [
                Colors.grey,
                Colors.grey
              ],
            )
        ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'OverpassRegular',
            fontWeight: FontWeight.w300)),
      ),
    );
  }
}

class _Controller {
  _ChatState _state;
  _Controller(this._state);

  void sendMessage() {
    if (_state.messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": _state.messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      _state.dataController
          .addConversationMessages(_state.widget.chatRoomId, messageMap);
      _state.messageController.text = "";
    }
  }
}
