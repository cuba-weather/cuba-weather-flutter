import 'package:flutter/material.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:cuba_weather_redcuba_dart/src/models/weather_model.dart'
    as redCuba;

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
          crossAxisAlignment: CrossAxisAlignment.center,
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
            ),
          ),
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
                      icon: _parseWindDirection(weather.windDirection),
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: () {}),
                  Text(
                    weather.windDirectionDescription,
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

  static Icon _parseWindDirection(redCuba.CardinalPoint input) {
    switch (input) {
      case redCuba.CardinalPoint.North:
        return Icon(WeatherIcons.direction_down);
      case redCuba.CardinalPoint.Northeast:
        return Icon(WeatherIcons.direction_down_left);
      case redCuba.CardinalPoint.East:
        return Icon(WeatherIcons.direction_left);
      case redCuba.CardinalPoint.Southeast:
        return Icon(WeatherIcons.direction_up_left);
      case redCuba.CardinalPoint.South:
        return Icon(WeatherIcons.direction_up);
      case redCuba.CardinalPoint.Southwest:
        return Icon(WeatherIcons.direction_up_rigth);
      case redCuba.CardinalPoint.West:
        return Icon(WeatherIcons.direction_rigth);
      case redCuba.CardinalPoint.Northwest:
        return Icon(WeatherIcons.direction_down_rigth);
      default:
        return Icon(WeatherIcons.wind);
    }
  }

  static Icon _parseWindVelocity(double x) {
    if (x < 2)
      return Icon(WeatherIcons.wind_beaufort_0);
    else if (x < 6)
      return Icon(WeatherIcons.wind_beaufort_1);
    else if (x < 12)
      return Icon(WeatherIcons.wind_beaufort_2);
    else if (x < 20)
      return Icon(WeatherIcons.wind_beaufort_3);
    else if (x < 29)
      return Icon(WeatherIcons.wind_beaufort_4);
    else if (x < 39)
      return Icon(WeatherIcons.wind_beaufort_5);
    else if (x < 50)
      return Icon(WeatherIcons.wind_beaufort_6);
    else if (x < 62)
      return Icon(WeatherIcons.wind_beaufort_7);
    else if (x < 75)
      return Icon(WeatherIcons.wind_beaufort_8);
    else if (x < 89)
      return Icon(WeatherIcons.wind_beaufort_9);
    else if (x < 103)
      return Icon(WeatherIcons.wind_beaufort_10);
    else if (x < 118)
      return Icon(WeatherIcons.wind_beaufort_11);
    else
      return Icon(WeatherIcons.wind_beaufort_12);
  }
}
