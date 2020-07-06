import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../task.dart';
import '../journal.dart';

class CustomCard extends StatelessWidget {
  CustomCard({this.content, this.timestamp, this.uid});

  final content;
  final timestamp;
  final uid;


  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        timestamp,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.grey,size:10),
                        onPressed: () {
                          editJournal(context);
                        },
                      ),
                     IconButton(
                        icon: Icon(Icons.delete, color: Colors.grey,size:10),
                        onPressed: () {
                          deleteJournal(context);
                        },
                      ),
                    ],
                  ),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),

//                FlatButton(
//                    child: Text("See More"),
//                    onPressed: () {
//                      /** Push a named route to the stcak, which does not require data to be  passed */
//                      // Navigator.pushNamed(context, "/task");
//
//                      /** Create a new page and push it to stack each time the button is pressed */
//                      // Navigator.push(context, MaterialPageRoute<void>(
//                      //   builder: (BuildContext context) {
//                      //     return Scaffold(
//                      //       appBar: AppBar(title: Text('My Page')),
//                      //       body: Center(
//                      //         child: FlatButton(
//                      //           child: Text('POP'),
//                      //           onPressed: () {
//                      //             Navigator.pop(context);
//                      //           },
//                      //         ),
//                      //       ),
//                      //     );
//                      //   },
//                      // ));
//
//                      /** Push a new page while passing data to it */
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => TaskPage(content: content)));
//                    }),
//                Row(
//                  children: <Widget>[
//                    IconButton(
//                      icon: Icon(Icons.edit, color: Colors.blue,),
//                      onPressed: () {
//                        editJournal(context);
//                      },
//                    ),
//                    IconButton(
//                      icon: Icon(Icons.delete, color: Colors.amberAccent,),
//                      onPressed: () {
//                        deleteJournal(context);
//                      },
//                    ),
//                  ],
//                )
                ],
              )),
        ));
  }
  void editJournal(BuildContext context) {
    Firestore.instance
        .collection("users")
        .document(uid)
        .collection('journals').getDocuments().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.documents) {
        if ("${doc['content']}" == "$content" &&
            "${doc['timestamp']}" == "$timestamp") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JournalPage(content: content, uid: uid, doc: doc,)));
        }
      }
    });
  }
  void deleteJournal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm"),
            content: Text("Are you sure you want to delete?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Delete"),
                onPressed: () {
                  Firestore.instance
                      .collection("users")
                      .document(uid)
                      .collection('journals').getDocuments().then((snapshot) {
                    for (DocumentSnapshot doc in snapshot.documents) {
                      if ("${doc['content']}" == "$content" &&
                          "${doc['timestamp']}" == "$timestamp") {
                        doc.reference.delete();
                      }
                    }
                  });
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
