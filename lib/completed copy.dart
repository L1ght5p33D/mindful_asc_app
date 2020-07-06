import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/dashboard.dart';
import 'package:my_first_app/nugget.dart';
import 'home.dart';
import 'journal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'nugget.dart';
import 'package:flutter/services.dart';
import 'animation.dart';


class CompletedPage extends StatefulWidget {
  final String uid;
  CompletedPage({this.uid});
  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: getUser(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
        return new Text('Error: ${snapshot.error}');
        }
      switch (snapshot.connectionState) {
      case ConnectionState.waiting: return new Text('Loading...');
      default:
        int nuggetId;
        DateTime nuggetDate;
        DateFormat fmt = DateFormat("M/dd/yyyy");
        print(snapshot.data.data);
      if (snapshot.data.data == null || snapshot.data['nuggetid'] == null || snapshot.data['nuggetdate'] == null) {
    String newDate = "${fmt.format(DateTime.now())}";
    nuggetId = 1;
    nuggetDate = fmt.parse(newDate);
    Firestore.instance
        .collection("users")
        .document(widget.uid).updateData({
    "nuggetid": nuggetId,
    "nuggetdate": newDate
    });
    } else {
    nuggetId = int.parse("${snapshot.data['nuggetid']}");
    nuggetDate = fmt.parse(snapshot.data['nuggetdate']);
    print(nuggetDate);
    print(DateTime.now());
    print(DateTime.now().difference(nuggetDate).compareTo(Duration(days: 1)));
    if (DateTime.now().difference(nuggetDate).compareTo(Duration(days: 1)) > 0) {
    print("GREATER");
    print(nuggetId);
    String newDate = "${fmt.format(DateTime.now())}";
    nuggetId++;
    print(nuggetId);
    Firestore.instance
        .collection("users")
        .document(widget.uid).updateData({
    "nuggetid": nuggetId,
    "nuggetdate": newDate
    });
    }
    }
    return StreamBuilder<QuerySnapshot>(
    stream: getAllNuggets(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
    if (snap.hasError) {
    return new Text('Error: ${snap.error}');
    }
    switch (snap.connectionState) {
    case ConnectionState.waiting: return new Text("Loading...");
    default:
    List<Map<String,Map<String, String>>> l = snap.data.documents.map((DocumentSnapshot nugget) {
    return {
    "${nugget['id']}" : {
    "name":"${nugget['name']}",
    "content": "${nugget['content']}",
    "exercise": "${nugget['exercise']}"
    },
    };
    }).toList();
    print(l);
    Map<String, Map<String, String>> nuggets = {};
    l.forEach((item) => nuggets[item.keys.toList().first] = item.values.toList().first);
    print(nuggets);
    Map<String, String> nugget = nuggets["$nuggetId"];
      return Scaffold(
      body: Stack(
        children: <Widget>[

                          //        Container(
                          //          decoration: BoxDecoration(
                          //            // Box decoration takes a gradient
                          //            gradient: LinearGradient(
                          //              // Where the linear gradient begins and ends
                          //              begin: Alignment.topRight,
                          //              end: Alignment(0.3, 0),
                          //              tileMode: TileMode.repeated, // repeats the gradient over the canvas
                          //              colors: [
                          //                // Colors are easy thanks to Flutter's Colors class.
                          //                Colors.red,
                          //                Colors.orange,
                          //              ],
                          //            ),
                          //          ),
                          //        ),
        Container(
          decoration: BoxDecoration(
            // Box decoration takes a gradient
              image: DecorationImage(
                  image: AssetImage('assets/cloud.jpg'),
                  fit: BoxFit.cover
              )
          ),
        ),

        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeAnimation(
                1.5,
                Text('Congratulations!  You have completed your daily routine!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    ),
                ),
              ),
              Container(

                child: Text('Mind workouts completed:\n$nuggetId',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70,
                  boxShadow: [
                    BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      15.0, // Move to right 10  horizontally
                      15.0, // Move to bottom 10 Vertically
                    ),
                    )
                  ],
                  ),
                  ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text(
                    'Finish',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                elevation: 8.0,
                color: Color(0xFFFFA000),
                onPressed: () {
                  HapticFeedback.lightImpact(); Navigator.push(context,MaterialPageRoute(builder: (context) => Home(uid: widget.uid,)),);
                },
              ),
              ],
            ),
          ),





      ],
    ),
      

                    );
                }
              }
    );
    }
    }
    );
  }
  /// Method to get the query of the user's current nugget and date
  Stream<DocumentSnapshot> getUser() {
    Firestore fs = Firestore.instance;
    return fs.collection('users').document(widget.uid).snapshots();
  }
  //Method to get all quotes
  Stream<QuerySnapshot> getAllNuggets() {
    Firestore fs = Firestore.instance;
    return fs.collection("nuggets").snapshots();
  }
}