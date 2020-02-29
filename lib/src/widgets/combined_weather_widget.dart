import 'package:flutter/material.dart';
import 'package:cuba_weather_dart/cuba_weather_dart.dart';

import 'package:cuba_weather/src/widgets/widgets.dart';

class CombinedWeatherWidget extends StatelessWidget {
  final WeatherModel weather;
  final forecasts = new List<WeatherForecastModel>();

  CombinedWeatherWidget({Key key, @required this.weather, forecasts})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime lastDayOfMonth = new DateTime(now.year, now.month + 1, 0);
    bool isNewMoth = false;
    for (var f in weather.forecasts) {
      if (f.day > now.day || isNewMoth) {
        forecasts.add(f);
      }
      if (f.day == lastDayOfMonth.day) {
        isNewMoth = true;
      }
    }
    if (forecasts.length > 0) {
      weather.forecasts = forecasts;
    }

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
