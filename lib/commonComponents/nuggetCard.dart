import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/nuggetviewer.dart';

class NuggetCard extends StatelessWidget {
  NuggetCard({this.nuggetContent, this.timestamp, this.uid, this.id, this.name, this.exercise});
  final nuggetContent;
  final timestamp;
  final String uid;
  final id;
  final name;
  final exercise;


  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact(); Navigator.push(context,MaterialPageRoute(builder: (context) => NuggetViewer(uid: uid, name: name, content: nuggetContent, exercise: exercise,)),);
          },
          child: Container(
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
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.indigo[100],
                    child: Text("$id",
                      style: TextStyle(color: Colors.black),
                  )),
                  Padding(padding: EdgeInsets.all(5),),

                  Flexible(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("$name", style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            )),
                            Text("$timestamp", style: TextStyle(
                              fontSize: 15,
                            )),
                          ],
                        ),

                        Text(
                          "$nuggetContent", maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
          ),
        )
    );
  }
}