import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:flutter/material.dart';

class TemperatureLineChartWidget extends StatelessWidget {
  final List<WeatherForecastModel> weathers;
  final bool animate;

  TemperatureLineChartWidget(this.weathers, {this.animate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: charts.TimeSeriesChart(
        [
          new charts.Series<WeatherForecastModel, DateTime>(
            id: 'Temperature',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (WeatherForecastModel weather, _) {
              DateTime now = DateTime.now();
              DateTime lastCurrentDateOfMonth =
                  new DateTime(now.year, now.month + 1, 0);
              DateTime current1day = new DateTime(now.year, now.month, 1);
              DateTime next1day =
                  current1day.add(Duration(days: lastCurrentDateOfMonth.day));
              DateTime currentForecastDate =
                  new DateTime(now.year, now.month, weather.day);
              if (weather.day < now.day) {
                currentForecastDate =
                    new DateTime(next1day.year, next1day.month, weather.day);
              }
              return currentForecastDate;
            },
            measureFn: (WeatherForecastModel weather, _) =>
                weather.temperatureMin,
            data: weathers,
          ),
        ],
        animate: animate,
        animationDuration: Duration(milliseconds: 500),
        primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
            zeroBound: false,
          ),
        ),
      ),
    );
  }
}
