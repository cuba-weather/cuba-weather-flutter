import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart' as cwd;

import 'package:cuba_weather/src/pages/home/models/models.dart';
import 'package:cuba_weather/src/pages/home/widgets/widgets.dart';

class CurrentConditionsWidget extends StatelessWidget {
  final WeatherModel weather;

  const CurrentConditionsWidget({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Última Información',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${weather.temperature.round()}',
              style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '°C',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.07,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  BoxedIcon(
                    WeatherIcons.thermometer,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width * 0.06,
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueTileWidget(
              'velocidad\ndel viento',
              '${weather.windVelocity.round()} km/h',
              widget: IconButton(
                icon: _parseWindVelocity(weather.windVelocity),
                color: Colors.white,
                iconSize: MediaQuery.of(context).size.width * 0.09,
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color: Colors.white.withAlpha(50),
              )),
            ),
            ValueTileWidget(
              'dirección\ndel viento',
              _cardinalToString(weather.windDirection),
              widget: Transform.rotate(
                angle: weather.windDirectionRadians,
                child: IconButton(
                  icon: Icon(WeatherIcons.direction_down),
                  color: Colors.white,
                  iconSize: MediaQuery.of(context).size.width * 0.09,
                  onPressed: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color: Colors.white.withAlpha(50),
              )),
            ),
            ValueTileWidget(
              'presión\natmosférica',
              '${weather.pressure.round()} hPa',
              widget: BoxedIcon(
                WeatherIcons.barometer,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * 0.09,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color: Colors.white.withAlpha(50),
              )),
            ),
            ValueTileWidget(
              'humedad\nrelativa',
              '${weather.humidity.round()}%',
              widget: BoxedIcon(
                WeatherIcons.humidity,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * 0.09,
              ),
            ),
          ],
        ),
      ],
    );
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

  String _cardinalToString(cwd.CardinalPoint x) {
    switch (x) {
      case cwd.CardinalPoint.North:
        return 'N';
      case cwd.CardinalPoint.North_Northeast:
        return 'N-NE';
      case cwd.CardinalPoint.Northeast:
        return 'NE';
      case cwd.CardinalPoint.East_Northeast:
        return 'E-NE';
      case cwd.CardinalPoint.East:
        return 'E';
      case cwd.CardinalPoint.East_Southeast:
        return 'E-SE';
      case cwd.CardinalPoint.Southeast:
        return 'SE';
      case cwd.CardinalPoint.South_Southeast:
        return 'S-SE';
      case cwd.CardinalPoint.South:
        return 'S';
      case cwd.CardinalPoint.South_Southwest:
        return 'S-SO';
      case cwd.CardinalPoint.Southwest:
        return 'SO';
      case cwd.CardinalPoint.West_Southwest:
        return 'O-SO';
      case cwd.CardinalPoint.West:
        return 'O';
      case cwd.CardinalPoint.West_Northwest:
        return 'O-NO';
      case cwd.CardinalPoint.Northwest:
        return 'NO';
      case cwd.CardinalPoint.North_Northwest:
        return 'N-NO';
      default:
        return '';
    }
  }
}
