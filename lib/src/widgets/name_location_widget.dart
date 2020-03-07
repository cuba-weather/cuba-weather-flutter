import 'package:flutter/material.dart';

class NameMunicipalityWidget extends StatelessWidget {
  final String municipality;
  final List<String> municipalities;

  NameMunicipalityWidget(
      {Key key, @required this.municipalities, @required this.municipality})
      : assert(municipality != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 13),
            child: Text(
              municipality,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
