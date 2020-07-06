import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/settings.dart';

class UpdatePasswordScreen extends StatefulWidget {
  final String uid;
  UpdatePasswordScreen({this.uid});
  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  String _password = "";
  String _cPassword = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen(uid:widget.uid,))),
                  ),
                  title: Text(
                    'Logo Here',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    Text(
                      'Change your password',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 25),
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
                                Icons.lock,
                                color: Colors.black,
                              ),
                              hintText: 'Current Password',
                              hintStyle: Theme.of(context).textTheme.bodyText1,
                              isDense: true,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field cannot be blank';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _cPassword = value;
                            }
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 25),
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
                                Icons.lock,
                                color: Colors.black,
                              ),
                              hintText: 'New Password',
                              hintStyle: Theme.of(context).textTheme.bodyText1,
                              isDense: true,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field cannot be blank';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value;
                            }
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => SizedBox(
                      width: 225,
                      child: RaisedButton(
                        color: Colors.black12,
                        onPressed: () async {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            FirebaseUser user = await FirebaseAuth.instance.currentUser();
                            FirebaseAuth.instance.signInWithEmailAndPassword(email: user.email, password: _cPassword).then((value) => {
                              value.updatePassword(_password).then((_) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Password Changed Successfully')));
                                print("Succesfully changed password");
                              }).catchError((error) {
                                print("Password can't be changed" + error.toString());
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Error')));
                              })
                            }).catchError((error) {
                              print("Password can't be changed" + error.toString());
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('Error')));
                            });
                          }
                        },
                        child: Text(
                          'Update',
                          style: Theme.of(context).textTheme.headline6,
                        ),
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
}