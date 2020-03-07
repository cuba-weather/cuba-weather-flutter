import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:cuba_weather/src/utils/app_state_notifier.dart';

class GradientContainerWidget extends StatelessWidget {
  final Widget child;
  const GradientContainerWidget({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Provider.of<AppStateNotifier>(context).isDarkModeOn) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.6, 0.8, 1.0],
            colors: [
              Colors.black,
              Colors.black,
              Colors.black,
            ],
          ),
        ),
        child: child,
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.6, 0.8, 1.0],
            colors: [
              Colors.blue[700],
              Colors.blue[700],
              Colors.blue[700],
            ],
          ),
        ),
        child: child,
      );
    }
  }
}
