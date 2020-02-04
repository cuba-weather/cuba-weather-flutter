import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final WeatherModel weather;

  DividerWidget({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 0),
          padding: EdgeInsets.only(top: 0),
          child: Text(
            "____________________________________________",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
