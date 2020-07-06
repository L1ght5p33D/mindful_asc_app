
import 'package:flutter/material.dart';

class CustomCircle extends StatelessWidget {
  final IconData innerIcon;
  final String innerCount;
  final String innerText;
  final String outterText;
  final Color borderColor, backgroundColor;

  const CustomCircle(
      {Key key,
        this.innerIcon,
        this.innerCount,
        this.innerText,
        this.outterText,
        this.backgroundColor,
        this.borderColor,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(

          decoration: BoxDecoration(

            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: 2,
            ),

          ),

          child: CircleAvatar(
            backgroundColor: backgroundColor.withOpacity(0.2),
            radius: 50,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      innerIcon,
                      color: borderColor,
                      size: 35,
                    ),
                    Text(
                      innerCount,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    Text(
                      innerText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height:10),
        Text(
          outterText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Montserrat',
          ),
        ),
      ],
    );
  }
}
