import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/commonComponents/nuggetCard.dart';

import 'commonComponents/customDrawer.dart';

class UserNuggets extends StatefulWidget{
  UserNuggets({this.uid});
  final String uid;
  @override
  State<StatefulWidget> createState() {
    return new UserNuggetsState();
  }

}

class UserNuggetsState extends State<UserNuggets> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
      stream: getNuggets(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            List<NuggetCard> items = snapshot.data.documents.map((doc) {
              return NuggetCard(
                name: "${doc["name"]}",
                nuggetContent: "${doc["content"]}",
                exercise: "${doc["exercise"]}",
                id: "${doc["id"]}",
                uid: widget.uid,
                timestamp: "${doc["timestamp"]}",
              );
            }).toList();
            items.sort((a, b) {
              int aId = int.parse(a.id);
              int bId = int.parse(b.id);
              return aId.compareTo(bId);
            });
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Your Nugget Feed",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
//              drawer: CustomDrawer(context: context, uid: widget.uid, current: "Nuggets",),
              body: ListView(
                children: items,
              ),
            );
        }
      },
    );
  }
  Stream<QuerySnapshot> getNuggets() {
    Firestore fs = Firestore.instance;
    return fs.collection('users').document(widget.uid).collection('nuggets').snapshots();
  }
}
