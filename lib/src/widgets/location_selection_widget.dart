import 'package:flutter/material.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:cuba_weather/src/widgets/widgets.dart';

class LocationSelectionWidget extends StatefulWidget {
  final List<String> locations;

  LocationSelectionWidget({Key key, @required this.locations})
      : assert(locations != null),
        super(key: key);

  @override
  State<LocationSelectionWidget> createState() =>
      _LocationSelectionWidgetState(locations: this.locations);
}

class _LocationSelectionWidgetState extends State<LocationSelectionWidget> {
  final GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  final List<String> locations;
  final TextEditingController _textController = TextEditingController();

  _LocationSelectionWidgetState({@required this.locations})
      : assert(locations != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar localización'),
      ),
      body: GradientContainerWidget(
        color: Colors.blue,
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    color: Colors.blue,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: SimpleAutoCompleteTextField(
                        key: key,
                        controller: _textController,
                        suggestions: this.locations,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Localización',
                        ),
                        style: TextStyle(color: Colors.white),
                        clearOnSubmit: false,
                        textSubmitted: (text) => setState(() {
                          Navigator.pop(context, text);
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
