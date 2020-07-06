import 'package:flutter/cupertino.dart'; //should this be Material?
import 'package:flutter/material.dart';
import 'splash-model.dart';
import 'color.dart';

import 'login.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController _pagecontroller;
  int currentPage = 0;

  List<SplashModel> welcomeData = [
    SplashModel(
        header: "Welcome!",
        title: "Get all the benefits of mindfulness\nin 5 minutes a day",
        description: "Sign up for free and receive bite-sized  mindfulness and self-care content on your daily feed.  Change your outlook and mental health in minutes a day! ",
        img: "assets/calmAscent_logo_lt_blue.png"),
    SplashModel(
        header: "Enhance your perspective",
        title: "Your mental health and mindfulness companion",
        description:"We are a team of educators, entrepreneurs and mindfulness experts that have produced high quality content  in mindfulness, self-care and practical life philosophy.",
        img: "assets/mountain.jpg"),
    SplashModel(
        header: "Daily incremental improvements lead to big results",
        title: "Mindfulness made simple",
        description: "Mindfulness is supposed to make your life simpler.  But as you can imagine, getting to simple solutions is often super hard.  We help you get there with timeless advice from the great masters of mindfulness, psychology and philosophy.",
        img: "assets/calmAscent_logo_lt_blue.png"),
  ];

  @override
  void initState() {
    _pagecontroller = PageController();
    _pagecontroller.addListener(() {
      if (currentPage != _pagecontroller.page.floor() &&
          (_pagecontroller.page == 0.0 ||
              _pagecontroller.page == 1.0 ||
              _pagecontroller.page == 2.0)) {
        setState(() {
          currentPage = _pagecontroller.page.floor();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Expanded(
                    child: PageView.builder(
                        controller: _pagecontroller,
                        itemCount: 3,
                        itemBuilder: (context, position) {
                          SplashModel data = welcomeData[position];
                          return Container(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(data.img))),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(height: 150),
                                        Text(
                                          data.header,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 37),
                                    margin: const EdgeInsets.only(bottom: 40.0),

                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(data.title,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(

                                                fontSize: 18,
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(height:30.0),
                                        Text(data.description,
                                            style: TextStyle(fontSize: 15))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })),
                buildBottomNavigationBar()
              ],
            ),
          ),
          Positioned(
            bottom: 90,
            left: MediaQuery.of(context).size.width / 2.4,
            child: buildPageIndicator(),
          )
        ],
      ),
    );
  }

  Container buildPageIndicator() {
    double indicatorsize = 15.0;
    return Container(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 5.0),
            width: indicatorsize,
            height: indicatorsize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(indicatorsize),
                color: currentPage == 0 ? primaryColor : Colors.white,
                border: Border.all(color: primaryColor, width: 2.0)),
          ),
          Container(
            margin: const EdgeInsets.only(right: 5.0),
            width: indicatorsize,
            height: indicatorsize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(indicatorsize),
                color: currentPage == 1 ? primaryColor : Colors.white,
                border: Border.all(color: primaryColor, width: 2.0)),
          ),
          Container(
            width: indicatorsize,
            height: indicatorsize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(indicatorsize),
                color: currentPage == 2 ? primaryColor : Colors.white,
                border: Border.all(color: primaryColor, width: 2.0)),
          )
        ],
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => LoginPage())); //MATERIAL?
      },
      child: Container(
        height: 60,

        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 40.0),
                alignment: Alignment.centerLeft,
                constraints: BoxConstraints.expand(),
                color: primaryColor,
                child: Text(
                  "Get Started",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              color: darkPrimaryColor,
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_forward_ios,
                color: iconColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagecontroller.dispose();
    super.dispose();
  }
}
