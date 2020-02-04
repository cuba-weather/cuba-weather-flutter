import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class ForecastWidget extends StatelessWidget {
  final WeatherModel weather;

  ForecastWidget({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          padding: EdgeInsets.only(top: 16),
          child: Text(
            "Pronóstico para los siguientes días:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weather.forecasts.map(_buildForecast).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildForecast(WeatherForecastModel forecast) {
    String weatherIconCode =
        _weatherIconCodeByState(forecast.state.toString(), weather.dateTime);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Día: ${forecast.day}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        BoxedIcon(
          WeatherIcons.fromString(weatherIconCode, fallback: WeatherIcons.na),
          size: 40,
          color: Colors.white,
        ),
        Text(
          '${forecast.temperatureMin.round()}'
          ' / '
          '${forecast.temperatureMax.round()}'
          ' °C',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  String _weatherIconCodeByState(String state, DateTime dateTime) {
    bool itsDay = true;

    if (dateTime.hour >= 19 || dateTime.hour <= 6) {
      itsDay = false;
    }

    String result = '';
    switch (state) {
      case 'State.OccasionalShowers':
        if (itsDay) {
          result = 'wi-day-rain';
        } else {
          result = 'wi-night-alt-rain';
        }
        break;
      case 'State.ScatteredShowers':
        if (itsDay) {
          result = 'wi-rain';
        } else {
          result = 'wi-rain';
        }
        break;
      case 'State.IsolatedShowers':
        if (itsDay) {
          result = 'wi-day-rain';
        } else {
          result = 'wi-night-alt-rain';
        }
        break;
      case 'State.AfternoonShowers':
        if (itsDay) {
          result = 'wi-showers';
        } else {
          result = 'wi-showers';
        }
        break;
      case 'State.RainShowers':
        if (itsDay) {
          result = 'wi-showers';
        } else {
          result = 'wi-night-alt-showers';
        }
        break;
      case 'State.PartlyCloudy':
        if (itsDay) {
          result = 'wi-day-cloudy';
        } else {
          result = 'wi-night-alt-cloudy';
        }
        break;
      case 'State.Cloudy':
        result = 'wi-cloudy';
        break;
      case 'State.Sunny':
        result = 'wi-day-sunny';
        break;
      case 'State.Storms':
        if (itsDay) {
          result = 'wi-day-thunderstorm';
        } else {
          result = 'wi-night-alt-thunderstorm';
        }
        break;
      case 'State.AfternoonStorms':
        result = 'wi-thunderstorm';
        break;
      default:
        result = 'wi-na';
    }
    return result;
  }
}
