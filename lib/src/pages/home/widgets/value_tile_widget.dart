import 'package:flutter/material.dart';

import 'package:cuba_weather/src/widgets/widgets.dart';

class ValueTileWidget extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconData;
  final Widget widget;

  ValueTileWidget(this.label, this.value, {this.iconData, this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        this.label != null
            ? Text(
                this.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            : EmptyWidget(),
        this.iconData != null
            ? Icon(
                iconData,
                color: Colors.white,
                size: 20,
              )
            : EmptyWidget(),
        this.widget != null ? widget : EmptyWidget(),
        SizedBox(
          height: 10,
        ),
        Text(
          this.value,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
