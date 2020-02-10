import 'package:cuba_weather/src/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DonorsListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DonorsListWidgetState();
}

class DonorsListWidgetState extends State<DonorsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donantes'),
      ),
      body: GradientContainerWidget(
        color: Colors.blue,
        child: ListView(
          children: <Widget>[
            DonorWidget(),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            Center(
              child: Text(
                'Total:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Center(
              child: Text(
                '1910 CUP - 20 CUC - 12 CUC (Saldo)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 50))
          ],
        ),
      ),
    );
  }
}
