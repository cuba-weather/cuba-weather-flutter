import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:getflutter/components/button/gf_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

import 'package:cuba_weather/src/widgets/widgets.dart';

class InformationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InformationWidgetState();
}

class InformationWidgetState extends State<InformationWidget> {
  String appName = '';
  String version = '';

  InformationWidgetState() {
    start();
  }

  void start() async {
    var packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información'),
      ),
      body: GradientContainerWidget(
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Center(
                child: Text(
                  '$appName',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Center(
                child: Text(
                  '$version',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 100, right: 100),
              child: Center(
                child: Image.asset(
                  'images/logo.png',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Center(
                child: Text(
                  'Desarrollado por:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 90),
              child: GFButton(
                text: 'Leynier Gutiérrez González',
                textColor: Colors.blue,
                color: Colors.white,
                size: GFSize.large,
                shape: GFButtonShape.pills,
                fullWidthButton: true,
                onPressed: () async {
                  const url = 'https://leynier.github.io';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Center(
                child: Text(
                  'Dudas, problemas o comentarios al:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 90),
              child: GFButton(
                text: 'Repositorio en GitHub',
                textColor: Colors.blue,
                color: Colors.white,
                size: GFSize.large,
                shape: GFButtonShape.pills,
                fullWidthButton: true,
                onPressed: () async {
                  const url = 'https://github.com/leynier/cuba-weather-flutter';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
