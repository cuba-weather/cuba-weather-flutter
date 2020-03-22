import 'package:cuba_weather/src/utils/utils.dart';
import 'package:flutter/material.dart';

class RadarPage extends StatefulWidget {
  final String placeHolderImage;
  final String radarName;
  final String imgUrl;

  RadarPage({
    Key key,
    @required this.placeHolderImage,
    @required this.radarName,
    @required this.imgUrl,
  })  : assert(placeHolderImage != null),
        assert(imgUrl != null),
        super(key: key);

  @override
  _RadarPageState createState() => _RadarPageState();
}

class _RadarPageState extends State<RadarPage> with TickerProviderStateMixin {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.radarName),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                CircleAvatar(
                  backgroundImage:
                      AssetImage('images/radar/${widget.placeHolderImage}'),
                  radius: 70.0,
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
            Image.network(widget.imgUrl),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Fuente: ' + Constants.insmetForecastSource,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
