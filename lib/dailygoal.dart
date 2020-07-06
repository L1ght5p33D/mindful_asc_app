import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/dailymood.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/dashboard.dart';

class DailyGoal extends StatefulWidget {
  final String uid;
  final bool initFlow;
  DailyGoal({this.uid, this.initFlow});
  @override
  State<StatefulWidget> createState() {
    return new DailyGoalState();
  }
}

class DailyGoalState extends State<DailyGoal> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Daily Goal\nStep 4 of 5',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),

//          flexibleSpace: Container(
//            decoration: BoxDecoration(
//                gradient: LinearGradient(
//                    begin: Alignment.topLeft,
//                    end: Alignment.bottomRight,
//                    colors: <Color>[Colors.orangeAccent, Colors.orange])),
//          ),
      ),
      floatingActionButton: widget.initFlow ? FloatingActionButton(
        backgroundColor: Colors.white70,
        onPressed: () {
          HapticFeedback.lightImpact();Navigator.push(context,MaterialPageRoute(builder: (context) => DailyMood(uid: widget.uid, initFlow:true)),);
        },
        tooltip: 'Add',
        child: Text(
          'Skip',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
//                            Icon(Icons.arrow_forward, color: Colors.black),

      ) : Container(),
      body: ListView(

        children: <Widget>[
          Container(
            child: Text(
              'What brings you to the app today?',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
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
          const SizedBox(
            height: 15,
          ),
          Center(
            child: MaterialButton(
              color: Color(0xFF4FC1A6),
              child: Padding(child: Column(
                children: <Widget>[
                  Container(
                    width: 150,

                  ),
                  Icon(FontAwesomeIcons.lightbulb, size:30,
                    color: Colors.white70,
                  ),
                  Text(
                    "get inspired",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              elevation: 8.0, // New code
              onPressed:() {
                HapticFeedback.lightImpact();pushToFirestore("get inspired");
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: MaterialButton(
              color: Color(0xFFFA6555),
              child: Padding(child: Column(
                children: <Widget>[
                  Container(width: 150,),
                  Icon(FontAwesomeIcons.laughBeam, size:30,
                    color: Colors.white70,
                  ),
                  Text(
                    "be happier",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              elevation: 8.0, // New code
              onPressed:() {
                HapticFeedback.lightImpact();pushToFirestore("be happier");
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(

            child: MaterialButton(
              color: Color(0xFF429BED),
              child: Padding(child: Column(
                children: <Widget>[
                  Container(width: 150,),
                  Icon(FontAwesomeIcons.heart, size:30,
                    color: Colors.white70,
                  ),
                  Text(
                    "find harmony",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              elevation: 8.0, // New code
              onPressed:() {
                HapticFeedback.lightImpact();pushToFirestore("find harmony");
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: MaterialButton(
              color: Color(0xFFF6C747),
              child:Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Column(
                  children: <Widget>[
                    Container(width: 150,
                    ),
                    Icon(FontAwesomeIcons.dizzy, size:30,
                      color: Colors.white70,
                    ),
                    Text(
                      " lower stress ",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              elevation: 0.0, // New code
              highlightElevation: 2,
              splashColor: Colors.white10,
              onPressed:() {
                HapticFeedback.lightImpact();pushToFirestore("lower stress");
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(

            child: MaterialButton(
              color: Color(0xFF7C538C),
              child: Padding(
                child: Column(
                  children: <Widget>[
                    Container(width: 150,),
                    Icon(FontAwesomeIcons.flushed, size:30,
                      color: Colors.white70,
                    ),

                    Text(
                      "reduce anxiety",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              elevation: 8.0, // New code
              onPressed:() {
                HapticFeedback.lightImpact();pushToFirestore("reduce anxiety");
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: MaterialButton(
              color: Color(0xFFB1736C),
              child: Padding(
                child: Column(
                  children: <Widget>[
                    Container(width: 150,),
                    Icon(FontAwesomeIcons.sadTear, size:30,
                      color: Colors.white70,
                    ),

                    Text(
                      "improve focus",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              elevation: 8.0, // New code
              onPressed:() {
                HapticFeedback.lightImpact(); pushToFirestore("improve focus");
              },
            ),
          ),
        ],
      ),
    );
  }
  void pushToFirestore(String goal) async {
    QuerySnapshot allGoal = await Firestore.instance.collection("users").document(widget.uid).collection("dailygoals").getDocuments();
    for (DocumentSnapshot doc in allGoal.documents) {
      if (doc["date"] == "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}") {
        doc.reference.updateData({
          "dailygoal": goal,
        });
        if (widget.initFlow) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DailyGoal(uid: widget.uid,)));
        } else {
          Navigator.push(context,MaterialPageRoute(builder: (context) => Home(uid: widget.uid,)),);
        }
        return;
      }
    }
    Firestore.instance.collection("users").document(widget.uid).collection("dailygoals").document().setData({
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "dailygoal" : goal,
    });
    if (widget.initFlow) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => DailyMood(uid: widget.uid, initFlow:true)));
    } else {
      Navigator.push(context,MaterialPageRoute(builder: (context) => Home(uid: widget.uid,)),);
    }
  }
}