import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:cuba_weather/src/pages/home/models/models.dart';
import 'package:cuba_weather/src/pages/home/widgets/widgets.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

class WeatherSwipePager extends StatelessWidget {
  const WeatherSwipePager({
    Key key,
    @required this.weather,
  }) : super(key: key);

  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    var todayWeather = weather.getTodayForecast();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 350,
      child: Swiper(
        itemCount: todayWeather == null ? 1 : 2,
        index: 0,
        itemBuilder: (context, index) {
          if (index == 0) {
            return CurrentConditionsWidget(weather: weather);
          } else if (index == 1 && todayWeather != null) {
            return TodayForecastWidget(weather: weather);
          } else if (index == 1 && todayWeather == null || index == 2) {
            return TemperatureLineChartWidget(
              weather.getForecasts(),
              animate: true,
            );
          }
          return EmptyWidget();
        },
        pagination: SwiperPagination(
          margin: EdgeInsets.all(5.0),
          builder: DotSwiperPaginationBuilder(
            size: 5,
            activeSize: 5,
            color: Colors.white.withOpacity(0.4),
            activeColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
