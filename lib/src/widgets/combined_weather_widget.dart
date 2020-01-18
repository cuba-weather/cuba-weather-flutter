import 'package:flutter/material.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

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
              padding: EdgeInsets.all(20.0),
              child: DataWidget(
                temperature: weather.temp,
                pressure: weather.pressure,
                humidity: weather.humidity,
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            weather.descriptionWeather,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
