import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

import 'package:cuba_weather/src/pages/home/widgets/widgets.dart';

class ForecastHorizontal extends StatelessWidget {
  const ForecastHorizontal({
    Key key,
    @required this.weathers,
  }) : super(key: key);

  final List<WeatherForecastModel> weathers;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: this.weathers.length,
        separatorBuilder: (context, index) => Divider(
          height: 100,
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (context, index) {
          final item = this.weathers[index];
          var weatherIconCode = _weatherIconCodeByState(
            item.state,
          );
          var now = DateTime.now();
          var lastCurrentDateOfMonth = DateTime(now.year, now.month + 1, 0);
          var current1day = new DateTime(now.year, now.month, 1);
          var next1day = current1day.add(
            Duration(days: lastCurrentDateOfMonth.day),
          );
          var currentForecastDate = DateTime(now.year, now.month, item.day);
          if (item.day < now.day) {
            currentForecastDate = DateTime(
              next1day.year,
              next1day.month,
              item.day,
            );
          }
          var dateString = _spanishWeekDayString(
            DateFormat('EEEE').format(currentForecastDate),
          );
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: ValueTileWidget(
                '$dateString\n${item.day}',
                '${item.temperatureMax.round()}°/${item.temperatureMin.round()}°',
                iconData: WeatherIcons.fromString(
                  weatherIconCode,
                  fallback: WeatherIcons.na,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _weatherIconCodeByState(InsmetState state) {
    String result = '';
    switch (state) {
      case InsmetState.OccasionalShowers:
        result = 'wi-day-rain';
        break;
      case InsmetState.ScatteredShowers:
        result = 'wi-rain';
        break;
      case InsmetState.IsolatedShowers:
        result = 'wi-day-rain';
        break;
      case InsmetState.AfternoonShowers:
        result = 'wi-showers';
        break;
      case InsmetState.RainShowers:
        result = 'wi-showers';
        break;
      case InsmetState.PartlyCloudy:
        result = 'wi-day-cloudy';
        break;
      case InsmetState.Cloudy:
        result = 'wi-cloudy';
        break;
      case InsmetState.Sunny:
        result = 'wi-day-sunny';
        break;
      case InsmetState.Storms:
        result = 'wi-day-thunderstorm';
        break;
      case InsmetState.AfternoonStorms:
        result = 'wi-thunderstorm';
        break;
      case InsmetState.MorningScatteredShowers:
        result = 'wi-rain';
        break;
      case InsmetState.Winds:
        result = 'wi-strong-wind';
        break;
      default:
        result = 'wi-na';
    }
    return result;
  }

  String _spanishWeekDayString(String weekDay) {
    String result = '';
    weekDay = weekDay.toLowerCase();
    switch (weekDay) {
      case 'sunday':
        result = 'Domingo';
        break;
      case 'monday':
        result = 'Lunes';
        break;
      case 'tuesday':
        result = 'Martes';
        break;
      case 'wednesday':
        result = 'Miércoles';
        break;
      case 'thursday':
        result = 'Jueves';
        break;
      case 'friday':
        result = 'Viernes';
        break;
      case 'saturday':
        result = 'Sábado';
        break;
      default:
        result = '';
    }
    return result;
  }
}
