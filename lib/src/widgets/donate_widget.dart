import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cuba_weather/src/widgets/widgets.dart';

class DonateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DonateWidgetState();
}

class DonateWidgetState extends State<DonateWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showSnackBar(String text) {
    SnackBar snackBar = new SnackBar(
      content: Text(text),
      duration: Duration(seconds: 1),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Donar'),
      ),
      body: GradientContainerWidget(
        color: Colors.blue,
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Icon(
                Icons.card_giftcard,
                color: Colors.white,
                size: 200,
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Para donar puede realizar una transferencia bancaria '
                  'utilizando las aplicaciones de Transfermovil, Enzona o '
                  'por las vías tradicionales.\n\nNo. de la cuenta bancaria: '
                  '9224959879396073\nUsuario de Enzona: lgutierrez95\n\n'
                  'Además tiene la posibilidad de donar mediante transferencia '
                  'de saldo al número +5353478301\n\nEn nuestro sitio web '
                  'cubaweather.app puede ver la lista de colaboradores así '
                  'como una lista de en que queremos utilizar esas donaciones. '
                  'Además de información sobre el proyecto en general.\n\n'
                  'Utilize el botón de la esquina inferior derecha para '
                  'copiar el número de la cuenta bancaria, el usuario de '
                  'Enzona o el número de teléfono.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22),
        backgroundColor: Colors.blue,
        children: [
          SpeedDialChild(
            child: Icon(Icons.content_copy),
            backgroundColor: Colors.blue,
            onTap: () {
              Clipboard.setData(new ClipboardData(text: '9224959879396073'));
              _showSnackBar('Cuenta bancaria copiada');
            },
            label: 'Copiar cuenta bancaria',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.0,
            ),
            labelBackgroundColor: Colors.blue,
          ),
          SpeedDialChild(
            child: Icon(Icons.content_copy),
            backgroundColor: Colors.blue,
            onTap: () {
              Clipboard.setData(new ClipboardData(text: 'lgutierrez95'));
              _showSnackBar('Usuario de Enzona copiado');
            },
            label: 'Copiar usuario de Enzona',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.0,
            ),
            labelBackgroundColor: Colors.blue,
          ),
          SpeedDialChild(
            child: Icon(Icons.content_copy),
            backgroundColor: Colors.blue,
            onTap: () {
              Clipboard.setData(new ClipboardData(text: '+5353478301'));
              _showSnackBar('Número de teléfono copiado');
            },
            label: 'Copiar número de teléfono',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.0,
            ),
            labelBackgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
