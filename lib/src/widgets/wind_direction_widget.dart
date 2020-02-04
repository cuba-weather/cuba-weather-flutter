import 'package:flutter/material.dart';
import 'package:cuba_weather_redcuba_dart/src/models/weather_model.dart'
as redCuba;
import 'package:weather_icons/weather_icons.dart';

class WindDirectionWidget extends StatelessWidget {
  final redCuba.CardinalPoint direction;

  WindDirectionWidget(this.direction, {Key key}): assert(direction != null), super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
        width: 30,
        height: 30,
        child: _parseWindDirection(direction),
    );
  }
  
  static Widget _parseWindDirection(redCuba.CardinalPoint dir){
    switch(dir){
      case redCuba.CardinalPoint.North:
        return _arrowicon(WeatherIcons.direction_down,);
      case  redCuba.CardinalPoint.North_Northeast:
        return _multi_arrow(WeatherIcons.direction_down, WeatherIcons.direction_down_left);
      case redCuba.CardinalPoint.Northeast:
        return _arrowicon(WeatherIcons.direction_down_left);
      case redCuba.CardinalPoint.East_Northeast:
        return _multi_arrow(WeatherIcons.direction_down_left, WeatherIcons.direction_left);
      case redCuba.CardinalPoint.East:
        return _arrowicon(WeatherIcons.direction_left);
      case redCuba.CardinalPoint.East_Southeast:
        return _multi_arrow(WeatherIcons.direction_left, WeatherIcons.direction_up_left);
      case redCuba.CardinalPoint.Southeast:
        return _arrowicon(WeatherIcons.direction_up_left);
      case redCuba.CardinalPoint.South_Southeast:
        return _multi_arrow(WeatherIcons.direction_up_left, WeatherIcons.direction_up);
      case redCuba.CardinalPoint.South:
        return _arrowicon(WeatherIcons.direction_up);
      case redCuba.CardinalPoint.South_Southwest:
        return _multi_arrow(WeatherIcons.direction_up, WeatherIcons.direction_up_right);
      case redCuba.CardinalPoint.Southwest:
        return _arrowicon(WeatherIcons.direction_up_right);
      case redCuba.CardinalPoint.West_Southwest:
        return _multi_arrow(WeatherIcons.direction_up_right, WeatherIcons.direction_right);
      case redCuba.CardinalPoint.West:
        return _arrowicon(WeatherIcons.direction_right);
      case redCuba.CardinalPoint.West_Northwest:
        return _multi_arrow(WeatherIcons.direction_right, WeatherIcons.direction_down_right);
      case redCuba.CardinalPoint.Northwest:
        return _arrowicon(WeatherIcons.direction_down_right);
      case redCuba.CardinalPoint.North_Northwest:
        return _multi_arrow(WeatherIcons.direction_down_right, WeatherIcons.direction_down);
      default:
        return _arrowicon(WeatherIcons.wind);
    }
  }

  static Icon _arrowicon(IconData type, [size=30.0])
  {
    return Icon(type, color: Colors.white, size: size,);
  }

  static Stack _multi_arrow(IconData type1, IconData type2, {size1=30.0, size2=30.0 , bottom1=0.0, left1=0.0, right1=0.0, top1=0.0, bottom2=0.0, left2=0.0, right2=0.0, top2=0.0}){
    return Stack(
      children: <Widget>[
        new Positioned(
            bottom: bottom1,
            left: left1,
            right: right1,
            top: top1,
            child: _arrowicon(type1, size1)),
        new Positioned(
            bottom: bottom2,
            left: left2,
            right: right2,
            top: top2,
            child: _arrowicon(type2, size2),
        )
      ],
    );
  }

 // static Widget _complex_arrow(redCuba.CardinalPoint point)
 // {

 // }

/*
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Stack(
                      children: <Widget>[
                        new Positioned(
                            bottom: 0,
                            child: new Icon(WeatherIcons.direction_down_right,color: Colors.white, size: 35,)),
                        new Positioned(
                            right: 6,
                            child: new Icon(WeatherIcons.direction_down,color: Colors.white, size: 30)),
                      ],
                    ),
                  ),


                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Stack(
                      children: <Widget>[
                        new Positioned(
                            bottom: 0,
                            left: 0,
                            right: 6,
                            top: 0,
                            child: new Icon(WeatherIcons.direction_down_right,color: Colors.white, size: 35,)),
                        new Positioned(
                            right: 0,
                            bottom: 7,
                            child: new Icon(WeatherIcons.direction_right,color: Colors.white, size: 30)),
                      ],
                    ),
                  ),


                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Stack(
                      children: <Widget>[
                        new Positioned(
                            bottom: 0,
                            left: 0,
                            right: 6,
                            top: 0,
                            child: new Icon(WeatherIcons.direction_up_right,color: Colors.white, size: 35,)),
                        new Positioned(
                            right: 0,
                            bottom: 0,
                            top: 12,
                            child: new Icon(WeatherIcons.direction_right,color: Colors.white, size: 30)),
                      ],
                    ),
                  ),


                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Stack(
                      children: <Widget>[
                        new Positioned(
                            bottom: 0,
                            left: 17,
                            right: 0,
                            top: 0,
                            child: new Icon(WeatherIcons.direction_up_right,color: Colors.white, size: 35,)),
                        new Positioned(
                            right: 0,
                            bottom: 0,
                            top: 0,
                            child: new Icon(WeatherIcons.direction_up,color: Colors.white, size: 30)),
                      ],
                    ),
                  ),

                    SizedBox(
                    width: 30,
                    height: 30,
                    child: Stack(
                      children: <Widget>[
                        new Positioned(
                            bottom: 0,
                            left: 0,
                            right: 17,
                            top: 0,
                            child: new Icon(WeatherIcons.direction_up_left,color: Colors.white, size: 35,)),
                        new Positioned(
                            right: 0,
                            bottom: 0,
                            top: 0,
                            child: new Icon(WeatherIcons.direction_up,color: Colors.white, size: 30)),
                      ],
                    ),
                  ),




 */

}