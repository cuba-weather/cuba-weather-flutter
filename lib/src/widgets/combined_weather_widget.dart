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
                    icon: Icon(WeatherIcons.strong_wind),
                    color: Colors.white,
                    iconSize: 30,
                    onPressed: () {}),
                Text(
                  weather.windVelocity.round().toString() + ' km/h',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            VerticalDivider(width: 50, ),
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
            )
          ],
        )),
      ],
    );
  }
}
