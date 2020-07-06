import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_first_app/dailyquote.dart';
import 'package:my_first_app/register.dart';
import 'color.dart';
import 'animation.dart';
import 'dailyquote.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/forgotpassword.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  bool showSpinner = false;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
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
//    return FutureBuilder(
//        future: checkUser(),
//    builder: (context, snapshot) {
//      switch (snapshot.connectionState) {
//        case ConnectionState.waiting:
//          return Container();
//        default:
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,

//      floatingActionButton: FloatingActionButton(
//        backgroundColor: Colors.white70,
//        onPressed: () {
//            Navigator.push(context,FadeRoute(page: WelcomeScreen()),);
//          },
//
//        child: Text(
//          'XXXXXX',
//          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//        ),
//      ),

            body: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: SingleChildScrollView(
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height,
                        child: Stack(
                          children: <Widget>[
                            backgroundImageWidget(),
                            Positioned(
                              top: 60,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(
                                    vertical: 50, horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
//                            FadeAnimation(
//                                1.5,
////                                Text(
////                                  "calmAscent.",
////                                  textAlign: TextAlign.center,
////                                  style: TextStyle(
////                                      color: Colors.white,
////                                      fontWeight: FontWeight.bold,
////                                      fontSize: 30),
////                                )
//                            ),
                                    SizedBox(
                                      height: 120,
                                    ),

                                    loginFormWidget(),
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
                                    signupButtonWidget(),
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
            ),
          );
//      }
//    }
//    );
  }


  /// Displaying background image and logo
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

  /// login form
  Widget loginFormWidget() {
    return FadeAnimation(
        1.7,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
//                  color: Color.fromRGBO(196, 135, 198, .3),
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
                          "Welcome",
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
                    obscureText: true,
                    validator: pwdValidator,
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ForgotPasswordScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Center(
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Color(0xFF00B0FF)),
                        )),
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
                        if (_loginFormKey.currentState.validate()) {
                          setState(() {
                            showSpinner = true;
                          });
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                              email: emailInputController.text,
                              password: pwdInputController.text)
                              .then((currentUser) => Firestore.instance
                              .collection("users")
                              .document(currentUser.uid)
                              .get()
                              .then((DocumentSnapshot result) {

                            if (currentUser.isEmailVerified) {
                              setState(() {
                                showSpinner = false;
                              });
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          QuotePage(
                                            uid: currentUser.uid, initFlow: true,
                                          )));
                            } else {
                              setState(() {
                                showSpinner = false;
                              });
                              currentUser.sendEmailVerification();
                              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Please verify your email with the sent email"),));
                            }
                          })
                              .catchError((error) {
                            if (error.code == "ERROR_USER_NOT_FOUND") {
                              setState(() {
                                showSpinner = false;
                              });
                              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("User Not Found, Please Register", style: TextStyle(fontSize: 20),), backgroundColor: Colors.orange, duration: Duration(seconds: 5),),);
                            }
                            if (error.code == "ERROR_WRONG_PASSWORD") {
                              setState(() {
                                showSpinner = false;
                              });
                              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Incorrect password", style: TextStyle(fontSize: 20),), backgroundColor: Colors.orange, duration: Duration(seconds: 5),),);
                            }
                          }))
                              .catchError((error) {
                            setState(() {
                              showSpinner = false;
                            });
                            if (error.code == "ERROR_USER_NOT_FOUND") {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("User Not Found, Please Register", style: TextStyle(fontSize: 20),), backgroundColor: Colors.orange, duration: Duration(seconds: 5),),);
                            }
                            if (error.code == "ERROR_WRONG_PASSWORD") {
                              setState(() {
                                showSpinner = false;
                              });
                              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Incorrect password", style: TextStyle(fontSize: 20),), backgroundColor: Colors.orange, duration: Duration(seconds: 5),),);
                            }
                          });

                        }
                      },
                      child: Text(
                        'Login Now',
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

  ///Login Button Navigate to Home screen
  Widget loginButtonWidget() {
    return Positioned(
      height: 200,
      width: MediaQuery.of(context).size.width + 20,
      child: FadeAnimation(
        1.9,
        Container(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (context) => QuotePage()));
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0xFF00B0FF),
              ),
              child: Icon(Icons.arrow_forward, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

//  /// Social login button like Facebook, Twitter, Google
//  Widget socialLoginWidget() {
//    return FadeAnimation(
//      1.9,
//      Container(
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Material(
//              child: SvgPicture.asset(
//                'asset/img/social-icon/google.svg',
//                semanticsLabel: 'Acme Logo',
//                height: 35,
//                width: 35,
//              ),
//            ),
//            SizedBox(width: 10),
//            SvgPicture.asset(
//              'asset/img/social-icon/facebook.svg',
//              semanticsLabel: 'Acme Logo',
//              height: 35,
//              width: 35,
//            ),
//            SizedBox(width: 10),
//            SvgPicture.asset(
//              'asset/img/social-icon/twitter.svg',
//              semanticsLabel: 'Acme Logo',
//              height: 35,
//              width: 35,
//            ),
//            SizedBox(width: 10),
//          ],
//        ),
//      ),
//    );
//  }

  Widget signupButtonWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Not setup with an account? ",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (context) => RegisterPage()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                "Register now",
                style: TextStyle(
                  color: Color(0xFF00B0FF),
                  fontSize: 18,
                ),

              ),
            ),
          )
        ],
      ),
    );
  }
//  Future<void> checkUser() async {
//    FirebaseAuth _auth = FirebaseAuth.instance;
//    FirebaseUser currentUser = await  _auth.currentUser();
//    if (currentUser != null && currentUser.email != null) {
//      Navigator.push(
//          context, CupertinoPageRoute(builder: (context) => QuotePage(uid: currentUser.uid, initFlow: true,)));
//    }
//  }
}