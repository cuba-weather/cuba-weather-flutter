import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cuba_weather/src/widgets/widgets.dart';

class MunicipalityList extends StatefulWidget {
  final List<String> municipalities;

  const MunicipalityList({@required this.municipalities})
      : assert(municipalities != null);

  @override
  State<StatefulWidget> createState() => MunicipalityListState(
        municipalities: municipalities,
      );
}

class MunicipalityListState extends State<MunicipalityList> {
  final List<String> municipalities;

  MunicipalityListState({@required this.municipalities})
      : assert(municipalities != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Municipios'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final municipality = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MunicipalitySelectionWidget(
                    municipalities: this.municipalities,
                  ),
                ),
              );
              if (municipality != null) {
                setState(() {
                  Navigator.pop(context, municipality);
                });
              }
            },
          ),
        ],
      ),
      body: GradientContainerWidget(
        child: ListView.separated(
          itemBuilder: (context, index) {
            var p = 10.0;
            return FlatButton(
              child: Container(
                padding: index == 0
                    ? EdgeInsets.only(left: p, right: p, bottom: p, top: p * 2)
                    : index == municipalities.length - 1
                        ? EdgeInsets.only(
                            left: p, right: p, bottom: p * 2, top: p)
                        : EdgeInsets.all(p),
                child: Text(
                  municipalities[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context, municipalities[index]);
                });
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.white,
            );
          },
          itemCount: this.municipalities.length,
        ),
      ),
    );
  }
}
