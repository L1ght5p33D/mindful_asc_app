import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/commonComponents/customDrawer.dart';
import 'package:my_first_app/dashboard.dart';
import 'commonComponents/customCircle.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/settings.dart';

class ProgressPage extends StatefulWidget {
  ProgressPage({this.uid});
  final String uid;
  @override
  State<StatefulWidget> createState() {
    return new ProgressPageState();
  }
}

class ProgressPageState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getViewedInfo(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, int>> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return
            Scaffold(
              body: Container(),
            );
            break;
          default:
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white70,
//                leading: IconButton(
//                    icon: Icon(
//                      Icons.settings,
//                      size: 30,
//                      color: Colors.grey.shade400,
//                    ),
//                    onPressed: () {
//                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen(uid:widget.uid,)));
//                    }),
                centerTitle: true,
                title: Text(
                  'Your Progress',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
//              drawer: CustomDrawer(context: context, uid: widget.uid, current: "Progress"),
              body: Container(
                /* decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.topCenter,
                colors: [
              Colors.teal.shade600,
              Colors.teal.shade300,
            ])), */
                child: ListView(
                  children: <Widget>[
//            Divider(
//              color: Colors.teal,
//              thickness: 3,
//            ),
//                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
//                          child: Text(
//                            'Status',
//                            style: TextStyle(
//                              fontSize: 25,
//                              fontWeight: FontWeight.bold,
//                              color: Colors.black,
//                              fontFamily: 'Montserrat',
//                            ),
//                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomCircle(
                          innerIcon: FontAwesomeIcons.solidSun,
                          innerCount: '${snapshot.data["nuggetCounter"]}',
                          innerText: 'NUGGETS',
                          outterText: 'Nuggets Viewed',
                          borderColor:Colors.deepOrangeAccent,
                          backgroundColor: Colors.deepOrangeAccent.shade100,
                        ),
                        CustomCircle(
                          innerIcon: FontAwesomeIcons.bolt,
                          innerCount: '${snapshot.data["currentStreak"]}',
                          innerText: 'DAYS',
                          outterText: 'Current Streak',
                          borderColor:Colors.blue,
                          backgroundColor: Colors.blue.shade100,
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomCircle(
                          innerIcon: Icons.mood,
                          innerCount: '${snapshot.data["moodCounter"]}',
                          innerText: 'MOOD',
                          outterText: 'Mood Check-Ins',
                          borderColor:Colors.green,
                          backgroundColor: Colors.green.shade100,
                        ),
                        CustomCircle(
                          innerIcon: Icons.edit,
                          innerCount: '${snapshot.data["journalCounter"]}',
                          innerText: 'JOURNALS',
                          outterText: 'Journal Entries',
                          borderColor:Colors.amber,
                          backgroundColor: Colors.amber.shade100,
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
//                    InkWell(
//                      onTap: () {
//                      HapticFeedback.lightImpact();
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => Home(uid: widget.uid,)),
//                      );
//                    },
//
//                      child: Container(
//                        margin:EdgeInsets.fromLTRB(50, 0,50,0),
//                        padding: EdgeInsets.symmetric(vertical: 19.0),
//                        width: MediaQuery.of(context).size.width / 2.5,
//                        decoration: BoxDecoration(
//                          color: Colors.indigo[50],
//                          borderRadius: BorderRadius.circular(35),
//                        ),
//                        child: Center(
//                          child: Text(
//                            "Return to Dashboard",
//                            style: TextStyle(
//                              fontWeight: FontWeight.bold,
//                              color: Colors.black,
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
  Future<Map<String, int>> getViewedInfo() async {
    DateFormat fmt = DateFormat("M/dd/yyyy");
    Map<String, int> values = {};
    QuerySnapshot allMood = await Firestore.instance.collection("users").document(widget.uid).collection("dailymoods").getDocuments();
    QuerySnapshot allNuggets = await Firestore.instance.collection("users").document(widget.uid).collection("nuggets").getDocuments();
    QuerySnapshot allJournals = await Firestore.instance.collection("users").document(widget.uid).collection('journals').getDocuments();
    DocumentSnapshot dateCounter = await Firestore.instance.collection("users").document(widget.uid).get();
    values["moodCounter"] = allMood.documents.length;
    values["nuggetCounter"] = allNuggets.documents.length;
    values["journalCounter"] = allJournals.documents.length;
    if (dateCounter["lastViewed"] != null && dateCounter["currentStreak"] != null) {
      if (fmt.parse("${dateCounter["lastViewed"]}").compareTo(fmt.parse(fmt.format(DateTime.now()))) == 0) {
        values["currentStreak"] = int.parse("${dateCounter["currentStreak"]}");
      } else if (fmt.parse("${dateCounter["lastViewed"]}").add(Duration(days: 2)).isBefore(fmt.parse(fmt.format(DateTime.now()))) || fmt.parse("${dateCounter["lastViewed"]}").add(Duration(days: 2)).isAtSameMomentAs(fmt.parse(fmt.format(DateTime.now())))) {
        int streak = 1;
        values["currentStreak"] = streak;
        dateCounter.reference.updateData({
          "lastViewed": fmt.format(DateTime.now()),
          "currentStreak": streak,
        });
      } else {
        int streak = int.parse("${dateCounter["currentStreak"]}") + 1;
        values["currentStreak"] = streak;
        dateCounter.reference.updateData({
          "lastViewed": fmt.format(DateTime.now()),
          "currentStreak": streak,
        });
      }
    } else {
      values["currentStreak"] = 1;
      dateCounter.reference.updateData({
        "lastViewed": fmt.format(DateTime.now()),
        "currentStreak": "1",
      });
    }
    if (dateCounter["lastViewed"] != null && dateCounter["totalDays"] != null) {
      if (fmt.parse("${dateCounter["lastViewed"]}").compareTo(fmt.parse(fmt.format(DateTime.now()))) == 0) {
        values["totalDays"] = int.parse("${dateCounter["totalDays"]}");
      } else {
        int streak = int.parse("${dateCounter["totalDays"]}") + 1;
        values["totalDays"] = streak;
        dateCounter.reference.updateData({
          "lastViewed": fmt.format(DateTime.now()),
          "totalDays": streak,
        });
      }
    } else {
      values["totalDays"] = 1;
      dateCounter.reference.updateData({
        "lastViewed": fmt.format(DateTime.now()),
        "totalDays": "1",
      });
    }
    return values;
  }
}