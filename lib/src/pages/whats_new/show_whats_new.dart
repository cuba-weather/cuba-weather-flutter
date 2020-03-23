import 'package:cuba_weather/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsnew/flutter_whatsnew.dart';
import 'package:preferences/preference_service.dart';

import '../pages.dart';

class WhatsNew {
  final double textScaleFactor = 1.0;

  Widget showWhatsNewPage(BuildContext context, String version) {
    return WhatsNewPage(
      title: Text(
        "Actualizaciones",
        textScaleFactor: textScaleFactor,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      buttonText: Text(
        'Continuar',
        textScaleFactor: textScaleFactor,
        style: TextStyle(color: Theme.of(context).backgroundColor),
      ),
      buttonColor: Colors.white,
      backgroundColor: Theme.of(context).backgroundColor,
      items: <ListTile>[
        ListTile(
          leading: const Icon(Icons.color_lens, color: Colors.white),
          title: Text(
            'Temas',
            textScaleFactor: textScaleFactor,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Claro, oscuro y sistema (Toque para cambiar)',
            textScaleFactor: textScaleFactor,
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            );
          },
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          leading: const Icon(Icons.satellite, color: Colors.white),
          title: Text(
            'Satélites',
            textScaleFactor: textScaleFactor,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Imágenes de satelites (Toque para ver)',
            textScaleFactor: textScaleFactor,
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SatelliteListPage(),
              ),
            );
          },
        ),
        ListTile(
          leading:
              const Icon(Icons.settings_input_antenna, color: Colors.white),
          title: Text(
            'Radares',
            textScaleFactor: textScaleFactor,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Imágenes de radar (Toque para ver)',
            textScaleFactor: textScaleFactor,
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RadarListPage(),
              ),
            );
          },
        ),
        ListTile(
          title: Text(
            '',
            textScaleFactor: textScaleFactor,
            style: TextStyle(color: Colors.white),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.history, color: Colors.white),
          title: Text(
            'Ver historial de cambios',
            textScaleFactor: textScaleFactor,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            '(Toque para ver)',
            textScaleFactor: textScaleFactor,
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: WhatsNewPage.changelog(
                    title: Text(
                      "Historial de cambios",
                      textScaleFactor: textScaleFactor,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    buttonText: Text(
                      'Cerrar',
                      textScaleFactor: textScaleFactor,
                      style:
                          TextStyle(color: Theme.of(context).backgroundColor),
                    ),
                    buttonColor: Colors.white,
                    backgroundColor: Theme.of(context).backgroundColor,
                  ),
                ),
                fullscreenDialog: true,
              ),
            );
          },
        ),
      ],
      onButtonPressed: () {
        PrefService.setString(Constants.lastVersion, version);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      },
    );
  }
}
