

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'home.dart';
import 'journal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/commonComponents/customDrawer.dart';
import 'package:flutter/services.dart';

class NuggetPage extends StatefulWidget {
  final String uid;
  NuggetPage({this.uid});

  @override
  _NuggetPageState createState() => _NuggetPageState();
}

class _NuggetPageState extends State<NuggetPage> {
  String makePars(String orig) {
    List<String> split = orig.split("|");
    String returner = "";
    for(int i = 0; i < split.length; i++) {
      returner += split[i];
      if (i != split.length-1) {
        returner += "\n\n";
      }
    }
    return returner;
  }

  @override
  Widget build(BuildContext context) {
    DateFormat fmt = DateFormat("M/dd/yyyy");
    String newDate = "${fmt.format(DateTime.now())}";
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
                "nuggetdate": newDate});
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
              Firestore.instance
                  .collection("users")
                  .document(widget.uid)
                  .collection('subscriptions').add({
                "nuggetid": nuggetId,
                "nuggetdate": newDate,
                "name": nugget['name'],
                "oontent": nugget['content'],
                "exercise": nugget['exercise'],
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
                  "nuggetdate": newDate});

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
                Firestore.instance
                    .collection("users")
                    .document(widget.uid)
                    .collection('subscriptions').add({
                  "nuggetid": nuggetId,
                  "nuggetdate": newDate,
                  "name": nugget['name'],
                  "oontent": nugget['content'],
                  "exercise": nugget['exercise'],
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
                    List<Map<String,Map<String, String>>> l = snapshot.data.data.map((DocumentSnapshot nugget) {
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
                      appBar: AppBar(

//                        leading: new Container(),
                        centerTitle: true,
                        title: Text(
                          'Your Daily Nugget.',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        flexibleSpace: Container(
                          decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Colors.lightBlueAccent, Colors.indigo[100]])),
                        ),
                      ),
//                      drawer: CustomDrawer(uid: widget.uid, context: context, current: "Dashboard",),
                      body: ListView(
                        children: <Widget>[
                          Container(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.pagelines, size:30, color: Colors.grey),
                                      Text(
                                        'daily nugget.',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(
                                          FontAwesomeIcons.pagelines, size:30, color: Colors.grey),
                                    ],
                                  ),
                                  Text(
                                    '${makePars(nugget["content"])}',
                                    style: TextStyle(
                                        fontSize: 15.0),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                  )
                                ],
                              ),
                              margin: EdgeInsets.all(15),
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 25.0, // soften the shadow
                                    spreadRadius: 5.0, //extend the shadow
                                    offset: Offset(
                                      15.0, // Move to right 10  horizontally
                                      15.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.bolt, size:30, color: Colors.grey),
                                      Text(
                                        'daily exercise.',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(FontAwesomeIcons.bolt, size:30, color: Colors.grey),
                                    ],
                                  ),
                                  Text(
                                    "${makePars(nugget['exercise'])}",
                                    style: TextStyle(
                                        fontSize: 15.0),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                  )
                                ],
                              ),
                              margin: EdgeInsets.all(15),
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 25.0, // soften the shadow
                                    spreadRadius: 5.0, //extend the shadow
                                    offset: Offset(
                                      15.0, // Move to right 10  horizontally
                                      15.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      bottomNavigationBar: BottomAppBar(
                        elevation: 0.0,
                        child: Container(
                          height: 20.0,
                        ),
                      ),
                      floatingActionButton: FloatingActionButton(
                        backgroundColor: Colors.white70,
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          Navigator.push(context,MaterialPageRoute(builder: (context) => JournalPage(uid: widget.uid,)),);
                        },
                        tooltip: 'Add',
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                }
              },
            );
        }
      },
    );
  }
  /// Method to get the query of the user's current nugget and date
  Stream<DocumentSnapshot> getUser() {
    Firestore fs = Firestore.instance;
    return fs.collection('users').document(widget.uid).snapshots();
  }
  //Method to get all nuggets
  Stream<QuerySnapshot> getAllNuggets() {
    Firestore fs = Firestore.instance;
    return fs.collection("nuggets").snapshots();
  }
}