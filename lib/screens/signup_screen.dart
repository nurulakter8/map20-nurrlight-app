import 'package:flutter/material.dart';
import 'package:nurrlight/controller/authmethods_controller.dart';
import 'package:nurrlight/controller/data_controller.dart';
import 'package:nurrlight/controller/helper_controller.dart';
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
  bool isLoading = false;
  AuthMethodsController authMethodsController = new AuthMethodsController();
  DataController dataController = new DataController();
  HelperFunctions helperFunctions = new HelperFunctions();

  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

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
      body: isLoading
          ? Container(
              // after valid signup show progress indicator
              child: Center(child: CircularProgressIndicator()),
            )
          : Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
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
                          fillColor: Colors.brown[100],
                          filled: true,
                          focusColor: Colors.brown[100],
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: con.validatorUsername,
                        onSaved: con.onSavedUserName,
                        style: TextStyle(color: Colors.brown[300]),
                        controller: userNameTextEditingController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          fillColor: Colors.brown[100],
                          filled: true,
                          focusColor: Colors.brown[100],
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: con.validatorEmail,
                        onSaved: con.onSavedEmail,
                        style: TextStyle(color: Colors.brown[300]),
                        controller: emailTextEditingController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Password',
                          fillColor: Colors.brown[100],
                          filled: true,
                          focusColor: Colors.brown[100],
                        ),
                        obscureText: true,
                        autocorrect: false,
                        validator: con.validatorPassword,
                        onSaved: con.onSavedPassword,
                        style: TextStyle(color: Colors.brown[300]),
                        controller: passwordTextEditingController,
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

  void signUp() async {
    if (_state.formKey.currentState.validate()) {
      _state.isLoading = true;
      _state.authMethodsController
          .signUpWithEmailAndPassword(_state.emailTextEditingController.text,
              _state.passwordTextEditingController.text)
          .then((value){
            Map<String, String> userInfoMap = {
              "name" : _state.userNameTextEditingController.text,
              "email": _state.emailTextEditingController.text,
            };
            // saving values
          HelperFunctions.saveUserEmailSharedPreference(_state.emailTextEditingController.text);
          HelperFunctions.saveUserEmailSharedPreference(_state.userNameTextEditingController.text);


            _state.dataController.uploadUserInfo(userInfoMap);
            HelperFunctions.saveUserLoggedInSharedPreference(true);

            Navigator.pushNamed(_state.context, SignInScreen.routeName);

          } //print('${value.uId}'));
          );
    }
  }

  void signIn() {
    Navigator.pushNamed(_state.context, SignInScreen.routeName);
  }

  String validatorEmail(String value) {
    return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)
        ? null
        : "Please Enter Correct Email";
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
