import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nurrlight/screens/views/messagebox.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/signInScreen/forgotPasswordScreen';

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordState();
  }
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
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
      appBar: AppBar(
        title: Image.asset(
          "assets/images/barLogo.png",
          height: 50,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 5, left: 20, right: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Email will be sent shortly! Please Click on the link in your email to reset your password.',
                  style: TextStyle(
                    color: Colors.red[400],
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                Theme(
                  data: ThemeData(
                    hintColor: Colors.brown[300],
                  ),
                  child: TextFormField(
                    validator: con.validatorEmail,
                    style: TextStyle(color: Colors.brown[300]),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      fillColor: Colors.brown[100],
                      filled: true,
                      focusColor: Colors.brown[100],
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: RaisedButton(
                    onPressed: con.sendEmail,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.brown[300],
                    child: Text(
                      'Send Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
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
  _ForgotPasswordState _state;
  _Controller(this._state);
  String email;

  String validatorEmail(String value) {
    if (value.isEmpty || !value.contains('@') || !value.contains('.')) {
      return 'Invalid/Please Enter correct email address!';
    } else {
      email = value;
    }
    return null;
  }

  Future<void> sendEmail() async {
    try {
      if (_state.formKey.currentState.validate()) {
        FirebaseAuth.instance.sendPasswordResetEmail(email: email).then(
              (value) => MessageBox.info(
                context: _state.context,
                title: 'Email Sent!!',
                content: 'Please check your email. Thank you!',
              ),
            );
        //print('Email Sent! Please check your email')
      }
    } catch (e) {
      MessageBox.info(
        context: _state.context,
        title: 'Error sending email',
        content: e.message ?? e.toString(),
      );
      return;
    }
  }
}
