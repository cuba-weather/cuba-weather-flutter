import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:cuba_weather/src/widgets/widgets.dart';

class ActualStateWidget extends StatelessWidget {
  final WeatherModel weather;

  ActualStateWidget({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon icon = Icon(
      WeatherIcons.direction_down,
    );
    double screen_width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          padding: EdgeInsets.only(top: 16),
          child: Text(
            "Estado actual:",
            style: TextStyle(
              fontSize: screen_width * 0.045,
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
                fontSize: screen_width * 0.2,
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
                      fontSize: screen_width * 0.07,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  BoxedIcon(
                    WeatherIcons.thermometer,
                    color: Colors.white,
                    size: screen_width * 0.06,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: <Widget>[
                      BoxedIcon(
                        WeatherIcons.barometer,
                        color: Colors.white,
                        size: screen_width * 0.07,
                      ),
                      Text(
                        'Presión: ${weather.pressure.round()} hPa',
                        style: TextStyle(
                          fontSize: screen_width * 0.04,
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
                        size: screen_width * 0.07,
                      ),
                      Text(
                        'Humedad: ${weather.humidity.round()}%',
                        style: TextStyle(
                          fontSize: screen_width * 0.04,
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
                    fontSize: screen_width * 0.045,
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
                      iconSize: screen_width * 0.09,
                      onPressed: () {}),
                  Text(
                    '${weather.windVelocity.round()} Km/h',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: screen_width * 0.04,
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
                        angle: weather.windDirectionRadians,
                        child: IconButton(
                          icon: icon,
                          color: Colors.white,
                          iconSize: screen_width * 0.09,
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
                            fontSize: screen_width * 0.04,
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
