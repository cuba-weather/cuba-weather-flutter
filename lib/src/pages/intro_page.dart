import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cuba_weather/src/pages/pages.dart';
import 'package:cuba_weather/src/utils/constants.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

class IntroPage extends StatelessWidget {
  final String assetImage;
  final String text;
  final String title;
  final String initialMunicipality;
  final bool isLast;

  IntroPage(
    this.assetImage,
    this.title,
    this.text,
    this.initialMunicipality,
    this.isLast,
  );

  @override
  Widget build(BuildContext context) {
    var size = ResponsiveScreen(MediaQuery.of(context).size);
    var children = <Widget>[
      Center(
        child: Image.asset(
          assetImage,
          width: size.getWidthPx(300),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(size.getWidthPx(10)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: Constants.fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          bottom: size.getWidthPx(80),
          left: size.getWidthPx(30),
          right: size.getWidthPx(30),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: Constants.fontFamily,
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ];

    if (isLast) {
      children.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: GFButton(
              text: 'Comenzar',
              textColor: Colors.white,
              color: Colors.white,
              size: GFSize.large,
              shape: GFButtonShape.pills,
              type: GFButtonType.outline2x,
              fullWidthButton: true,
              onPressed: () async {
                try {
                  var prefs = await SharedPreferences.getInstance();
                  await prefs.setBool(Constants.isOnBoard, true);
                } catch (e) {
                  log(e.toString());
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      initialMunicipality: initialMunicipality,
                    ),
                  ),
                );
              }),
        ),
      );
    }

    return SafeArea(
      child: GradientContainerWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
