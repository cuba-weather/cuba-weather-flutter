import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getflutter/getflutter.dart';

import 'package:cuba_weather/src/pages/home/blocs/blocs.dart';
import 'package:cuba_weather/src/utils/utils.dart';

class WeatherEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 50,
            bottom: 50,
          ),
          child: Text(
            '¡Bienvenido a ${Constants.appName}!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Icon(
              Icons.my_location,
              color: Colors.white,
              size: 100,
            ),
          ),
          onTap: () {
            BlocProvider.of<WeatherBloc>(context).add(
              FindLocationWeather(),
            );
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: GFButton(
            text: 'BUSCAR MUNICIPIO ACTUAL',
            textColor: Colors.white,
            color: Colors.white,
            size: GFSize.LARGE,
            shape: GFButtonShape.pills,
            type: GFButtonType.outline2x,
            fullWidthButton: true,
            onPressed: () {
              BlocProvider.of<WeatherBloc>(context).add(
                FindLocationWeather(),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 50,
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Nota: Este cálculo se hace con respecto '
              'al centro del municipio, por lo que si se '
              'encuentra en la periferia de un municipio '
              'puede que la aplicación le indique que se '
              'encuentra en un municipio aledaño al que se '
              'encuentra realmente.',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
