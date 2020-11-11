import 'package:flutter/material.dart';
import 'package:nurrlight/screens/signin_screen.dart';

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
        });
  }
}
