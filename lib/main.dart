import 'package:flutter/material.dart';
import 'package:nurrlight/screens/about_screen.dart';
import 'package:nurrlight/screens/add_screen.dart';
import 'package:nurrlight/screens/forgotpassword_screen.dart';
import 'package:nurrlight/screens/homefeed_screen.dart';
import 'package:nurrlight/screens/moreinfo_screen.dart';
import 'package:nurrlight/screens/search_screen.dart';
import 'package:nurrlight/screens/signin_screen.dart';
import 'package:nurrlight/screens/signup_screen.dart';
import 'package:nurrlight/screens/usersearch_screen.dart';

void main() {
  runApp(NurrLightApp());
}

class NurrLightApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        textTheme: TextTheme(
          headline5: TextStyle(fontSize: 72 ),   //heading
          headline6: TextStyle(fontSize: 23 ),  //title
          subtitle2: TextStyle(fontSize: 13 , fontWeight: FontWeight.normal),
          bodyText1: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),   //body1
          //bodyText2: TextStyle(fontSize: 15 , letterSpacing: 5),   //body2
        )),
        initialRoute: SignInScreen.routeName,
        routes: {
          SignInScreen.routeName: (context) => SignInScreen(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
          ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
          HomeFeedScreen.routeName: (context) => HomeFeedScreen(),
          SearchScreen.routeName: (context) => SearchScreen(),
          UserSearchScreen.routeName: (context) => UserSearchScreen(),
          //ChatroomScreen.routeName: (context) => ChatroomScreen(),
          AddScreen.routeName: (context) => AddScreen(),
          MoreInfoScreen.routeName: (context) => MoreInfoScreen(),
          AboutScreen.routeName: (context) => AboutScreen(),
        });
  }
}
