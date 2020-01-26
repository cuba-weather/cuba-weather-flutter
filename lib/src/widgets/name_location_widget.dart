import 'package:flutter/material.dart';

class NameMunicipalityWidget extends StatelessWidget {
  final String municipality;

  NameMunicipalityWidget({Key key, @required this.municipality})
      : assert(municipality != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Text(
        municipality,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
