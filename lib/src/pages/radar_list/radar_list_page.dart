import 'dart:ui';
import 'package:flutter/material.dart';

import '../radar/radar_page.dart';

class RadarListPage extends StatefulWidget {
  @override
  _RadarListPageState createState() => _RadarListPageState();
}

class _RadarListPageState extends State<RadarListPage> with TickerProviderStateMixin{
  AnimationController fadeController;
  Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    fadeAnimation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Imágenes de radar'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[_mosaico(context), _radarButtons(context)],
            ),
          )
        ],
      ),
    );
  }

  Widget _mosaico(BuildContext context) {
    return SafeArea(
        child: Table(
      children: [
        TableRow(children: [
          _createRadarButton(context, 'Mosaico', '4picoSanjuan.jpg', true,
              'http://www.insmet.cu/Radar/NacComp200Km.gif'),
        ])
      ],
    ));
  }

  Widget _radarButtons(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _createRadarButton(context, 'La Bajada', '1labajada.jpg', false, ''),
          _createRadarButton(context, 'Casablanca', '2CasaBlanca.jpg', true,
              'http://www.insmet.cu/Radar/01Casablanca/csbMAXw01a.gif'),
        ]),
        TableRow(children: [
          _createRadarButton(
              context, 'Punta del Este', '3Puntaeste.jpg', false, ''),
          _createRadarButton(context, 'Pico San Juan', '4picoSanjuan.jpg', true,
              'http://www.insmet.cu/Radar/01Casablanca/csbMAXw01a.gif'),
        ]),
        TableRow(children: [
          _createRadarButton(context, 'Camagüey', '5Camaguey.jpg', true,
              'http://www.insmet.cu/Radar/01Casablanca/csbMAXw01a.gif'),
          _createRadarButton(context, 'Pilón', '6pilon.jpg', true,
              'http://www.insmet.cu/Radar/01Casablanca/csbMAXw01a.gif'),
        ]),
        TableRow(children: [
          _createRadarButton(context, 'Gran Piedra', '7granPiedra.jpg', true,
              'http://www.insmet.cu/Radar/01Casablanca/csbMAXw01a.gif'),
          _createRadarButton(context, 'Holguín', '8granPiedra.jpg', false, ''),
        ]),
      ],
    );
  }

  _createRadarButton(BuildContext context, String radarName,
      String placeHolderImage, bool active, String animatedGifUrl) {
    return InkWell(
      onTap: () {
        if (active) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RadarPage(
                radarName: radarName,
                placeHolderImage: placeHolderImage,
                imgUrl: animatedGifUrl,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 180.0,
              //margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(12, 66, 107, 0.5),
                //borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('images/radar/$placeHolderImage'),
                    radius: 70.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor:
                            active ? Colors.green : Colors.red[300],
                        radius: 10.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        radarName,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
