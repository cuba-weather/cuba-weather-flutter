import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class LastUpdatedWidget extends StatelessWidget {
  final DateTime dateTime;

  LastUpdatedWidget({Key key, @required this.dateTime})
      : assert(dateTime != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              'Actualizado: ${TimeOfDay.fromDateTime(dateTime).format(context)}',
              style: TextStyle(
                fontSize: screen_width * 0.04,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          BoxedIcon(
            TimeIcon.fromHour(dateTime.hour),
            color: Colors.white,
            size: screen_width * 0.065,
          ),
        ],
      ),
    );
  }
}
