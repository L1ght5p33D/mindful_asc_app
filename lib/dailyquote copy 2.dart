import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/dashboard.dart';
import 'package:my_first_app/nugget.dart';
import 'package:share/share.dart';

class QuotePage extends StatefulWidget {
  final String uid;
  final bool initFlow;
  QuotePage({this.uid, this.initFlow});
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
          case ConnectionState.waiting: return
              Scaffold(
                body: Container(),
              );
          default:
            int quoteId;
            DateTime quoteDate;
            DateFormat fmt = DateFormat("M/dd/yyyy");
//            print(snapshot.data.data);
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
                  case ConnectionState.waiting: return
                    Scaffold(
                      body: Container(),
                    );
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
//                    print(l);
                    Map<String, Map<String, String>> quotes = {};
                    l.forEach((item) => quotes[item.keys.toList().first] = item.values.toList().first);
//                    print(quotes);
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
                          Align(
                            alignment: Alignment.topCenter,
                            child: SafeArea(
                              child: widget.initFlow ? Container(

//                              margin: EdgeInsets.fromLTRB(150,50,0,0),

                                child: Text('Welcome!  Let\'s start your daily routine.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10.0),
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
                              ) :Container(),
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
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: RaisedButton(
                              onPressed: () => Share.share("Here is the daily quote from the app calmAscent:\n${quote["content"]}"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Icon(Icons.share),
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

                      floatingActionButton: widget.initFlow ? FloatingActionButton(
                        backgroundColor: Colors.white70,
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          if (widget.initFlow) {
                            Navigator.push(context,FadeRoute(page: NuggetPage(uid: widget.uid,initFlow: true,)),);
                          }
                          else {
                            Navigator.push(context,FadeRoute(page: Home(uid: widget.uid,)),);
                          }
                        },
                        child: Text(
                          'Start',
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
class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}