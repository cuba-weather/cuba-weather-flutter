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
        DividerWidget(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: ActualStateWidget(weather: weather),
        ),
        DividerWidget(),
        TodayForecastWidget(weather: weather),
        DividerWidget(),
        ForecastWidget(weather: weather),
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
        return Icon(WeatherIcons.direction_up_right);
      case redCuba.CardinalPoint.West:
        return Icon(WeatherIcons.direction_right);
      case redCuba.CardinalPoint.Northwest:
        return Icon(WeatherIcons.direction_down_right);
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
