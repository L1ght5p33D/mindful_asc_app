import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_first_app/login.dart';
import 'color.dart';
import 'animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController usernameInputController;

  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;
  bool showSpinner = false;

  @override
  initState() {
    usernameInputController = new TextEditingController();

    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Form(
              key: _registerFormKey,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: <Widget>[
                        backgroundImageWidget(),
                        Positioned(
                          top: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
//                              FadeAnimation(
//                                  1.5,
////                                  Text(
////                                    "calmAscent.",
////                                    textAlign: TextAlign.center,
////                                    style: TextStyle(
////                                        color: Colors.white,
////                                        fontWeight: FontWeight.bold,
////                                        fontSize: 30),
////                                  )
//                              ),
                                SizedBox(
                                  height: 120,
                                ),

                                signupFormWidget(),
                                SizedBox(
                                  height: 20,
                                ),
//                          FadeAnimation(
//                              1.9,
//                              const Text(
//                                "or login with",
//                                style: TextStyle(fontSize: 14),
//                              )),
                                SizedBox(
                                  height: 10,
                                ),
//                          socialLoginWidget(),
                                const SizedBox(
                                  height: 15,
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  ///Background image and logo
  Widget backgroundImageWidget() {
    return Positioned(
      top: -40,
      height: 400,
      width: MediaQuery.of(context).size.width,
      child: FadeAnimation(
          1,
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF00B0FF),
                image: DecorationImage(
                    image: AssetImage('assets/calmAscent_logo_lt_blue.png'),
                    fit: BoxFit.fill)
            ),
          )),
    );
  }

//Signup form Widget
  Widget signupFormWidget() {
    return FadeAnimation(
        1.7,
        Container(

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(

                  blurRadius: 50,
                  offset: Offset(0, 10),
                )
              ]),

          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                FadeAnimation(
                    1.8,
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child: Center(
                        child: Text(
                          "New User",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(

                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 55.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: splashIndicatorColor)),

                  child: TextFormField(
                    style: TextStyle(fontWeight: FontWeight.w600),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: splashIndicatorColor.withOpacity(0.8)),
                      icon: Icon(Icons.person),
                      border: InputBorder.none,
                    ),
                    controller: usernameInputController,
                    validator: (value) {
                      if (value.length < 3) {
                        return "Please enter a valid username.";
                      }
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 55.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: splashIndicatorColor)),
                  child: TextFormField(
                    style: TextStyle(fontWeight: FontWeight.w600),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: splashIndicatorColor.withOpacity(0.8)),
                      icon: Icon(Icons.email),
                      border: InputBorder.none,
                    ),
                    controller: emailInputController,
                    validator: emailValidator,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 55.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: splashIndicatorColor)),
                  child: TextFormField(
                    style: TextStyle(fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: splashIndicatorColor.withOpacity(0.8),
                        ),
                        icon: Icon(Icons.lock),
                        border: InputBorder.none),
                    controller: pwdInputController,
                    validator: pwdValidator,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 55.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: splashIndicatorColor)),
                  child: TextFormField(
                    style: TextStyle(fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: splashIndicatorColor.withOpacity(0.8),
                        ),
                        icon: Icon(Icons.lock),
                        border: InputBorder.none),
                    controller: confirmPwdInputController,
                    validator: pwdValidator,
                  ),
                ),
                const SizedBox(height: 15),
                FadeAnimation(
                    1.8,
                    MaterialButton(
                      minWidth: 150,
                      height: 60,
                      color: Color(0xFF00B0FF),
                      onPressed: () {

                        HapticFeedback.lightImpact();
                        if (_registerFormKey.currentState.validate()) {
                        if (pwdInputController.text ==
                        confirmPwdInputController.text) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Registration successful! Please verify your email and login", style: TextStyle(fontSize: 20),), backgroundColor: Colors.orange, duration: Duration(seconds: 5),),);
                        setState(() {
                          showSpinner = true;
                        });
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                        email: emailInputController.text,
                        password: pwdInputController.text).then((currentUser) {
                        currentUser.sendEmailVerification();
                        Firestore.instance.collection("users").document(currentUser.uid).setData({
                        "uid": currentUser.uid,
                        "username": usernameInputController.text,
                        "email": emailInputController.text,
                        })
                            .then((result) {
                          setState(() {
                            showSpinner = false;
                          });
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (_) => false);

                              usernameInputController.clear();
                              emailInputController.clear();
                              pwdInputController.clear();
                              confirmPwdInputController.clear();
                            })
                                .catchError((error) {
                          setState(() {
                            showSpinner = false;
                          });
                              if (error.code == "ERROR_EMAIL_ALREADY_IN_USE") {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Email is already in use, please select another", style: TextStyle(fontSize: 20),), backgroundColor: Colors.orange, duration: Duration(seconds: 5),),);
                              }
                              });})
                                .catchError((error) {
                          setState(() {
                            showSpinner = false;
                          });
                              if (error.code == "ERROR_EMAIL_ALREADY_IN_USE") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Email is already in use, please select another", style: TextStyle(fontSize: 20),), backgroundColor: Colors.orange, duration: Duration(seconds: 5),),);
                              }
                            });
                          } else {
                          setState(() {
                            showSpinner = false;
                          });
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text("The passwords do not match"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      elevation: 8.0,
                    )),
              ],
            ),
          ),
        ));
  }
}
