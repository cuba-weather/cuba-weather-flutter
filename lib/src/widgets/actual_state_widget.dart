import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:cuba_weather_redcuba_dart/src/models/weather_model.dart' as aux;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:cuba_weather/src/widgets/widgets.dart';

class ActualStateWidget extends StatelessWidget {
  final WeatherModel weather;

  ActualStateWidget({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var windData = _parseWindDirection(weather.windDirection);
    var icon = windData.item1;
    var radius = windData.item2;
    var size = windData.item3;
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          padding: EdgeInsets.only(top: 16),
          child: Text(
            "Estado actual:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        LastUpdatedWidget(dateTime: weather.dateTime),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${weather.temperature.round()}',
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.w600,
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
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  BoxedIcon(
                    WeatherIcons.thermometer,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: <Widget>[
                      BoxedIcon(
                        WeatherIcons.barometer,
                        color: Colors.white,
                      ),
                      Text(
                        'Presión: ${weather.pressure.round()} hPa',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      BoxedIcon(
                        WeatherIcons.humidity,
                        color: Colors.white,
                      ),
                      Text(
                        'Humedad: ${weather.humidity.round()}%',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      iconSize: size,
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
                  Column(
                    children: <Widget>[
                      Transform.rotate(
                        angle: radius,
                        child: IconButton(
                          icon: icon,
                          color: Colors.white,
                          iconSize: size,
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        child: Text(
                          weather.windDirectionDescription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Tuple3 _parseWindDirection(aux.CardinalPoint input) {
    var result = Tuple3<Icon, double, double>(null, 0, 0);
    switch (input) {
      case aux.CardinalPoint.North:
        result = result.withItem1(Icon(WeatherIcons.direction_down));
        result = result.withItem2(0);
        result = result.withItem3(30);
        break;
      case aux.CardinalPoint.North_Northeast:
        result = result.withItem1(Icon(WeatherIcons.direction_down));
        result = result.withItem2(0.3926991);
        result = result.withItem3(30);
        break;
      case aux.CardinalPoint.Northeast:
        result = result.withItem1(Icon(WeatherIcons.direction_down_left));
        result = result.withItem2(0);
        result = result.withItem3(35);
        break;
      case aux.CardinalPoint.East_Northeast:
        result = result.withItem1(Icon(WeatherIcons.direction_down_left));
        result = result.withItem2(0.3926991);
        result = result.withItem3(37);
        break;
      case aux.CardinalPoint.East:
        result = result.withItem1(Icon(WeatherIcons.direction_left));
        result = result.withItem2(0);
        result = result.withItem3(30);
        break;
      case aux.CardinalPoint.East_Southeast:
        result = result.withItem1(Icon(WeatherIcons.direction_left));
        result = result.withItem2(0.3926991);
        result = result.withItem3(30);
        break;
      case aux.CardinalPoint.Southeast:
        result = result.withItem1(Icon(WeatherIcons.direction_up_left));
        result = result.withItem2(0);
        result = result.withItem3(35);
        break;
      case aux.CardinalPoint.South_Southeast:
        result = result.withItem1(Icon(WeatherIcons.direction_up_left));
        result = result.withItem2(0.3926991);
        result = result.withItem3(35);
        break;
      case aux.CardinalPoint.South:
        result = result.withItem1(Icon(WeatherIcons.direction_up));
        result = result.withItem2(0);
        result = result.withItem3(30);
        break;
      case aux.CardinalPoint.South_Southwest:
        result = result.withItem1(Icon(WeatherIcons.direction_up));
        result = result.withItem2(0.3926991);
        result = result.withItem3(30);
        break;
      case aux.CardinalPoint.Southwest:
        result = result.withItem1(Icon(WeatherIcons.direction_up_right));
        result = result.withItem2(0);
        result = result.withItem3(35);
        break;
      case aux.CardinalPoint.West_Southwest:
        result = result.withItem1(Icon(WeatherIcons.direction_up_right));
        result = result.withItem2(0.3926991);
        result = result.withItem3(35);
        break;
      case aux.CardinalPoint.West:
        result = result.withItem1(Icon(WeatherIcons.direction_right));
        result = result.withItem2(0);
        result = result.withItem3(30);
        break;
      case aux.CardinalPoint.West_Northwest:
        result = result.withItem1(Icon(WeatherIcons.direction_right));
        result = result.withItem2(0.3926991);
        result = result.withItem3(30);
        break;
      case aux.CardinalPoint.Northwest:
        result = result.withItem1(Icon(WeatherIcons.direction_down_right));
        result = result.withItem2(0);
        result = result.withItem3(35);
        break;
      case aux.CardinalPoint.North_Northwest:
        result = result.withItem1(Icon(WeatherIcons.direction_down_right));
        result = result.withItem2(0.3926991);
        result = result.withItem3(35);
        break;
      default:
        result = result.withItem1(Icon(WeatherIcons.wind));
        result = result.withItem2(0);
        result = result.withItem3(30);
        break;
    }
    return result;
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
