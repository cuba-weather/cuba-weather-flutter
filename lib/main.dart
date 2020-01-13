import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

void main() => runApp(App());

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
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final _cubaWeather = CubaWeather();
  final _textEditingController = TextEditingController();
  bool _loading = false;

  Widget _alertDialog(context, WeatherModel weather) {
    return AlertDialog(
      title: Text(weather.cityName),
      content: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Text('Temperatura: '),
            Text('${weather.temp}')
          ]),
          Row(children: <Widget>[Text('Fecha: '), Text('${weather.dt.date}')]),
          Row(children: <Widget>[
            Text('Humedad: '),
            Text('${weather.humidity}')
          ]),
          Row(children: <Widget>[
            Text('Presión: '),
            Text('${weather.pressure}')
          ]),
          Row(children: <Widget>[
            Text('Viento: '),
            Text('${weather.windstring}')
          ]),
          Row(children: <Widget>[
            Text('Descripción: '),
            Text('${weather.descriptionWeather}')
          ]),
          Row(children: <Widget>[Image.network(weather.iconWeather)]),
        ],
      ),
    );
  }

  void _search() async {
    setState(() {
      _loading = true;
    });
    log('Searching...');
    try {
      var text = _textEditingController.text;
      var weather = await _cubaWeather.get(text, suggestion: true);
      return showDialog(
          context: context,
          builder: (context) => _alertDialog(context, weather));
    } on InvalidLocationException catch (error) {
      log(error.message);
    } on BadRequestException catch (error) {
      log(error.message);
    } catch (error) {
      log(error);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: TextField(
                  controller: _textEditingController,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _search,
          tooltip: 'Search',
          child: Icon(Icons.search),
        ),
      );
    }
  }
}
