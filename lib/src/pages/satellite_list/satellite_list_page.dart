import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

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
            return InkWell(
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
                child: GFListTile(
                  avatar: Container(
                    height: 100.0,
                    width: 130.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            topLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            topRight: Radius.circular(5),
                            ),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'images/satellite/${sources[index].image}'))),
                  ),
                  titleText: sources[index].source,
                  subtitleText: sources[index].description,
                  icon: Icon(Icons.arrow_right),
                  color: Colors.white,
                  margin: EdgeInsets.all(5),
                ));
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
