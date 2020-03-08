import 'package:flutter/material.dart';

import 'package:cuba_weather/src/models/models.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

class CombinedWeatherWidget extends StatelessWidget {
  final WeatherModel weather;

  CombinedWeatherWidget({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  getChildren() {
    var haveToday = weather.getTodayForecast() != null;
    List<Widget> result = [
      DividerWidget(),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: ActualStateWidget(weather: weather),
      ),
      DividerWidget(),
      ForecastWidget(weather: weather),
    ];
    if (haveToday) {
      result.insert(2, DividerWidget());
      result.insert(3, TodayForecastWidget(weather: weather));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getChildren(),
    );
  }
}
