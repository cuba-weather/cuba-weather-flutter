import 'package:cuba_weather/src/models/models.dart';
import 'package:cuba_weather/src/utils/weather_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForecastPage extends StatefulWidget {
  final String forecastType;
  final String pageTitle;

  ForecastPage({
    Key key,
    @required this.forecastType,
    @required this.pageTitle,
  })  : assert(forecastType != null),
        super(key: key);

  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  ForecastModel _forecast;
  var client = Client();
  bool showImage = false;
  bool error = false;
  String errorMessage;

  Future<bool> recoverValueShowImage() async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getBool('showImageForecastPage') ?? false;
    this.showImage = value;
    return value;
  }

  Future<void> setValueShowImage(bool newValue) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('showImageForecastPage', newValue);
    this.showImage = newValue;
  }

  @override
  Widget build(BuildContext context) {
    recoverValueShowImage();
    if (_forecast == null && !error) {
      switch (widget.forecastType) {
        case 'today':
          WeatherClient().todayForecast(client).then((onValue) {
            setState(() {
              _forecast = onValue;
            });
          }).catchError((onError) {
            setState(() {
              if (onError is BadRequestException) {
                errorMessage = 'No se ha podido establecer conexión con la '
                    'red nacional. Por favor, revise su conexión y vuelva a '
                    'intentarlo.';
                error = true;
              } else {
                errorMessage = onError.toString();
                error = true;
              }
            });
          });
          break;
        case 'tomorrow':
          WeatherClient().tomorrowForecast(client).then((onValue) {
            setState(() {
              _forecast = onValue;
            });
          }).catchError((onError) {
            setState(() {
              if (onError is BadRequestException) {
                errorMessage = 'No se ha podido establecer conexión con la '
                    'red nacional. Por favor, revise su conexión y vuelva a '
                    'intentarlo.';
                error = true;
              } else if (onError is ParseException) {
                errorMessage = 'La fuente de datos a cambiado el formato. '
                    'Espere una nueva actualización de la aplicación para '
                    'adaptarse a este.';
                error = true;
              } else {
                errorMessage = onError.toString();
                error = true;
              }
            });
          });
          break;
        case 'perspectives':
          WeatherClient().perspectiveForecast(client).then((onValue) {
            setState(() {
              _forecast = onValue;
            });
          }).catchError((onError) {
            setState(() {
              if (onError is BadRequestException) {
                errorMessage = 'No se ha podido establecer conexión con la '
                    'red nacional. Por favor, revise su conexión y vuelva a '
                    'intentarlo.';
                error = true;
              } else if (onError is ParseException) {
                errorMessage = 'La fuente de datos a cambiado el formato. '
                    'Espere una nueva actualización de la aplicación para '
                    'adaptarse a este.';
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
                  'Ha ocurrido un error',
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
                                Divider(),
                                _forecast.forecastTitle != ""
                                    ? SizedBox(height: 5.0)
                                    : Container(),
                                _forecast.forecastTitle != ""
                                    ? Text(
                                        _forecast.forecastTitle,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : Container(),
                                _forecast.forecastTitle != ""
                                    ? SizedBox(height: 8.0)
                                    : Container(),
                                Text(
                                  _forecast.forecastText,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
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
                        _forecast.imageUrl != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text('Mostrar imagen',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      )),
                                  Switch(
                                    value: showImage,
                                    onChanged: (value) {
                                      setState(() {
                                        setValueShowImage(value);
                                      });
                                    },
                                    activeTrackColor: Colors.lightBlueAccent,
                                    activeColor: Colors.blue,
                                  ),
                                ],
                              )
                            : Container(),
                        _forecast.imageUrl != null
                            ? showImage
                                ? FadeInImage.assetNetwork(
                                    placeholder: 'images/loading.gif',
                                    image: _forecast.imageUrl,
                                  )
                                : Container()
                            : Container()
                      ],
                    ),
                  ),
                ),
    );
  }

  List<Widget> _buildAuthors() {
    return _forecast.authors[0] != ""
        ? [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  _forecast.authors[0] != ""
                      ? CircleAvatar(
                          backgroundImage:
                              meteorologistImg(_forecast.authors[0]) != null
                                  ? NetworkImage(
                                      meteorologistImg(_forecast.authors[0]))
                                  : ExactAssetImage('images/no-image.png'),
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
                    backgroundImage: meteorologistImg(_forecast.authors[1]) !=
                            null
                        ? NetworkImage(meteorologistImg(_forecast.authors[1]))
                        : ExactAssetImage('images/no-image.png'),
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
                    backgroundImage: meteorologistImg(_forecast.authors[1]) !=
                            null
                        ? NetworkImage(meteorologistImg(_forecast.authors[1]))
                        : ExactAssetImage('images/no-image.png'),
                    radius: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _forecast.authors[1],
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
      case 'MAHernandez':
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
      case 'ASanchez':
        return url + 'ASanchez.jpg';
        break;
      case 'ALima':
        return url + 'ALima.jpg';
        break;
      case 'JASerrano':
        return url + 'JASerrano.jpg';
        break;
      case 'GAguilar':
        return url + 'GAguilar.jpg';
        break;
      case 'NFournier':
        return url + 'NFournier.jpg';
        break;
      case 'JGonzález':
        return url + 'JGonzález.jpg';
        break;
      case 'Amengana':
        return url + 'Amengana.jpg';
        break;
      case 'Miri':
        return url + 'Miri.jpg';
        break;
      case 'Yinelis':
        return url + 'Yinelis.jpg';
        break;
      case 'GEstevez':
        return url + 'GEstevez.jpg';
        break;
      case 'YCedeno':
        return url + 'YCedeno.jpg';
        break;
      case 'JPalacios':
        return url + 'JPalacios.jpg';
        break;
      case 'AEspinosa':
        return url + 'A.Espinosa.jpg';
        break;
      case 'YMartinez':
        return url + 'Y.Martinez.jpg';
        break;
      case 'EVázquez':
        return url + 'E. Vázquez.JPG';
        break;
      case 'AOtero':
        return url + 'A.Otero.jpg';
        break;
      case 'AMiro':
        return url + 'A.Miro.jpg';
        break;
      case 'AWong':
        return url + 'A.Wong.jpg';
        break;
      default:
        return null;
    }
  }
}
