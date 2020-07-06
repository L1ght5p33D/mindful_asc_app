import 'dart:math';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/dashboard.dart';
import 'package:my_first_app/nugget.dart';
import 'home.dart';
import 'journal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class QuotePage extends StatefulWidget {
  final String uid;
  QuotePage({this.uid});
  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  var picNumber = Random().nextInt(13) +1;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: getUser(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return new Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Loading();
              default:
                int quoteId;
                DateTime quoteDate;
                DateFormat fmt = DateFormat("M/dd/yyyy");
                print(snapshot.data.data);
                if (snapshot.data.data == null || snapshot.data['quoteid'] == null || snapshot.data['quotedate'] == null) {
                  String newDate = "${fmt.format(DateTime.now())}";
                  quoteId = 1;
                  quoteDate = fmt.parse(newDate);
                  Firestore.instance
                    .collection("users")
                    .document(widget.uid).updateData({
                  "quoteid": quoteId,
                  "quotedate": newDate
                  });
                } else {
                  quoteId = int.parse("${snapshot.data['quoteid']}");
                  quoteDate = fmt.parse(snapshot.data['quotedate']);
                  print(quoteDate);
                  print(DateTime.now());
                  print(DateTime.now().difference(quoteDate).compareTo(Duration(days: 1)));
                  if (DateTime.now().difference(quoteDate).compareTo(Duration(days: 1)) > 0) {
                    print("GREATER");
                    print(quoteId);
                    String newDate = "${fmt.format(DateTime.now())}";
                    quoteId++;
                    print(quoteId);
                    Firestore.instance
                      .collection("users")
                      .document(widget.uid).updateData({
                    "quoteid": quoteId,
                    "quotedate": newDate
                      });
                  }
                  }
                  return StreamBuilder<QuerySnapshot>(
                    stream: getAllQuotes(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
                      if (snap.hasError) {
                        return new Text('Error: ${snap.error}');
                        }
                      switch (snap.connectionState) {
                        case ConnectionState.waiting: return Loading();
                        default:
                        List<Map<String,Map<String, String>>> l = snap.data.documents.map((DocumentSnapshot quote) {
                          return {
                            "${quote['id']}" : {
                            "name":"${quote['name']}",
                            "content": "${quote['content']}",
                            "exercise": "${quote['exercise']}",
                            },
                          };
                        }).toList();
                        print(l);
                        Map<String, Map<String, String>> quotes = {};
                        l.forEach((item) => quotes[item.keys.toList().first] = item.values.toList().first);
                        print(quotes);
                        Map<String, String> quote = quotes["$quoteId"];
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
                              image: AssetImage('assets/pic$picNumber.jpeg'),
                              fit: BoxFit.cover
                              )
                              ),
                            ),
                            Center(
                              child: Container(
                                child: Text('${quote["content"]}',
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
                      ),
                        Positioned(
                          child: AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,

                          ),
                        ),
                        ],

                        ),
                          floatingActionButton: FloatingActionButton(
                            backgroundColor: Colors.white70,
                            onPressed: () {
                              HapticFeedback.lightImpact(); Navigator.push(context,MaterialPageRoute(builder: (context) => NuggetPage(uid: widget.uid,)),);
                            },
                            tooltip: 'Add',
                            child: Text(
                              'Next',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                             ),
//                            Icon(Icons.arrow_forward, color: Colors.black),

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
  //Method to get all quotes
  Stream<QuerySnapshot> getAllQuotes() {
    Firestore fs = Firestore.instance;
    return fs.collection("quotes").snapshots();
  }
}
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SpinKitChasingDots(
              duration: Duration(
                seconds: 2,
              ),

              color: Colors.black38.withOpacity(0.1),
            ),
          )),
    );
  }
}