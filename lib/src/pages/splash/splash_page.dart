import 'dart:async';

import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import 'package:cuba_weather/src/pages/pages.dart';
import 'package:cuba_weather/src/utils/utils.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  ResponsiveScreen size;

  @override
  initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      navigateFromSplash();
    });
  }

  @override
  Widget build(BuildContext context) {
    size = ResponsiveScreen(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: size.getWidthPx(200),
              height: size.getWidthPx(200),
              child: Image.asset(Constants.appLogo),
            ),
            Text(
              Constants.appName,
              style: TextStyle(
                fontFamily: Constants.fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 26,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              Constants.appSlogan.toUpperCase(),
              style: TextStyle(
                fontFamily: Constants.fontFamily,
                fontWeight: FontWeight.w300,
                fontSize: 15,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future navigateFromSplash() async {
    var isOnBoard = PrefService.getBool(Constants.carouselWasSeen) ?? false;
    var page = isOnBoard ? HomePage() : CarouselPage();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
