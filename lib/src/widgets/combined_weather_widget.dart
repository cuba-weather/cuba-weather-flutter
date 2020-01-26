import 'package:flutter/material.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';
import 'package:weather_icons/weather_icons.dart';

class CombinedWeatherWidget extends StatelessWidget {
  final WeatherModel weather;

  CombinedWeatherWidget({
    Key key,
    @required this.weather,
  })  : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: DataWidget(
                weather: weather,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 50, bottom: 5),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Viento:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ],
          )),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  IconButton(
                      icon: _parseWindVelocity(weather.windVelocity),
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: () {}),
                  Text(
                    '${weather.windVelocity.round()} Km/h',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              VerticalDivider(
                width: 50,
              ),
              Column(
                children: <Widget>[
                  IconButton(
                      icon: Icon(WeatherIcons.wind),
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: () {}),
                  Text(
                    weather.windDirection,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Icon _parseWindVelocity(double x) {
    if (x < 2)
      return Icon(WeatherIcons.wind_beaufort_0);
    if (x < 6)
      return Icon(WeatherIcons.wind_beaufort_1);
    if (x < 12)
      return Icon(WeatherIcons.wind_beaufort_2);
    if (x < 20)
      return Icon(WeatherIcons.wind_beaufort_3);
    if (x < 29)
      return Icon(WeatherIcons.wind_beaufort_4);
    if (x < 39)
      return Icon(WeatherIcons.wind_beaufort_5);
    if (x < 50)
      return Icon(WeatherIcons.wind_beaufort_6);
    if (x < 62)
      return Icon(WeatherIcons.wind_beaufort_7);
    if (x < 75)
      return Icon(WeatherIcons.wind_beaufort_8);
    if (x < 89)
      return Icon(WeatherIcons.wind_beaufort_9);
    if (x < 103)
      return Icon(WeatherIcons.wind_beaufort_10);
    if (x < 118)
      return Icon(WeatherIcons.wind_beaufort_11);
    else
      return Icon(WeatherIcons.wind_beaufort_12);
  }
}
