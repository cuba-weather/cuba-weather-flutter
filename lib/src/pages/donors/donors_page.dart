import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cuba_weather/src/pages/donors/widgets/widgets.dart';

class DonorsPage extends StatefulWidget {
  const DonorsPage();

  @override
  State<StatefulWidget> createState() => DonorsPageState();
}

class DonorsPageState extends State<DonorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Donantes'),
        centerTitle: true,
      ),
      body: ListView(
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
    );
  }
}
