import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

import 'package:cuba_weather/src/pages/pages.dart';

class MunicipalityListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MunicipalityListPageState();
}

class MunicipalityListPageState extends State<MunicipalityListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        title: Text('Municipios'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final municipality = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MunicipalitySelectionPage(),
                ),
              );
              if (municipality != null) {
                setState(() {
                  Navigator.pop(context, municipality);
                });
              }
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          var p = 10.0;
          return FlatButton(
            child: Container(
              padding: index == 0
                  ? EdgeInsets.only(left: p, right: p, bottom: p, top: p * 2)
                  : index == municipalities.length - 1
                      ? EdgeInsets.only(
                          left: p, right: p, bottom: p * 2, top: p)
                      : EdgeInsets.all(p),
              child: Text(
                municipalities[index].name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onPressed: () {
              setState(() {
                Navigator.pop(context, municipalities[index].name);
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.white,
          );
        },
        itemCount: municipalities.length,
      ),
    );
  }
}
