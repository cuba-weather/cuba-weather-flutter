import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

import 'package:cuba_weather/src/models/models.dart' as models;

class ForecastWidget extends StatelessWidget {
  final models.WeatherModel weather;

  ForecastWidget({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var list = List<Widget>();
    var forecasts = weather.getForecasts();
    for (var forecast in forecasts) {
      list.add(_buildForecast(forecast, screenWidth));
    }
    var children = <Widget>[];
    if (list.length > 0) {
      children = [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'Pronóstico para los siguientes días:',
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: list,
          ),
        )
      ];
    }
    return Column(
      children: children,
    );
  }

  Widget _buildForecast(WeatherForecastModel forecast, double screenWidth) {
    String weatherIconCode = _weatherIconCodeByState(forecast.state);

    DateTime now = DateTime.now();
    DateTime lastCurrentDateOfMonth = new DateTime(now.year, now.month + 1, 0);
    DateTime current1day = new DateTime(now.year, now.month, 1);
    DateTime next1day =
        current1day.add(Duration(days: lastCurrentDateOfMonth.day));
    DateTime currentForecastDate =
        new DateTime(now.year, now.month, forecast.day);
    if (forecast.day < now.day) {
      currentForecastDate =
          new DateTime(next1day.year, next1day.month, forecast.day);
    }
    String dateString =
        _spanishWeekDayString(DateFormat('EEEE').format(currentForecastDate));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '$dateString ' '${forecast.day}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        BoxedIcon(
          WeatherIcons.fromString(weatherIconCode, fallback: WeatherIcons.na),
          size: screenWidth * 0.1,
          color: Colors.white,
        ),
        Text(
          '${forecast.temperatureMax.round()}'
          '/'
          '${forecast.temperatureMin.round()}'
          ' °C',
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
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
