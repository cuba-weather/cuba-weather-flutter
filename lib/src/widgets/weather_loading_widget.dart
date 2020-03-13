import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cuba_weather/src/widgets/widgets.dart';

class WeatherLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientContainerWidget(
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
