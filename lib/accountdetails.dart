import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_first_app/settings.dart';

class AccountDetailsScreen extends StatefulWidget {
  final String uid;
  AccountDetailsScreen({this.uid});
  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  String _user = "";
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
            child: Center(
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
//                    title: Center(
//                      child: Text(
//                        'Update Username',
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                            color: Colors.black,
//                            fontSize: 20
//                        ),
//                      ),
//                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Text(
                        'Change your username',
                        style: Theme.of(context).textTheme.headline5,

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
                                color: Colors.black,
                              ),
                              suffixIcon: Icon(
                                Icons.check_circle,
                                color: Colors.lightGreen,
                              ),
                              hintText: 'Enter new username',
                              hintStyle: Theme.of(context).textTheme.bodyText2,
                              isDense: true,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field cannot be blank';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _user = value;
                            },
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

                              UserUpdateInfo userUpdateInfo = UserUpdateInfo();

                              userUpdateInfo.displayName = _user;

                              user.updateProfile(userUpdateInfo).then((value) => {
                              Firestore.instance.collection('users').document(user.uid).updateData(
                              {"username": _user}),

                                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Username Changed Successfully')))
                              }).catchError((error) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Error')));
                              });

                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('Processing')));
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
      ),
    );
  }
}
