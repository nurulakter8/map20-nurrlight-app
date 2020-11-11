import 'package:flutter/material.dart';
import 'package:nurrlight/controller/widget_controller.dart';
import 'package:nurrlight/screens/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signInScreen/signUpScreen';
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUpScreen> {
  _Controller con;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Create an account',
                style: TextStyle(fontSize: 25),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'UserName',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: con.validatorUsername,
                onSaved: con.onSavedUserName,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: con.validatorEmail,
                onSaved: con.onSavedEmail,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                autocorrect: false,
                validator: con.validatorPassword,
                onSaved: con.onSavedPassword,
              ),
              RaisedButton(
                child: Text(
                  'Create',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.brown[300])),
                color: Colors.brown[300],
                onPressed: con.signUp,
              ),
              SizedBox(height: 30),
              FlatButton(
                onPressed: con.signIn,
                child: Text(
                  'Already have an account? Click here to Sign In',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _SignUpState _state;
  _Controller(this._state);
  String email;
  String password;
  String userName;

  void signUp() async {}

  void signIn() {
    Navigator.pushNamed(_state.context, SignInScreen.routeName);
  }

  String validatorEmail(String value) {
    if (value.contains('@') && value.contains('.'))
      return null;
    else
      return 'Invalied Email';
  }

  void onSavedEmail(String value) {
    this.email = value;
  }

  String validatorPassword(String value) {
    if (value.length < 6)
      return 'min 6 chars';
    else
      return null;
  }

  void onSavedPassword(String value) {
    this.password = value;
  }

  String validatorUsername(String value) {
    if (value.length < 6)
      return 'min 6 chars';
    else
      return null;
  }

  void onSavedUserName(String value) {
    this.userName = value;
  }
}
