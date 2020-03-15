import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:cuba_weather/src/pages/home/models/models.dart';
import 'package:cuba_weather/src/pages/home/widgets/widgets.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherModel weather;

  WeatherWidget({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    var updateTime = TimeOfDay.fromDateTime(weather.dateTime).format(context);
    return Center(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            this.weather.cityName.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  'Actualizado: $updateTime',
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              BoxedIcon(
                TimeIcon.fromHour(weather.dateTime.hour),
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
          WeatherSwipePager(weather: weather),
          Padding(
            child: Divider(color: Colors.white.withAlpha(50)),
            padding: EdgeInsets.all(10),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text(
                'Pronóstico para los próximos Días:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Center(
            child: ForecastHorizontal(weathers: weather.getForecasts()),
          ),
          Padding(
            child: Divider(
              color: Colors.white.withAlpha(50),
            ),
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }
}
