import 'package:flutter/material.dart';

class DataWidget extends StatelessWidget {
  final double temperature;
  final double pressure;
  final double humidity;

  DataWidget({
    Key key,
    this.temperature,
    this.pressure,
    this.humidity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Text(
            '${temperature.round()}°C',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Column(
          children: [
            Text(
              'Presión: ${pressure.round()} hpa',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),
            Text(
              'Humedad: ${humidity.round()}%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            )
          ],
        )
      ],
    );
  }
}
