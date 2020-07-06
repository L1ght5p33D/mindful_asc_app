import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/completed.dart';
import 'package:my_first_app/dailygoal.dart';
import 'package:my_first_app/dashboard.dart';
import 'package:flutter/services.dart';

class DailyMood extends StatefulWidget {
  final String uid;
  final bool initFlow;
  DailyMood({this.uid, this.initFlow});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new DailyMoodState();
  }

}

class DailyMoodState extends State<DailyMood> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
//                        leading: new Container(),
        centerTitle: true,
        title: Text(
          'Your Daily Mood.\nStep 5 of 5',
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
          HapticFeedback.lightImpact();Navigator.push(context,MaterialPageRoute(builder: (context) => CompletedPage(uid: widget.uid,)),);
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
              'How do you feel today?',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontSize: 18.0,
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
            child: RaisedButton(
//              color: Color(0xFF4FC1A6),
              child: Padding(child: Column(
                children: <Widget>[
                  Container(
                    width: 75,
                  ),
                  Icon(FontAwesomeIcons.smileBeam, size:40),
//                  Text(
//                    "Very Happy",
//                    style: TextStyle(
//                      fontFamily: 'Montserrat',
//                      color: Colors.black,
//                      fontSize: 15.0,
//                      fontWeight: FontWeight.bold,
//                    ),
//                    textAlign: TextAlign.center,
//                  )
                ],
              ),
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              elevation: 8.0, // New code
              onPressed:() {
                HapticFeedback.lightImpact();pushToFirestore("Very Happy");
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: RaisedButton(
              child: Padding(child: Column(
                children: <Widget>[
                  Container(width: 75,),
                  Icon(FontAwesomeIcons.smile, size:40),
//                  Text(
//                    "Happy",
//                    style: TextStyle(
//                      fontFamily: 'Montserrat',
//                      color: Colors.black,
//                      fontSize: 15.0,
//                      fontWeight: FontWeight.bold,
//                    ),
//                    textAlign: TextAlign.center,
//                  )
                ],
              ),
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              elevation: 8.0, // New code
              onPressed:() {
                HapticFeedback.lightImpact();pushToFirestore("Happy");
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: RaisedButton(
              child: Padding(child: Column(
                children: <Widget>[
                  Container(width: 75,),
                  Icon(FontAwesomeIcons.meh, size:40),
//                  Text(
//                    "Meh",
//                    style: TextStyle(
//                      fontFamily: 'Montserrat',
//                      color: Colors.black,
//                      fontSize: 15.0,
//                      fontWeight: FontWeight.bold,
//                    ),
//                    textAlign: TextAlign.center,
//                  )
                ],
              ),
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              elevation: 8.0, // New code
              onPressed:() {
                HapticFeedback.lightImpact();pushToFirestore("Meh");
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: RaisedButton(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Column(
                  children: <Widget>[
                    Container(width: 75,),
                    Icon(FontAwesomeIcons.frown, size:40),
//                    Text(
//                      "Sad",
//                      style: TextStyle(
//                        fontFamily: 'Montserrat',
//                        color: Colors.black,
//                        fontSize: 15.0,
//                        fontWeight: FontWeight.bold,
//                      ),
//                      textAlign: TextAlign.center,
//                    )
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              elevation: 8.0, // New code
              onPressed:() {
                HapticFeedback.lightImpact();pushToFirestore("Sad");
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: RaisedButton(
              child: Padding(
                child: Column(
                  children: <Widget>[
                    Container(width: 75,),
                    Icon(FontAwesomeIcons.sadTear, size:40),

//                    Text(
//                      "Very Sad",
//                      style: TextStyle(
//                        fontFamily: 'Montserrat',
//                        color: Colors.black,
//                        fontSize: 15.0,
//                        fontWeight: FontWeight.bold,
//                      ),
//                      textAlign: TextAlign.center,
//                    )
                  ],
                ),
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              elevation: 8.0, // New code
              onPressed:() {
                HapticFeedback.lightImpact();pushToFirestore("Very Sad");
              },
            ),
          ),
        ],
      ),
    );
  }
  void pushToFirestore(String emotion) async {
    QuerySnapshot allMood = await Firestore.instance.collection("users").document(widget.uid).collection("dailymoods").getDocuments();
    for (DocumentSnapshot doc in allMood.documents) {
      if (doc["date"] == "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}") {
        doc.reference.updateData({
          "mood": emotion,
        });
        if (widget.initFlow) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CompletedPage(uid: widget.uid,)));
        } else {
          Navigator.push(context,MaterialPageRoute(builder: (context) => Home(uid: widget.uid,)),);
        }         return;
      }
    }
    Firestore.instance.collection("users").document(widget.uid).collection("dailymoods").document().setData({
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "mood" : emotion,
    });
    if (widget.initFlow) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CompletedPage(uid: widget.uid,)));
    } else {
      Navigator.push(context,MaterialPageRoute(builder: (context) => Home(uid: widget.uid,)),);
    }
  }
}