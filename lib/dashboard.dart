import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/commonComponents/customDrawer.dart';
import 'package:my_first_app/dailymood.dart';
import 'package:my_first_app/home.dart';
import 'package:my_first_app/login.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'journal.dart';
import 'nugget.dart';
import 'dailyquote.dart';
import 'dailygoal.dart';
import 'dailyques.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title, this.uid}) : super(key: key); //update this to include the uid in the constructor
  final String title;
  final String uid; //include this
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
    const StaggeredTile.count(6, 2.5),
    const StaggeredTile.count(2, 3),
    const StaggeredTile.count(2, 3),
    const StaggeredTile.count(2, 3),
  ];

  appBarWidget() {
    return Positioned(
      top: -10,
      height: 170,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.lightBlueAccent, Colors.indigo[100]])),

      ),
    );
  }

  String formatDateTime(DateTime datetime) {
    return '${datetime.month}/${datetime.day}/${datetime.year}';
  }

  buildWidget() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 0),
        child: new StaggeredGridView.count(
          crossAxisCount: 6,

          staggeredTiles: _staggeredTiles,
          children: <Widget>[
            buildRoutine(),
            buildJournalRow(),
            buildQuestion(),
            buildQuote()
          ],
          mainAxisSpacing: 0.1,
          crossAxisSpacing: 0.1,
          padding: const EdgeInsets.all(1.0),
        ));
  }

  buildQuestion() {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
            elevation: 20.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: FlatButton(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 20,
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.question, size: 35,
                        color: Colors.orange),
                    Padding(padding: EdgeInsets.all(10),),
                    Text(
                      'Question of the Day',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              onPressed: () {

                HapticFeedback.lightImpact();
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    QuestionPage(uid: widget.uid, initFlow: false,)),);
              },
            )
        )
    );
  }

  buildRoutine() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Card(
            elevation: 20.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: FlatButton(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 20,
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.solidSun, size: 35,
                      color: Color(0xFFFDD835),),
                    Padding(padding: EdgeInsets.all(10),),
                    Text(
                      'View Daily Nugget',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    NuggetPage(uid: widget.uid, initFlow: false)),);
              },
            )
        )
    );
  }

  buildJournalRow() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Card(
            elevation: 20.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            child: FlatButton(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 20,
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.pencilAlt, size: 35,
                        color: Colors.blue),
                    Padding(padding: EdgeInsets.all(10),),
                    Text(
                      'Write a New Journal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    JournalPage(uid: widget.uid, initFlow: false,)),);
              },
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
//    return StreamBuilder<DocumentSnapshot>(
//        stream: getUser(),
//        builder: (BuildContext context,
//            AsyncSnapshot<DocumentSnapshot> snapshot) {
//          if (snapshot.hasError) {
//            return new Text('Error: ${snapshot.error}');
//          }
//          switch (snapshot.connectionState) {
//            case ConnectionState.waiting:
//              return
//                Scaffold(
//                  body: Container(),
//                );
//            default:
//              int quoteId;
//              DateTime quoteDate;
//              DateFormat fmt = DateFormat("M/dd/yyyy");
//              quoteId = int.parse("${snapshot.data['quoteid']}");
//              quoteDate = fmt.parse(snapshot.data['quotedate']);
//              print(DateTime.now().difference(quoteDate).compareTo(
//                  Duration(days: 1)));
//              if (DateTime.now().difference(quoteDate).compareTo(
//                  Duration(days: 1)) > 0) {
//                print("GREATER");
//              };
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    'Your Dashboard.\n${formatDateTime(DateTime.now())}',
                    textAlign: TextAlign.center,
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
                            colors: [
                              Colors.lightBlueAccent,
                              Colors.indigo[100]
                            ])),
                  ),
                ),
                drawer: CustomDrawer(
                  uid: widget.uid, context: context, current: "Dashboard",),
                body: ListView(
                  children: <Widget>[
                    Container(
                      height: 25,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                          image: DecorationImage(
                            image: ExactAssetImage('assets/calmAscent-logo1.png'),
                            fit: BoxFit.scaleDown,
                          )),
                    ),
                    Container(
                      child: Text('Review your daily routine.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange[300],
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
                      color: Colors.white70,
                      height: MediaQuery.of(context).size.height + 150,
                      child: Stack(children: <Widget>[
                        //appBarWidget(),
                      Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                        child: new StaggeredGridView.count(
                          crossAxisCount: 6,

                          staggeredTiles: _staggeredTiles,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Card(
                                    elevation: 20.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: FlatButton(
                                      child: Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width - 20,
                                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.solidSun, size: 35,
                                              color: Color(0xFFFDD835),),
                                            Padding(padding: EdgeInsets.all(10),),
                                            Text(
                                              'View Daily Nugget',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onPressed: () {
//                                        if (DateTime.now().difference(quoteDate).compareTo(Duration(days: 1)) > 0) {
//                                          QuotePage(uid: widget.uid, initFlow: true); print('refreshing the stale page');
//                                        } else {print('continue onwards');}
                                        HapticFeedback.lightImpact();
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            NuggetPage(uid: widget.uid, initFlow: false)),);
                                      },
                                    )
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Card(
                                    elevation: 20.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Colors.white,
                                    child: FlatButton(
                                      child: Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width - 20,
                                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.pencilAlt, size: 35,
                                                color: Colors.blue),
                                            Padding(padding: EdgeInsets.all(10),),
                                            Text(
                                              'Write a New Journal',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onPressed: () {
//                                        if (DateTime.now().difference(quoteDate).compareTo(Duration(days: 1)) > 0) {
//                                          QuotePage(uid: widget.uid, initFlow: true); print('refreshing the stale page');
//                                        } else {print('continue onwards');}
                                        HapticFeedback.lightImpact();
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            JournalPage(uid: widget.uid, initFlow: false,)),);
                                      },
                                    )
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                  elevation: 20.0,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: FlatButton(
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width -20,
                                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(FontAwesomeIcons.question, size: 35,
                                              color: Colors.orange),
                                          Padding(padding: EdgeInsets.all(10),),
                                          Text(
                                            'Question of the Day',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
//                                      if (DateTime.now().difference(quoteDate).compareTo(Duration(days: 1)) > 0) {
//                                        QuotePage(uid: widget.uid, initFlow: true); print('refreshing the stale page');
//                                      } else {print('continue onwards');}
                                      HapticFeedback.lightImpact();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                          QuestionPage(uid: widget.uid, initFlow: false,)),);
                                    },
                                  )
                              )
                          ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                  elevation: 20.0,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: FlatButton(
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width - 20,
                                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(FontAwesomeIcons.quoteLeft, size: 35,),
                                          Padding(padding: EdgeInsets.all(10),),
                                          Text(
                                            'Daily Quote',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
//                                      if (DateTime.now().difference(quoteDate).compareTo(Duration(days: 1)) > 0) {
//                                        QuotePage(uid: widget.uid, initFlow: true); print('refreshing the stale page');
//                                      } else {print('continue onwards');}
                                      HapticFeedback.lightImpact();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                          QuotePage(uid: widget.uid, initFlow: false)),);
                                    },
                                  )
                              )
                          )
                          ],
                          mainAxisSpacing: 0.1,
                          crossAxisSpacing: 0.1,
                          padding: const EdgeInsets.all(1.0),
                        )),
                      ]),
                    ),
                  ],
                ),
                bottomNavigationBar: BottomAppBar(
                  elevation: 0.0,
                  child: Container(
                    height: 20.0,

                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation
                    .centerDocked,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
//                    if (DateTime.now().difference(quoteDate).compareTo(Duration(days: 1)) > 0) {
//                      QuotePage(uid: widget.uid, initFlow: true); print('refreshing the stale page');
//                    } else {print('continue onwards');}
                    HapticFeedback.lightImpact();
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => HomePage(uid: widget.uid,)),);
                  },
                  tooltip: 'Add',
                  child: Icon(Icons.import_contacts),
                ),
              ); //this is the scaffold
          }
//        }
//    );
//  }
  buildQuote() {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
            elevation: 20.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: FlatButton(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 20,
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.quoteLeft, size: 35,),
                    Padding(padding: EdgeInsets.all(10),),
                    Text(
                      'Daily Quote',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    QuotePage(uid: widget.uid, initFlow: false)),);
              },
            )
        )
    );
  }

  Widget buildPage() {
    return ListView(
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          child: Text('Review your daily routine.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            ),
            ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.orange[300],
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
          color: Colors.white70,
          height: MediaQuery.of(context).size.height + 150,
          child: Stack(children: <Widget>[
            //appBarWidget(),
            buildWidget(),
          ]),
        ),
        ],
        );
  }
  Stream<DocumentSnapshot> getUser() {
    Firestore fs = Firestore.instance;
    return fs.collection('users').document(widget.uid).snapshots();
  }
  Stream<QuerySnapshot> getJournals() {
    print("GETTING");
    return Firestore.instance
        .collection("users")
        .document(widget.uid)
        .collection('journals')
        .snapshots();
  }
  Stream<QuerySnapshot> getMoods() {
    return Firestore.instance
        .collection("users")
        .document(widget.uid)
        .collection('dailymoods')
        .snapshots();
  }
}

