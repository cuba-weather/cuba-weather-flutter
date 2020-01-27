import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class DataWidget extends StatelessWidget {
  final WeatherModel weather;

  DataWidget({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String weatherIconCode =
        _weatherIconCodeByState(weather.state.toString(), weather.dateTime);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          WeatherIcons.fromString(weatherIconCode, fallback: WeatherIcons.na),
          size: 100,
          color: Colors.white,
          semanticLabel: weather.stateDescription,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50.0),
        ),
        Center(
          child: Text(
            weather.stateDescription,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Text(
                '${weather.temperature.round()}°C',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  'Presión: ${weather.pressure.round()} hPa',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Humedad: ${weather.humidity.round()}%',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
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
