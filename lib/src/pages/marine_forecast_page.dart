import 'package:cuba_weather/src/models/models.dart';
import 'package:cuba_weather/src/utils/constants.dart';
import 'package:cuba_weather/src/utils/weather_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarineForecastPage extends StatefulWidget {
  final String forecastType;
  final String pageTitle;

  MarineForecastPage({
    Key key,
    @required this.forecastType,
    @required this.pageTitle,
  })  : assert(forecastType != null),
        super(key: key);

  @override
  _MarineForecastPageState createState() => _MarineForecastPageState();
}

class _MarineForecastPageState extends State<MarineForecastPage> {
  MarineForecastModel _forecast;
  var client = Client();

  bool error = false;
  String errorMessage;

  Future<void> setValueShowImage(bool newValue) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('showImageForecastPage', newValue);
  }

  @override
  Widget build(BuildContext context) {
    if (_forecast == null && !error) {
      switch (widget.forecastType) {
        case 'marine':
          WeatherClient().marineForecast(client).then((onValue) {
            setState(() {
              _forecast = onValue;
            });
          }).catchError((onError) {
            setState(() {
              if (onError is BadRequestException) {
                errorMessage = Constants.errorMessageBadRequestException;
                error = true;
              } else if (onError is ParseException) {
                errorMessage = Constants.errorMessageParseException;
                error = true;
              } else {
                errorMessage = onError.toString();
                error = true;
              }
            });
          });
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pageTitle,
        ),
      ),
      body: error
          ? ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.blue,
                    size: 150,
                  ),
                ),
                Text(
                  Constants.errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(20),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      errorMessage,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : _forecast == null
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  _forecast.forecastName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  _forecast.forecastDate,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SITUACIÓN METEOROLÓGICA SIGNIFICATIVA:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Divider(),
                                Text(
                                  _forecast.significantSituation,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'GOLFO DE MÉXICO:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Divider(),
                                Text(
                                  _forecast.areaGulfOfMexico,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PUERTO RICO Y LA FLORIDA HASTA LAS BERMUDAS:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Divider(),
                                Text(
                                  _forecast.areaRest,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Card(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: _buildAuthors(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    'Fuente: ${_forecast.dataSource}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 13,
                                    ),
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
    );
  }

  List<Widget> _buildAuthors() {
    return _forecast.authors.length > 1
        ? [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  _forecast.authors[0] != ""
                      ? CircleAvatar(
                          backgroundImage: ExactAssetImage(
                              Constants.authorsPlaceHolderImageAssetURL),
                          radius: 30.0,
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _forecast.authors[0],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
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
                    backgroundImage: ExactAssetImage(
                        Constants.authorsPlaceHolderImageAssetURL),
                    radius: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _forecast.authors[1],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
        : [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: ExactAssetImage(
                        Constants.authorsPlaceHolderImageAssetURL),
                    radius: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _forecast.authors[0],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ];
  }
}
