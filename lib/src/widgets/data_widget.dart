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
      children: <Widget>[
        BoxedIcon(
          WeatherIcons.fromString(weatherIconCode, fallback: WeatherIcons.na),
          size: 100,
          color: Colors.white,
        ),
        Center(
          child: Text(
            weather.stateDescription,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20.0),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          padding: EdgeInsets.only(top: 16),
          child: Text(
            "Estado actual:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${weather.temperature.round()}',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '°C',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  BoxedIcon(
                    WeatherIcons.thermometer,
                    color: Colors.white,
                    size: 25,
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        BoxedIcon(
                          WeatherIcons.barometer,
                          color: Colors.white,
                        ),
                        Text(
                          'Presión: ${weather.pressure.round()} hPa',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        BoxedIcon(
                          WeatherIcons.humidity,
                          color: Colors.white,
                        ),
                        Text(
                          'Humedad: ${weather.humidity.round()}%',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
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
