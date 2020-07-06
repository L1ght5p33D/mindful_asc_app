import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/dailyques.dart';
import 'package:my_first_app/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class JournalPage extends StatefulWidget {
  JournalPage({Key key, this.content, this.uid, this.doc, this.initFlow}) : super(key: key); //update this to include the uid in the constructor
  final String content;
  final String uid; //include this
  final DocumentSnapshot doc;
  final bool initFlow;

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journal Entry',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),

      ),
      floatingActionButton: widget.initFlow ? FloatingActionButton(
        backgroundColor: Colors.white70,
        onPressed: () {
          HapticFeedback.lightImpact(); Navigator.push(context,MaterialPageRoute(builder: (context) => QuestionPage(uid: widget.uid, initFlow: true,)),);
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
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.lightBlueAccent, Colors.indigo[100]])),
          ),
          Center(
              child: ListView(
                children: <Widget>[

                  Container(
                    child: TextField(
                      maxLines: 12,
                      decoration: InputDecoration.collapsed(
                          hintText: "Write your journal entry here"),
                      controller: contentInputController,
                    ),


//                    Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.baseline,
//                    textBaseline: TextBaseline.alphabetic,
//                  )


                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 21),
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
                          "Save your journal",
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
                          widget.doc.reference.updateData({
                            "content": contentInputController.text,
                            "timestamp": "${fmt.format(DateTime.now())} ${DateTime.now().hour - 12 >= 0 ? "pm" : "am"}",
                          }).then((result) => {
                            if (widget.initFlow) {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => QuestionPage(uid: widget.uid, initFlow: true,)),),
                            }
                            else{
                            Navigator.push(context,MaterialPageRoute(builder: (context) => Home(uid: widget.uid,)),),
                            }
                            , contentInputController.clear(),
                          }).catchError((err) => print(err));
                        } else {
                          Firestore.instance
                              .collection("users")
                              .document(widget.uid)
                              .collection('journals')
                              .add({
                            "content": contentInputController.text,
                            "timestamp": "${fmt.format(DateTime.now())} ${DateTime
                                .now()
                                .hour - 12 >= 0 ? "pm" : "am"}",
                          })
                              .then((result) =>
                          {
                            if (widget.initFlow) {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => QuestionPage(uid: widget.uid, initFlow: true,)),),
                            }
                            else{
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Home(uid: widget.uid,)),),
                            }
                            , contentInputController.clear(),
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
}
