import 'package:flutter/material.dart';
import 'package:nurrlight/controller/widget_controller.dart';
import 'package:nurrlight/screens/signup_screen.dart';

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
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
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
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: con.validatorEmail, // function
                  onSaved: con.onSavedEmail, // function
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true, // sucures text
                  autocorrect: false,
                  validator: con.validatorPassword, // function
                  onSaved: con.onSavedPassword, // function
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
                    'No account yet? Click here to create',
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

  void signIn() {}

  void forgotPassword() {}

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
    if (value == null || !value.contains('@') || !value.contains('.')) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }
}
