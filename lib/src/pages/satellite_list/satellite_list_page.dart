import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../satellite/satellite_page.dart';
import 'models/models.dart';

class SatelliteListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SatelliteListPageState();
}

class SatelliteListPageState extends State<SatelliteListPage> {
  List sources;

  @override
  void initState() {
    sources = getSatelliteImgSources();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text('Imágenes de satélite'),
          centerTitle: true,
        ),
        body: Container(
            child: ListView.builder(
          itemCount: sources.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SatellitePage(
                          pageTitle: sources[index].source,
                          satelliteType: sources[index].image),
                    ),
                  );
                },
                child: Container(
                  height: 100.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topLeft: Radius.circular(5)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'images/satellite/${sources[index].image}'))),
                      ),
                      Container(
                        height: 100,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                sources[index].source,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                child: Container(
                                  width: 260,
                                  child: Text(
                                    sources[index].description,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )));
  }

  List getSatelliteImgSources() {
    return [
      SatelliteList(
          source: 'University of Wisconsin-Madison',
          sourceUrl: 'http://www.ssec.wisc.edu/',
          image: 'latest_eastir.jpg',
          description: 'Atlántico - Canal infrarrojo'),
      SatelliteList(
          source: 'University of Wisconsin-Madison',
          sourceUrl: 'http://www.ssec.wisc.edu/',
          image: 'latest_eastvis.jpg',
          description: 'Mosaico - Canal visible'),
      SatelliteList(
          source: 'University of Wisconsin-Madison',
          sourceUrl: 'http://www.ssec.wisc.edu/',
          image: 'goes.gsfc.nasa.gov.jpg',
          description: 'Cono - Canal visible'),
      SatelliteList(
          source: 'George C. Marshall Space Flight Center',
          sourceUrl: 'https://weather.msfc.nasa.gov/GOES/',
          image: 'cuba-g16.jpg',
          description: 'Caribe - Canal visible'),
      SatelliteList(
          source: 'Weather Underground - Intellicast',
          sourceUrl: 'http://images.intellicast.com',
          image: 'www.intellicast.com.jpg',
          description: 'Cuba - Canal visible'),
    ];
  }
}
