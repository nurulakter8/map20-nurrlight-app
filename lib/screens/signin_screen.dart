import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nurrlight/controller/authmethods_controller.dart';
import 'package:nurrlight/controller/widget_controller.dart';
import 'package:nurrlight/screens/forgotpassword_screen.dart';
import 'package:nurrlight/screens/signup_screen.dart';
import 'package:nurrlight/screens/views/messagebox.dart';

import 'homefeed_screen.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signInScreen';
  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignInScreen> {
  _Controller con;
  var formKey = GlobalKey<FormState>(); // form key
  AuthMethodsController authMethodsController = new AuthMethodsController();
  bool isLoading = false;
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBarMain(context),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            // form widget, need to set up a form key, "formKey"
            key: formKey, // thats the key we set up
            child: Column(
              children: <Widget>[
                Stack(
                  // stacking widgeds to have it lay top of each other
                  children: <Widget>[
                    // add images top of text form
                    Image.asset('assets/images/logo.png'),
                    // additional custom text
                  ],
                ),
                TextFormField(
                  // text field form for email
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.brown[100],
                    filled: true,
                    focusColor: Colors.brown[100],
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: con.validatorEmail, // function
                  onSaved: con.onSavedEmail, // function
                  style: TextStyle(color: Colors.brown[300]),
                  controller: emailEditingController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.brown[100],
                    filled: true,
                    focusColor: Colors.brown[100],
                  ),
                  obscureText: true, // sucures text
                  autocorrect: false,
                  validator: con.validatorPassword, // function
                  onSaved: con.onSavedPassword, // function
                  style: TextStyle(color: Colors.brown[300]),
                  controller: passwordEditingController,
                ),
                // forgot password
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Container(
                    width: double.infinity,
                    child: InkWell(
                      onTap: con.forgotPassword,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.brown[300]),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.brown[300])),
                  color: Colors.brown[300],
                  onPressed: con.signIn, // function
                ),

                SizedBox(height: 30),
                FlatButton(
                  onPressed: con.signUp,
                  child: Text(
                    'No account yet? Register Now',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _SignInState _state;
  _Controller(this._state);
  String email; // valided ones will be there
  String password;

  void signUp() {
    Navigator.pushNamed(_state.context, SignUpScreen.routeName);
  }

  Future<void> signIn() async {
    // if (!_state.formKey.currentState.validate()) {
    //   return; // if not valid then just return
    // }
    // _state.formKey.currentState
    //     .save(); // saves email and password by calling save function

    // FirebaseUser user; // declaring user here to save firebase user info
    // try {
    //   user = await AuthMethodsController.signInWithEmailAndPassword(
    //       email, password); // try to sign in using firebase user
    //   print("user: $user");
    //   Navigator.pushReplacementNamed(_state.context, HomeFeedScreen.routeName);
    // } catch (e) {
    //   MessageBox.info(
    //     context: _state.context,
    //     title: 'Sign in Error',
    //     content: e.message ?? e.toString(),
    //   );
    //   return;
    // }
    try {
      if (_state.formKey.currentState.validate()) {
        _state.isLoading = true;

        await AuthMethodsController.signInWithEmailAndPassword(
                _state.emailEditingController.text,
                _state.passwordEditingController.text)
            .then((result) async {
          if (result != null) {
            Navigator.pushReplacementNamed(
                _state.context, HomeFeedScreen.routeName);
          } else {
            _state.isLoading = false;
            MessageBox.info(
              title: 'Sign in error',
            );
          }
        });
      }
    } catch (e) {
      MessageBox.info(
        context: _state.context,
        title: 'Sign in Error',
        content: e.message ?? e.toString(),
      );
    }
  }

  void forgotPassword() {
    Navigator.pushNamed(_state.context, ForgotPasswordScreen.routeName);
  }

  void onSavedPassword(String value) {
    password = value;
  }

  String validatorPassword(String value) {
    if (value == null || value.length < 6) {
      return 'Password min 6 chard';
    } else {
      return null;
    }
  }

  void onSavedEmail(String value) {
    email = value;
  }

  String validatorEmail(String value) {
    // validating email
    return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)
        ? null
        : "Please Enter Correct Email";
  }
}
