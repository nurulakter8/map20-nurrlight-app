import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nurrlight/controller/authmethods_controller.dart';
import 'package:nurrlight/controller/constants.dart';
import 'package:nurrlight/model/feedphotos.dart';
import 'package:nurrlight/screens/about_screen.dart';
import 'package:nurrlight/screens/add_screen.dart';
import 'package:nurrlight/screens/moreinfo_screen.dart';
import 'package:nurrlight/screens/search_screen.dart';
import 'package:nurrlight/screens/signin_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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
  //User user1 = new User();
  FirebaseUser user;
  List<FeedPhotos> feedPhotos;
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      //what button is pressed?
      if (selectedIndex == 0) {
        //adding
        messages();
      }
      if (selectedIndex == 1) {
        //adding
        addPic();
      }
      if (selectedIndex == 2) {
        //adding
        browser();
      }
    });
  }

  void messages() async {
    Navigator.pushNamed(context, SearchScreen.routeName);
  }

  void addPic() async {
    Navigator.pushNamed(context, AddScreen.routeName,
        arguments: {'users': user, 'feedPhotoList': feedPhotos});
    render(() {});
  }

  void browser() async {
    const url = 'https://www.pinterest.com/lisacravensstyle/canvas-ideas/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    Map arg = ModalRoute.of(context).settings.arguments;
    user ??= arg['users'];
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
            color: Colors.brown[200],
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
                  color: Colors.brown[300],
                ),
                ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  title: Text('Email'),
                  onTap: con.email,
                ),
                ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  title: Text('About'),
                  onTap: () {Navigator.pushNamed(
                        context, AboutScreen.routeName);}, // sprint 2
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
        bottomNavigationBar: new BottomNavigationBar(
          selectedItemColor: Color.fromRGBO(221, 90, 46, 1.0),
          unselectedItemColor: Color.fromRGBO(13, 138, 137, 1.0),
          items: [
            new BottomNavigationBarItem(
              icon: new Icon(Icons.message),
              title: new Text('Messages'),
            ),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.add_a_photo),
                title: new Text('addPicture')),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.web), title: new Text('browser')),
          ],
          //include logic for color changing depending on index
          currentIndex: selectedIndex,
          onTap: onItemTapped,
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
                      child: Card(
                        margin: EdgeInsets.all(20),
                        color: Colors.white,
                        elevation: 20.0,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.all(10)),
                        //),
                        child: InkWell(
                          onTap: () {
                            con.moreInfo(index);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      child: Image.network(
                                        feedPhotos[index].photoURL,
                                        width: 300.0,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.brown[300],
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      child: Text(
                                        "${feedPhotos[index].createdBy.substring(0, 1).toUpperCase()}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(43, 8, 0, 0),
                                    child: Text(
                                      feedPhotos[index].createdBy,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(320, 8, 0, 0),
                                    child: Text('\$ ${feedPhotos[index].price}',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        )),
                                  ),
                                ],
                              ),
                              Stack(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                        ' ${feedPhotos[index].createdBy.toLowerCase()}',
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.brown,
                                        )),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                                    child: Text('${feedPhotos[index].caption}',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        )),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(5, 23, 0, 0),
                                    child: Text(
                                      (() {
                                        if ((DateTime.now()
                                                .difference(
                                                    feedPhotos[index].updatedAt)
                                                .inDays) >
                                            1) {
                                          return '${(DateTime.now().difference(feedPhotos[index].updatedAt).inDays)} days ago';
                                        }
                                        if ((DateTime.now()
                                                .difference(
                                                    feedPhotos[index].updatedAt)
                                                .inHours) >
                                            1) {
                                          return '${(DateTime.now().difference(feedPhotos[index].updatedAt).inHours)} hours ago';
                                        }
                                        if ((DateTime.now()
                                                .difference(
                                                    feedPhotos[index].updatedAt)
                                                .inMinutes) >
                                            1) {
                                          return '${(DateTime.now().difference(feedPhotos[index].updatedAt).inMinutes)} minutes ago';
                                        }
                                        if ((DateTime.now()
                                                .difference(
                                                    feedPhotos[index].updatedAt)
                                                .inSeconds) >
                                            1) {
                                          return '${(DateTime.now().difference(feedPhotos[index].updatedAt).inSeconds)} seconds ago';
                                        }
                                      }()),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15)
                            ],
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
        arguments: {'users': _state.user, 'feedPhotoList': _state.feedPhotos});

    _state.render(() {}); // redraw the screen
  }

  void moreInfo(int index) async {
    Navigator.pushNamed(_state.context, MoreInfoScreen.routeName,
        arguments: {'users': _state.user, 'feedPhotoList': _state.feedPhotos});
    _state.render(() {});
  }

  void email() async {
    const url = 'https://accounts.google.com/signin/v2/identifier?continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&service=mail&sacu=1&rip=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
