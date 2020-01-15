import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuba Weather',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Cuba Weather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final CubaWeather _cubaWeather = CubaWeather();
  final List<String> _locations = locations..sort();
  bool _error = false;
  bool _loading = true;
  String _value;
  WeatherModel _weather;

  MyHomePageState() {
    _value = _locations[0];
    _cubaWeather.get(_value).then((weather) {
      setState(() {
        _error = false;
        _loading = false;
        _weather = weather;
      });
    }).catchError((error) {
      log(error);
      setState(() {
        _error = true;
        _loading = false;
      });
    });
  }

  Widget _buildCard(String key, String value, {double fondSize = 14}) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          children: <Widget>[
            Text(key,
                style:
                    TextStyle(fontSize: fondSize, fontWeight: FontWeight.bold)),
            Expanded(child: Text(value, style: TextStyle(fontSize: fondSize))),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _value,
                  icon: Icon(Icons.arrow_drop_down),
                  items:
                      _locations.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: _onChangeDropdownButton,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildError() {
    return Center(
        child: Text(
            'Ha ocurrido un error.\nSeleccione nuevamente una localización',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16)));
  }

  Widget _buildWeather() {
    return ListView(
      children: <Widget>[
        _buildCard('Resumen: ', '${_weather.descriptionWeather}'),
        _buildCard('Temperatura: ', '${_weather.temp}°C'),
        _buildCard('Humedad: ', '${_weather.humidity}%'),
        _buildCard('Presión: ', '${_weather.pressure} hpa'),
        _buildCard('Vientos: ', '${_weather.windstring}'),
        _buildCard('Fecha: ', '${_weather.dt.date}'),
        Image.network(_weather.iconWeather),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _buildTop(),
        Expanded(
          child: _loading
              ? _buildLoading()
              : _error ? _buildError() : _buildWeather(),
        ),
      ],
    );
  }

  void _onChangeDropdownButton(newValue) async {
    setState(() {
      _value = newValue;
      _loading = true;
      _error = false;
    });
    try {
      _weather = await _cubaWeather.get(_value);
      setState(() {
        _error = false;
        _loading = false;
      });
    } catch (e) {
      log(e);
      setState(() {
        _error = true;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _buildBody(),
    );
  }
}
