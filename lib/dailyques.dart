import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/dailygoal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_first_app/dashboard.dart';
import 'package:my_first_app/userqa.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/dailyquote.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key key, this.content, this.uid, this.doc, this.initFlow}) : super(key: key); //update this to include the uid in the constructor
  final String content;
  final String uid; //include this
  final DocumentSnapshot doc;
  final bool initFlow;

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

  TextEditingController contentInputController;

  FirebaseUser currentUser;

  @override
  initState() {
    contentInputController = new TextEditingController();
    this.getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {

    contentInputController.text = widget.content;
    DateFormat fmt = DateFormat("EEEE, MMMM d, yyyy h:mm");

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
            int questionId;
            DateTime questionDate;
//            DateTime quoteDate;

            DateFormat fmt = DateFormat("M/dd/yyyy");
//            print(snapshot.data.data);
            if (snapshot.data.data == null || snapshot.data['questionid'] == null || snapshot.data['questiondate'] == null) {
              String newDate = "${fmt.format(DateTime.now())}";
              questionId = 1;
              questionDate = fmt.parse(newDate);
              Firestore.instance
                  .collection("users")
                  .document(widget.uid).updateData({
                "questionid": questionId,
                "questiondate": newDate
              });
            } else {
              questionId = int.parse("${snapshot.data['questionid']}");
              questionDate = fmt.parse(snapshot.data['questiondate']);
//              quoteDate = fmt.parse(snapshot.data['quotedate']);

//              print(questionDate);
//              print(DateTime.now());
//              print(DateTime.now().difference(questionDate).compareTo(Duration(days: 1)));
              if (DateTime.now().difference(questionDate).compareTo(Duration(days: 1)) > 0) {
                print("GREATER");
                print(questionId);
                String newDate = "${fmt.format(DateTime.now())}";
                questionId++;
                print(questionId);
                Firestore.instance
                    .collection("users")
                    .document(widget.uid).updateData({
                  "questionid": questionId,
                  "questiondate": newDate
                });
              }
            }
            return StreamBuilder<QuerySnapshot>(
              stream: getAllQuestions(),
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
                    List<Map<String,Map<String, String>>> l = snap.data.documents.map((DocumentSnapshot question) {
                      return {
                        "${question['id']}" : {
                          "name":"${question['name']}",
                          "content": "${question['content']}",
                          "exercise": "${question['exercise']}",
                        },
                      };
                    }).toList();
//                    print(l);
                    Map<String, Map<String, String>> questions = {};
                    l.forEach((item) => questions[item.keys.toList().first] = item.values.toList().first);
//                    print(questions);
                    Map<String, String> question = questions["$questionId"];

                    return Scaffold(
                      appBar: AppBar(
                        title:
                        widget.initFlow ? Text(
                          'Daily Question\nStep 3 of 5',
                          textAlign: TextAlign.center,

                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ):
                        Text(
                        'Daily Question',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        ),
                      ),
                      floatingActionButton: widget.initFlow ? FloatingActionButton(
                        backgroundColor: Colors.white70,
                        onPressed: () {
                          HapticFeedback.lightImpact();
//                          if (DateTime.now().difference(quoteDate).compareTo(Duration(days: 1)) > 0) {
//                            QuotePage(uid: widget.uid, initFlow: true); print('refreshing the stale page');
//                          } else {print('continue onwards');}
                          if (widget.initFlow) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    DailyGoal(uid: widget.uid, initFlow:true)),);
                          } else {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    UserQA(uid: widget.uid,)),);
                          }
                        },
                        tooltip: 'Add',
                        child: Text(
                          'Skip',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
//                            Icon(Icons.arrow_forward, color: Colors.black),

                      ) : Container(),
                      body: Stack(
                        children: <Widget>[

                          Container(
                            decoration: BoxDecoration(
                              // Box decoration takes a gradient
                              gradient: LinearGradient(
                                // Where the linear gradient begins and ends
                                begin: Alignment.topRight,
                                end: Alignment(0.3, 0),
                                tileMode: TileMode.repeated, // repeats the gradient over the canvas
                                colors: [
                                  // Colors are easy thanks to Flutter's Colors class.
                                  Colors.lightBlueAccent,
                                  Colors.indigo,
                                ],
                              ),
                            ),
                          ),

//                          Container(
//                            decoration: BoxDecoration(
//                              // Box decoration takes a gradient
//                                image: DecorationImage(
//                                    image: AssetImage("assets/mountain.jpg"),
//                                    fit: BoxFit.cover
//                                )
//                            ),
//                          ),
                          Center(
                            child: ListView(
                              children: <Widget>[

                                Container(
                                  child: Text('${question["content"]}',
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
                                    borderRadius: BorderRadius.circular(30),
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
                                Container(

                                  child: Column(
                                    children: <Widget>[
                                      TextField(
                                        maxLines: 6,
                                        decoration: InputDecoration.collapsed(
                                            hintText: "Write your response"),
                                        controller: contentInputController,
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                      )
                                    ],
                                  ),
                                  margin: EdgeInsets.fromLTRB(15, 30, 15, 15),
                                  padding: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
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

                                InkWell(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 19.0),
                                    margin: EdgeInsets.fromLTRB(75,0,75,0),
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                      color: Colors.indigo[50],
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Save your response",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,

                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    // Navigate back to the first screen by popping the current route
                                    // off the stack.
                                    HapticFeedback.lightImpact();
                                    if (contentInputController.text.isNotEmpty) {
                                      if (widget.doc != null) {
                                        DateFormat fmt2 = DateFormat("EEEE, MMMM d, yyyy h:mm");
                                        widget.doc.reference.updateData({
                                          "content": contentInputController.text,
//                        "description": taskDescripInputController.text,
                                          "timestamp": "${fmt2.format(DateTime.now())} ${DateTime.now().hour - 12 >= 0 ? "pm" : "am"}",
                                          "questionid": questionId,
                                        }).then((result) {
                                          if (widget.initFlow) {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DailyGoal(uid: widget.uid,)));
                                          } else {
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => UserQA(uid: widget.uid,)),);
                                          }
                                          contentInputController.clear();
                                        }).catchError((err) => print(err));
                                      } else {
                                        DateFormat fmt2 = DateFormat("EEEE, MMMM d, yyyy h:mm");
                                        Firestore.instance
                                            .collection("users")
                                            .document(widget.uid)
                                            .collection('responses')
                                            .add({
                                          "content": contentInputController.text,
//                        "description": taskDescripInputController.text,
                                          "timestamp": "${fmt2.format(DateTime.now())} ${DateTime
                                              .now()
                                              .hour - 12 >= 0 ? "pm" : "am"}",
                                          "questionid": questionId,
                                        })
                                            .then((result)
                                        {
//                                          if (DateTime.now().difference(quoteDate).compareTo(Duration(days: 1)) > 0) {
//                                            QuotePage(uid: widget.uid, initFlow: true); print('refreshing the stale page');
//                                          } else {print('continue onwards');}
                                          if (widget.initFlow) {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DailyGoal(uid: widget.uid, initFlow:true)));
                                          } else {
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => Home(uid: widget.uid,)),);
                                          }
                                          contentInputController.clear();
//                            taskDescripInputController.clear(),
                                        })
                                            .catchError((err) => print(err));
                                      }
                                    }
                                  },
                                ),

                              ],

                            ),
                          ),
                        ],
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
  //Method to get all questions
  Stream<QuerySnapshot> getAllQuestions() {
    Firestore fs = Firestore.instance;
    return fs.collection("questions").snapshots();
  }
}