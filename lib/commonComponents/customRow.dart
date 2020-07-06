import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomRow extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String link;
  final Widget route;
  const CustomRow({
    Key key,
    this.iconData,
    this.title,
    this.link,
    this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            color: Colors.black12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(

            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue,
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              Spacer(),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 35,
                  color: Colors.blue,
                ),
                onPressed: () => link != null ?  _launchURL() : Navigator.push(context, MaterialPageRoute(builder: (context) => route),),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _launchURL() async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

}