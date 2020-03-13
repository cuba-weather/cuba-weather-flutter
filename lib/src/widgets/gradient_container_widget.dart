import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class GradientContainerWidget extends StatelessWidget {
  final Widget child;

  const GradientContainerWidget({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.6, 0.8, 1.0],
          colors: [
            Colors.blue[700],
            Colors.blue[500],
            Colors.blue[300],
          ],
        ),
      ),
      child: child,
    );
  }
}
