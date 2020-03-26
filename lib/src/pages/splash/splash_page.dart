import 'dart:async';

import 'package:cuba_weather/src/pages/whats_new/show_whats_new.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:package_info/package_info.dart';
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
  String version = '';
  final double textScaleFactor = 1.0;

  @override
  initState() {
    super.initState();
    start();
    Timer(Duration(seconds: 2), () {
      navigateFromSplash();
    });
  }

  void start() async {
    var packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
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
            Padding(padding: EdgeInsets.all(10)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GFButton(
                  text: 'Comenzar',
                  textColor: Colors.white,
                  color: Colors.white,
                  size: GFSize.LARGE,
                  shape: GFButtonShape.pills,
                  type: GFButtonType.outline2x,
                  fullWidthButton: true,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future navigateFromSplash() async {
    var isOnBoard = PrefService.getBool(Constants.carouselWasSeen) ?? false;
    var lastVersion = int.parse((PrefService.getString(Constants.lastVersion) ?? "-1").replaceAll('.', ''));
    int versionNumber = int.parse(version.replaceAll('.', ''));
    var showWhatsNew1 = versionNumber > lastVersion;

    var page = isOnBoard
        ? showWhatsNew1
            ? WhatsNew().showWhatsNewPage(context, version)
            : HomePage()
        : CarouselPage();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => page, fullscreenDialog: showWhatsNew1),
    );
  }
}
