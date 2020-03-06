import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:cuba_weather/src/pages/home_page.dart';
import 'package:cuba_weather/src/pages/pages.dart';
import 'package:cuba_weather/src/utils/constants.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';
import 'package:cuba_weather/src/widgets/responsive_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';
  final String initialMunicipality;
  final bool darkMode;

  SplashScreen({
    Key key,
    @required this.initialMunicipality,
    @required this.darkMode,
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
    if (widget.darkMode) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.grey[800],
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.blue[300],
        ),
      );
    }
    size = ResponsiveScreen(MediaQuery.of(context).size);
    return Scaffold(
      body: GradientContainerWidget(
        child: Center(
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
      ),
    );
  }

  Future navigateFromSplash() async {
    bool isOnBoard = false;
    try {
      var prefs = await SharedPreferences.getInstance();
      isOnBoard = prefs.getBool(Constants.isOnBoard);
    } catch (e) {
      log(e.toString());
    }
    print("isOnBoard  $isOnBoard");
    if (isOnBoard == null || !isOnBoard) {
      //Navigate to OnBoarding Screen.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoardingPage(
            initialMunicipality: widget.initialMunicipality,
            darkMode: widget.darkMode,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            initialMunicipality: widget.initialMunicipality,
            darkMode: widget.darkMode,
          ),
        ),
      );
    }
  }
}
