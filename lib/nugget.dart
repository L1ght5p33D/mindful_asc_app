import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'journal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:my_first_app/dailyquote.dart';


class NuggetPage extends StatefulWidget {
  final String uid;
  final bool initFlow;
  NuggetPage({this.uid, this.initFlow});

  @override
  _NuggetPageState createState() => _NuggetPageState();
}

class _NuggetPageState extends State<NuggetPage> {
  void playSound(String soundFileName) {
    AudioCache cache = new AudioCache();
    cache.play(soundFileName);
  }

  var soundFilename='pling.wav';

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

  void share(String content, String exercise) async {
    DocumentSnapshot user = await Firestore.instance.collection("users").document(widget.uid).get();
    String message = "";
    if (user["email"] != null) {
      message = "${user["email"]} has sent you the Daily Nugget from the calmAscent app,\nhttp://www.calmascent.com:\n\n${makePars(content)}\n\nand the Daily Exercise:\n\n${makePars(exercise)}";
    } else {
      message = "Your friend send you the Daily Nugget from the calmAscent app,\nhttp://www.calmascent.com:\n\n${makePars(content)}\n\nand the Daily Exercise:\n\n${makePars(exercise)}";
    } Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: getUser(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return new Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return
            Scaffold(
              body: Container(),
            );
          default:
            int nuggetId;
            DateTime nuggetDate;
//            DateTime quoteDate;
            DateFormat fmt = DateFormat("M/dd/yyyy");
//            print(snapshot.data.data);
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
                  //for
//              quoteDate = fmt.parse(snapshot.data['quotedate']);
                  //
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
                  case ConnectionState.waiting: return
                    Scaffold(
                      body: Container(),
                    );
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
//                    print(l);
                    Map<String, Map<String, String>> nuggets = {};
                    l.forEach((item) => nuggets[item.keys.toList().first] = item.values.toList().first);
//                    print(nuggets);
                    Map<String, String> nugget = nuggets["$nuggetId"];
                    return Scaffold(
                      appBar: AppBar(

//                        leading: new Container(),
                        centerTitle: true,
                        title:
                          widget.initFlow ? Text('Your Daily Nugget.\n Step 1 of 5',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ):
                          Text('Your Daily Nugget.',
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
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,

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

                          Container(
                            margin: EdgeInsets.fromLTRB(125,0,125,0),
                            padding: EdgeInsets.all(10),
                            child: RaisedButton(
                              onPressed:  () {
                                share(nugget["content"], nugget["exercise"]);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              elevation: 8.0,
                              color: Colors.white70,
                              child: Icon(FontAwesomeIcons.share,
                                color: Colors.black45,
                              ),
                            ),
                          )

                        ],
                      ),
                      bottomNavigationBar: BottomAppBar(
                        elevation: 0.0,
                        child: Container(
                          height: 20.0,

                        ),
                      ),

                      floatingActionButton: widget.initFlow ? FloatingActionButton(
                        backgroundColor: Colors.white70,
                        onPressed: () {
//                          if (DateTime.now().difference(quoteDate).compareTo(Duration(days: 1)) > 0) {
//                            QuotePage(uid: widget.uid, initFlow: true); print('refreshing the stale page');
//                          } else {print('continue onwards');}
                          addToHistory(nugget["name"], "$nuggetId", fmt.format(DateTime.now()), nugget["content"], nugget["exercise"]);
                          playSound('pling.wav'); HapticFeedback.lightImpact(); Navigator.push(context,MaterialPageRoute(builder: (context) => JournalPage(uid: widget.uid, initFlow: true,)),);
                        },
                        tooltip: 'Add',
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ) : Container(),
                    );
                }
              },
            );
        }
      },
    );
  }
  addToHistory(String name, String id, String date, String content, String exercise) async {
    Firestore fs = Firestore.instance;
    QuerySnapshot nuggetHistory = await fs.collection('users').document(widget.uid).collection('nuggets').getDocuments();
    if (nuggetHistory.documents != null) {
      for (DocumentSnapshot doc in nuggetHistory.documents) {
        if ("${doc['id']}" == "$id") {
          return;
        }
      }
    }
    await fs.collection('users').document(widget.uid).collection('nuggets').add({
      "name": "$name",
      "id" : "$id",
      "timestamp" : "$date",
      "content" : "$content",
      "exercise": "$exercise",
    });
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
