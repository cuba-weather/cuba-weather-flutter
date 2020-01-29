import 'package:flutter/material.dart';

class TodayForecastPage extends StatelessWidget {
  final String pageTitle = 'Pronóstico para hoy';

  final String centerName = 'Centro de Pronósticos del Tiempo, INSMET.';
  final String forecastName =
      'Pronóstico del Tiempo para la tarde y la noche de hoy.';
  final String forecastDateString =
      'Fecha: 28 de enero de 2020. Hora: 11:00 a.m.';
  final String forecastTitle =
      '...aisladas lluvias en el occidente y costa norte central...';
  final String forecastText =
      '''Estará parcialmente nublado y se nublará en algunas localidades de occidente y en la costa norte central, con aisladas lluvias, que serán escasas en el resto del país.

La tarde será cálida, con temperaturas que alcanzarán máximas entre los 27 y 30 grados Celsius, superiores en el sur oriental. En la noche las temperaturas estarán entre los 20 y 23 grados Celsius.

Los vientos serán variables débiles.

Habrá poco oleaje en el litoral norte occidental y oriental. En el resto de los litorales la mar estará tranquila.''';

  var authors = ['A. Justiz', 'A. Maturell'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pageTitle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    centerName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    forecastName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    forecastDateString,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Text(forecastTitle,
                      style: TextStyle(fontStyle: FontStyle.italic)),
                  SizedBox(height: 8.0),
                  Text(
                    forecastText,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20),
                    child: Text(
                      'Autores',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: meteorologistImg(authors[0]) !=
                                      null
                                  ? NetworkImage(meteorologistImg(authors[0]))
                                  : ExactAssetImage('images/no-image.png'),
                              radius: 30.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                authors[0],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: meteorologistImg(authors[1]) !=
                                      null
                                  ? NetworkImage(meteorologistImg(authors[1]))
                                  : ExactAssetImage('images/no-image.png'),
                              radius: 30.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                authors[1],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String meteorologistImg(String name) {
    name = name.replaceAll(' ', '');
    name = name.replaceAll('.', '');
    String url = "http://www.insmet.cu/Imagenes/Meteorologos/";
    switch (name) {
      case 'AVarela':
        return url + 'A.Varela.jpg';
        break;
      case 'YBermúdez':
        return url + 'Yinelis.jpg';
        break;
      case 'MAHernández':
        return url + 'MAHernandez.jpg';
        break;
      case 'AJustiz':
        return url + 'A.Justiz.jpg';
        break;
      case 'YArias':
        return url + 'Y.Arias.jpg';
        break;
      case 'JRubiera':
        return url + 'JRubiera.jpg';
        break;
      case 'GAcosta':
        return url + 'G.Acosta.jpg';
        break;
      case 'ACaymares':
        return url + 'ACaymares.jpg';
        break;
      default:
        return null;
    }
  }
}
