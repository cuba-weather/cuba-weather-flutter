import 'package:flutter/material.dart';

import 'package:cuba_weather/src/models/models.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

class CombinedWeatherWidget extends StatelessWidget {
  final WeatherModel weather;

  CombinedWeatherWidget({Key key, @required this.weather})
      : assert(weather != null),
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
        weather.getForecasts() == null ? null : DividerWidget(),
        weather.getForecasts() == null
            ? null
            : TodayForecastWidget(weather: weather),
        DividerWidget(),
        ForecastWidget(weather: weather),
      ],
    );
  }
}
