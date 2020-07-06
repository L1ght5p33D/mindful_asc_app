import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/journal.dart';
import 'commonComponents/customCard.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.content, this.uid}) : super(key: key); //update this to include the uid in the constructor
  final String content;
  final String uid; //include this

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Your Journals",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20),
        ),
      ),
      body: Center(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.lightBlueAccent, Colors.indigo[100]])),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("users")
                  .document(widget.uid)
                  .collection('journals')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    DateFormat fmt = DateFormat("EEEE, MMMM d, yyyy h:mm");
                    List<CustomCard> listItems = snapshot.data.documents
                        .map((DocumentSnapshot document) {
//                      print("HERE");
//                      print(document.data);
                      if (document['timestamp'] == null || document['content'] == null) {
                        return CustomCard();
                      }
                      return new CustomCard(
                        content: document['content'],
//                          description: document['description'],
                        timestamp: document['timestamp'].toString(),
                        uid: widget.uid,
                      );
                    }).toList();
                    listItems.sort((a, b) {
                      DateTime aDate = fmt.parse(a.timestamp);
                      DateTime bDate = fmt.parse(b.timestamp);
                      return bDate.compareTo(aDate);
                    });
                    return new ListView(
                        children: listItems
                    );
                }
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => JournalPage(uid: widget.uid,initFlow: false,)),);
        },
        tooltip: 'Add',
        child: Icon(Icons.edit),
      ),
    );
  }
}
