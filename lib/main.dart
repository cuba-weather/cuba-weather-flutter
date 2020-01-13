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
  String _text;

  void _search() {
    log('Searching...');
    _cubaWeather.get(_textEditingController.text, suggestion: true).then((weather) {
      setState(() {
        _text = weather.toString();
        log(_text);
      });
    }).catchError((error) {
      setState(() {
        if (error is InvalidLocationException) {
          _text = error.message;
        } else if (error is BadRequestException) {
          _text = error.message;
        } else {
          _text = error.toString();
        }
        log(_text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_text ?? ''),
            TextField(controller: _textEditingController),
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
