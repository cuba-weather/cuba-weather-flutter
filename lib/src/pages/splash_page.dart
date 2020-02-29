import 'dart:async';
import 'dart:developer';
import 'package:cuba_weather/src/pages/home_page.dart';
import 'package:cuba_weather/src/pages/pages.dart';
import 'package:cuba_weather/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:cuba_weather/src/widgets/responsive_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';
  final String initialMunicipality;

  SplashScreen({
    Key key,
    @required this.initialMunicipality,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
        body: Container(
      color: Constants.clr_gradient_max,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: size.getWidthPx(200),
              height: size.getWidthPx(200),
              child: Image.asset(Constants.appLogo)),
          Text(
            Constants.appName,
            style: TextStyle(
                fontFamily: Constants.fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 26,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Text(
            Constants.appSlogan.toUpperCase(),
            style: TextStyle(
                fontFamily: Constants.fontFamily,
                fontWeight: FontWeight.w300,
                fontSize: 15,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      )),
    ));
  }

  Future navigateFromSplash() async {
    String isOnBoard = '0';
    try {
      var prefs = await SharedPreferences.getInstance();
      isOnBoard = prefs.getString(Constants.isOnBoard);
    } catch (e) {
      log(e.toString());
    }
    print("isOnBoard  $isOnBoard");
    if (isOnBoard == null || isOnBoard == "0") {
      //Navigate to OnBoarding Screen.
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OnBoardingPage(
                  initialMunicipality: widget.initialMunicipality)));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage(initialMunicipality: widget.initialMunicipality)));
    }
  }
}
