import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  TaskPage({@required this.content});

  final content;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Today's Wisdom"),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.blueGrey[100]),
          padding: EdgeInsets.all(10.0),
          child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
//                Text(content),
                Center(

                  child: Text(
                    "Feelings come and go like clouds in a windy sky. Conscious breathing is my anchor.",
                    style: TextStyle(

                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                    ),
                ),

                RaisedButton(
                    child: Text('Back To HomeScreen'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.black,
                    onPressed: () => Navigator.pop(context)),
              ]),
        ));
  }
}
