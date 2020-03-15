import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
