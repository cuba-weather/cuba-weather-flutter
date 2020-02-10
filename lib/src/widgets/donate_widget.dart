import 'dart:developer';
import 'dart:ui';

import 'package:cuba_weather/src/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
                FontAwesomeIcons.donate,
                color: Colors.white,
                size: 150,
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'Para donar puede realizar una transferencia bancaria '
                    'utilizando las aplicaciones de Transfermovil, Enzona o '
                    'por las vías tradicionales.',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'No. de la cuenta bancaria: 9224959879396073'
                    '\n'
                    'Usuario de Enzona: lgutierrez95',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'Además tiene la posibilidad de donar mediante transferencia '
                    'de saldo al número +5353478301',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'En nuestro sitio web cubaweather.app puede ver la lista '
                    'de colaboradores así como una lista de en que queremos '
                    'utilizar esas donaciones. Además de información sobre '
                    'el proyecto en general.',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'Utilice el botón de la esquina inferior derecha para '
                    'copiar el número de la cuenta bancaria, el usuario de '
                    'Enzona o el número de teléfono.',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'Si lo desea puede darnos información sobre usted '
                    '(o negocio, etc; si representa a más de una persona) '
                    'para aparecer en la lista de donantes públicamente y '
                    'enviarle nuestros agradecimientos en las redes sociales.',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'La información debe ser enviada mediante alguno de '
                    'estos medios:',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: GFButton(
                text: 'Gmail',
                textColor: Colors.white,
                color: Colors.white,
                size: GFSize.large,
                shape: GFButtonShape.pills,
                type: GFButtonType.outline2x,
                fullWidthButton: true,
                onPressed: () async {
                  const url = 'mailto:leynier41@gmail.com';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    log('Could not launch $url');
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: GFButton(
                text: 'Telegram',
                textColor: Colors.white,
                color: Colors.white,
                size: GFSize.large,
                shape: GFButtonShape.pills,
                type: GFButtonType.outline2x,
                fullWidthButton: true,
                onPressed: () async {
                  const url = 'https://t.me/leynier';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    log('Could not launch $url');
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: GFButton(
                text: 'Twitter',
                textColor: Colors.white,
                color: Colors.white,
                size: GFSize.large,
                shape: GFButtonShape.pills,
                type: GFButtonType.outline2x,
                fullWidthButton: true,
                onPressed: () async {
                  const url = 'https://twitter.com/leynier41';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    log('Could not launch $url');
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: GFButton(
                text: 'Facebook',
                textColor: Colors.white,
                color: Colors.white,
                size: GFSize.large,
                shape: GFButtonShape.pills,
                type: GFButtonType.outline2x,
                fullWidthButton: true,
                onPressed: () async {
                  const url = 'https://www.facebook.com/leynier41';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    log('Could not launch $url');
                  }
                },
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'La información puede ser un enlace a algún sitio web, '
                    'los enlaces de redes sociales como Facebook, Telegram, '
                    'Twitter, WhatsApp, Instagram, etc.',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'También puede permanecer en el anonimato, en ese caso '
                    'lo incluiremos como donación anónima.',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
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
