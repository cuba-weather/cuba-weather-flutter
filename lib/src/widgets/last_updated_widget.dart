import 'package:flutter/material.dart';

class LastUpdatedWidget extends StatelessWidget {
  final DateTime dateTime;

  LastUpdatedWidget({Key key, @required this.dateTime})
      : assert(dateTime != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: Text(
        'Actualización: ${TimeOfDay.fromDateTime(dateTime).format(context)}',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
