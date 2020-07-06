import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/usernuggets.dart';

class NuggetViewer extends StatefulWidget {
  NuggetViewer({this.uid, this.name, this.id, this.content, this.exercise});
  final uid;
  final name;
  final id;
  final content;
  final exercise;
  @override
  State<StatefulWidget> createState() {
    return new NuggetViewerState();
  }

}

class NuggetViewerState extends State<NuggetViewer>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

//                        leading: new Container(),
        centerTitle: true,
        title: Text(
          '${widget.name}',
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
                        'nugget',
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
                    '${makePars(widget.content)}',
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
            child: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.bolt, size:30, color: Colors.grey),
                      Text(
                        'exercise.',
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
                    "${makePars(widget.exercise)}",
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
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Container(
          height: 20.0,

        ),
      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: Colors.white70,
//        onPressed: () {
//          HapticFeedback.lightImpact(); Navigator.push(context,MaterialPageRoute(builder: (context) => UserNuggets(uid: widget.uid,)),);
//        },
//        child: Text(
//          'Done',
//          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//        ),
//      ),

//                      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//                      floatingActionButton: FloatingActionButton(
//                        onPressed: () {
//                          HapticFeedback.lightImpact(); Navigator.push(context,MaterialPageRoute(builder: (context) => JournalPage(uid: widget.uid,)),);
//                        },
//                        tooltip: 'Add journal',
//                        child: Icon(Icons.edit),
//                      ),
    );

  }

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

}