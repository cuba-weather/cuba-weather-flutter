import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';

import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

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
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      '$appName',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '$version',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'images/logo.png',
                      width: 200,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    child: Center(
                      child: Text(
                        'Para dudas, problemas o sugerencias puede:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: GFButton(
                      text: 'Escribir correo al desarrollador',
                      textColor: Colors.white,
                      color: Colors.white,
                      size: GFSize.large,
                      shape: GFButtonShape.pills,
                      type: GFButtonType.outline2x,
                      fullWidthButton: true,
                      onPressed: () async {
                        const url = 'mailto:leynier41@gmail.com';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          log('Could not launch $url');
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: GFButton(
                      text: 'Visitar repositorio en GitHub',
                      textColor: Colors.white,
                      color: Colors.white,
                      size: GFSize.large,
                      shape: GFButtonShape.pills,
                      type: GFButtonType.outline2x,
                      fullWidthButton: true,
                      onPressed: () async {
                        const url =
                            'https://github.com/cuba-weather/cuba-weather-flutter';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          log('Could not launch $url');
                        }
                      },
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
