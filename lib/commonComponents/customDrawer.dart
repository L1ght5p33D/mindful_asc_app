import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/dashboard.dart';
import 'package:my_first_app/home.dart';
import'package:my_first_app/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_first_app/settings.dart';
import 'package:my_first_app/usernuggets.dart';
import 'package:my_first_app/userprogress.dart';
import '../userqa.dart';

class CustomDrawer extends Drawer {
  CustomDrawer({this.context, this.uid, this.current});
  final BuildContext context;
  final String uid;
  final String current;
  @override
  Widget get child => new Container(

    child: new ListView(

      children: <Widget>[
        Container(
          height: 140,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/calmAscent_logo_lt_blue.png'),
                fit: BoxFit.cover,
              )),
        ),

        ListTile(
          leading: Icon(Icons.home),
          title: Text("Your Dashboard", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            if (current != "Home") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(uid: uid,)),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(FontAwesomeIcons.question),
          title: Text("Daily Q & A", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          onTap: () {
            if (current != "QA") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserQA(uid: uid)),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(FontAwesomeIcons.solidSun),
          title: Text("Nugget Feed", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          onTap: () {
            if (current != "Nuggets") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserNuggets(uid: uid,)),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.check_circle),
          title: Text("Your Progress", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          onTap: () {
            if (current != "Progress") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProgressPage(uid: uid,)),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.import_contacts),
          title: Text("Journals", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            if (current != "Your Journals") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(uid: uid,)),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            if (current != "Settings") {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingScreen(uid: uid,)),
              );
            }else {
              Navigator.pop(context);
            }
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text("Log Out", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          onTap: logOut,
        )
      ],
    ),
  );
  void logOut() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

}