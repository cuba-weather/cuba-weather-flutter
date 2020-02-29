import 'package:cuba_weather/src/utils/constants.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cuba_weather/src/widgets/responsive_screen.dart';

class IntroPage extends StatelessWidget {
  final String assetImage;
  final String text;
  final String title;

  IntroPage(this.assetImage, this.title, this.text);

  @override
  Widget build(BuildContext context) {
    ResponsiveScreen size = ResponsiveScreen(MediaQuery.of(context).size);

    return SafeArea(
      child: GradientContainerWidget(
        color: Colors.blue,
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      '${Constants.appName}',
                      style: TextStyle(
                          fontFamily: Constants.fontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: 26,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      assetImage,
                      width: size.getWidthPx(250),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.getWidthPx(10)),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: Constants.fontFamily,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Center(
              child: Column(
                verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: size.getWidthPx(80),
                        left: size.getWidthPx(30),
                        right: size.getWidthPx(20)),
                    child: Text(
                      text,
                      style: TextStyle(
                          fontFamily: Constants.fontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white70),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
