import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/journal.dart';
import 'task.dart';
import 'register.dart';
import 'splash.dart';
import 'login.dart';
import 'home.dart';
import 'dashboard.dart';
import 'color.dart';
import 'nugget.dart';
import 'dailyquote.dart';
import 'welcome.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return FutureBuilder<FirebaseUser>(
        future: getUser(),
        builder: (context, snapshot) {
          return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primaryColor: primaryColor, fontFamily: 'Montserrat'),
              home: snapshot.data != null ? QuotePage(uid: snapshot.data.uid, initFlow: true) : SplashPage(),
              routes: <String, WidgetBuilder>{
                '/task': (BuildContext context) => TaskPage(content:'content'),
                '/home': (BuildContext context) => HomePage(),
                '/login': (BuildContext context) => LoginPage(),
                '/register': (BuildContext context) => RegisterPage(),
                '/dashboard': (BuildContext context) => Home(),
                '/journal': (BuildContext context) => JournalPage(),
                '/nugget': (BuildContext context) => NuggetPage(),
                '/welcome': (BuildContext context) => WelcomeScreen(),

              });
        }
    );
  }
  Future<FirebaseUser> getUser() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    if (currentUser != null && currentUser.uid != null) {
      return currentUser;
    } else {
      return null;
    }
  }
}
