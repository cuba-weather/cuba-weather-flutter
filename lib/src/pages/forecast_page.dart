import 'package:flutter/material.dart';
import 'package:cuba_weather/src/models/models.dart';
import 'package:cuba_weather/src/utils/weather_client.dart';
import 'package:http/http.dart';

class TodayForecastPage extends StatefulWidget {
  @override
  _TodayForecastPageState createState() => _TodayForecastPageState();
}

class _TodayForecastPageState extends State<TodayForecastPage> {
  ForecastModel _forecast;
  var client = Client();

  @override
  Widget build(BuildContext context) {
    if (_forecast == null) {
      WeatherClient().todayForecast(client).then((onValue) {
        setState(() {
          _forecast = onValue;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _forecast == null ? "Cargando..." : _forecast.pageTitle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: _forecast == null
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _forecast.centerName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _forecast.forecastName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _forecast.forecastDate,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Divider(),
                            SizedBox(height: 5.0),
                            Text(_forecast.forecastTitle,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.blue)),
                            SizedBox(height: 8.0),
                            Text(
                              _forecast.forecastText,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              'Autores',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: meteorologistImg(
                                                    _forecast.authors[0]) !=
                                                null
                                            ? NetworkImage(meteorologistImg(
                                                _forecast.authors[0]))
                                            : ExactAssetImage(
                                                'images/no-image.png'),
                                        radius: 30.0,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          _forecast.authors[0],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: meteorologistImg(
                                                    _forecast.authors[1]) !=
                                                null
                                            ? NetworkImage(meteorologistImg(
                                                _forecast.authors[1]))
                                            : ExactAssetImage(
                                                'images/no-image.png'),
                                        radius: 30.0,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          _forecast.authors[1],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                'Fuente: ${_forecast.dataSource}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w200, fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Image(
          image: ExactAssetImage('images/logo_insmet.png'),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        mini: true,
        onPressed: () {
          print('Clicked');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
