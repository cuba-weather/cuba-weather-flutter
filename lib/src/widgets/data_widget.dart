import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class DataWidget extends StatelessWidget {
  final WeatherModel weather;

  DataWidget({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String weatherIconCode = _weatherIconCodeByState(weather.state.toString());
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

  String _weatherIconCodeByState(String state) {
    String result = '';
    switch (state) {
      case 'State.OccasionalShowers':
        result = 'wi-day-rain';
        break;
      case 'State.ScatteredShowers':
        result = 'wi-day-rain-mix';
        break;
      case 'State.IsolatedShowers':
        result = 'wi-day-hail';
        break;
      case 'State.AfternoonShowers':
        result = 'wi-showers';
        break;
      case 'State.RainShowers':
        result = 'wi-day-rain';
        break;
      case 'State.PartlyCloudy':
        result = 'wi-day-cloudy';
        break;
      case 'State.Cloudy':
        result = 'wi-cloudy';
        break;
      case 'State.Sunny':
        result = 'wi-day-sunny';
        break;
      case 'State.Storms':
        result = 'wi-day-thunderstorm';
        break;
      case 'State.AfternoonStorms':
        result = 'wi-day-thunderstorm';
        break;
      default:
        result = 'wi-na';
    }
    return result;
  }
}
