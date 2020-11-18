import 'package:flutter/material.dart';
import 'package:nurrlight/screens/forgotpassword_screen.dart';
import 'package:nurrlight/screens/homefeed_screen.dart';
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
        // title: 'Nurr Light',
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,

        // ),
        debugShowCheckedModeBanner: false,
        initialRoute: SignInScreen.routeName,
        routes: {
          SignInScreen.routeName: (context) => SignInScreen(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
          ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
          HomeFeedScreen.routeName: (context) => HomeFeedScreen(),
          SearchScreen.routeName: (context) => SearchScreen(),
          UserSearchScreen.routeName: (context) => UserSearchScreen(),
        });
  }
}
