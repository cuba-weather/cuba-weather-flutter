import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cuba_weather/src/widgets/widgets.dart';

class LocationList extends StatefulWidget {
  final List<String> locations;

  const LocationList({@required this.locations}) : assert(locations != null);

  @override
  State<StatefulWidget> createState() => LocationListState(
        locations: locations,
      );
}

class LocationListState extends State<LocationList> {
  final List<String> locations;

  LocationListState({@required this.locations}) : assert(locations != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localizaciones'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final location = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationSelectionWidget(
                    locations: this.locations,
                  ),
                ),
              );
              if (location != null) {
                setState(() {
                  Navigator.pop(context, location);
                });
              }
            },
          ),
        ],
      ),
      body: GradientContainerWidget(
        color: Colors.blue,
        child: ListView.separated(
          itemBuilder: (context, index) {
            var p = 10.0;
            return FlatButton(
              child: Container(
                padding: index == 0
                    ? EdgeInsets.only(left: p, right: p, bottom: p, top: p * 2)
                    : index == locations.length - 1
                        ? EdgeInsets.only(
                            left: p, right: p, bottom: p * 2, top: p)
                        : EdgeInsets.all(p),
                child: Text(
                  locations[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context, locations[index]);
                });
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.white,
            );
          },
          itemCount: this.locations.length,
        ),
      ),
    );
  }
}
