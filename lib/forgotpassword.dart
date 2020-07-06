import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/settings.dart';
import 'package:my_first_app/login.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String uid;
  ForgotPasswordScreen({this.uid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ForgotPasswordScreenState();
  }}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String _email = "";
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.bottomLeft,
                  begin: Alignment.topRight,
                  colors: [
                    Colors.white,
                    Colors.blueGrey.shade500,
                  ],
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 25,
                ),
                ListTile(
                  leading: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      size: 35,
                    ),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
                  ),
                  title: Text(
                    'Logo Here',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    Text(
                      'Reset Your Password',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 25, 50, 25),
                      child: Container(
//                    padding: const EdgeInsets.all(50),
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: Colors.black),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person_pin,
                              color: Theme.of(context).primaryColor,
                            ),
                            suffixIcon: Icon(
                              Icons.check_circle,
                              color: Colors.lightGreen,
                            ),
                            hintText: 'Email...',
                            hintStyle: Theme.of(context).textTheme.bodyText1,
                            isDense: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 225,
                      child: RaisedButton(
                        color: Colors.black12,
                        onPressed: () async {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
                            _showDialog();

                          }
                        },
                        child: Text(
                          'Reset password',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.all(15.0),
        content: Container(

          child: Text("An email has been sent to the email address provided. Please follow the steps in the email to reset your password."),
        ),
        actions: <Widget>[

          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.black12,
              child: Text('Ok'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginPage()));

              })
        ],
      ),
    );
  }
}
