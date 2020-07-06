import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/commonComponents/customDrawer.dart';
import 'package:my_first_app/commonComponents/questionCard.dart';
import 'package:my_first_app/dailyques.dart';

class UserQA extends StatefulWidget {
  UserQA({this.uid});
  final String uid;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new UserQAState();
  }

}

class UserQAState extends State<UserQA> {
  TextEditingController contentInputController;
  @override
  Widget build(BuildContext context) {
    contentInputController = new TextEditingController();
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
            DateFormat fmt2 = DateFormat("M/dd/yyyy");
//            print(snapshot.data.data);
            if (snapshot.data.data == null || snapshot.data['questionid'] == null || snapshot.data['questiondate'] == null) {
              String newDate = "${fmt2.format(DateTime.now())}";
              questionId = 1;
              questionDate = fmt2.parse(newDate);
              Firestore.instance
                  .collection("users")
                  .document(widget.uid).updateData({
                "questionid": questionId,
                "questiondate": newDate
              });
            } else {
              questionId = int.parse("${snapshot.data['questionid']}");
              questionDate = fmt2.parse(snapshot.data['questiondate']);
              print(questionDate);
              print(DateTime.now());
              print(DateTime.now().difference(questionDate).compareTo(Duration(days: 1)));
              if (DateTime.now().difference(questionDate).compareTo(Duration(days: 1)) > 0) {
                print("GREATER");
                print(questionId);
                String newDate = "${fmt2.format(DateTime.now())}";
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
                    case ConnectionState.waiting:return
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
//                      print(l);
                      Map<String, Map<String, String>> questions = {};
                      l.forEach((item) => questions[item.keys.toList().first] = item.values.toList().first);
//                      print(questions);
                      Map<String, String> question = questions["$questionId"];
                      return StreamBuilder<QuerySnapshot>(
                        stream: getResponses(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> responses) {
                          if (responses.hasError) {
                            return new Text('Error: ${snap.error}');
                          }
                          switch (responses.connectionState) {
                            case ConnectionState.waiting: return
                              Scaffold(
                                body: Container(),
                              );
                            default:
                              List<QuestionCard> cards = responses.data.documents.map((DocumentSnapshot snap) {
                                if (snap["timestamp"] == null || snap["content"] == null || snap["questionid"] == null) {
                                  return QuestionCard();
                                }
//                                print(questions);
                                print(snap["questionid"]);
                                Map<String, String> question = questions[snap["questionid"].toString()];
//                                print(question);
                                return QuestionCard(
                                  question: "${question["content"]}",
                                  timestamp: "${snap["timestamp"]}",
                                  answer: "${snap["content"]}",
                                  uid: widget.uid,
                                );
                              }).toList();
                              cards.sort((a, b) {
                                DateTime aDate = fmt.parse(a.timestamp);
                                DateTime bDate = fmt.parse(b.timestamp);
                                return bDate.compareTo(aDate);
                              });
                              return Scaffold(
                                appBar: AppBar(
                                  title: Text(
                                    'Your Q & A',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
//                                drawer: CustomDrawer(context: context, uid: widget.uid, current: "QA",),
                                body: ListView(
                                  children: cards,
                                ),
//                                floatingActionButton: FloatingActionButton(
//                                  backgroundColor: Colors.white70,
//                                  onPressed: () {
//                                    HapticFeedback.lightImpact(); Navigator.push(context,MaterialPageRoute(builder: (context) => QuestionPage(uid: widget.uid, initFlow: false,)),);
//                                  },
//                                  tooltip: 'Add',
//                                  child: Text(
//                                    'Skip',
//                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                                  ),
////                            Icon(Icons.arrow_forward, color: Colors.black),
//
//                                ),
                              );
                          }
                        },
                      );
                  }
                }
            );
        }
      },
    );
  }
  Stream<DocumentSnapshot> getUser() {
    Firestore fs = Firestore.instance;
    return fs.collection('users').document(widget.uid).snapshots();
  }
  //Method to get all questions
  Stream<QuerySnapshot> getAllQuestions() {
    Firestore fs = Firestore.instance;
    return fs.collection("questions").snapshots();
  }
  Stream<QuerySnapshot> getResponses() {
    Firestore fs = Firestore.instance;
    return fs.collection('users').document(widget.uid).collection('responses').snapshots();
  }
}