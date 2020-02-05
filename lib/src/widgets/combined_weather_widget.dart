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

}
