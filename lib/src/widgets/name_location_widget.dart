import 'package:cuba_weather/src/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'location_selection_widget.dart';

class NameMunicipalityWidget extends StatelessWidget {
  final String municipality;
  final List<String> municipalities;

  NameMunicipalityWidget({Key key, @required this.municipalities, @required this.municipality})
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
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
              size: 40,
            ),
            color: Colors.white,
            onPressed: () async {
              final municipality = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MunicipalitySelectionWidget(
                    municipalities: this.municipalities,
                  ),
                ),
              );
              if (municipality != null) {
                BlocProvider.of<WeatherBloc>(context).add(FetchWeather(
                  municipality: municipality,
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
