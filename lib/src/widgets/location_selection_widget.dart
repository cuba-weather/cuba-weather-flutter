import 'package:flutter/material.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:cuba_weather/src/widgets/widgets.dart';

class MunicipalitySelectionWidget extends StatefulWidget {
  final List<String> municipalities;

  MunicipalitySelectionWidget({Key key, @required this.municipalities})
      : assert(municipalities != null),
        super(key: key);

  @override
  State<MunicipalitySelectionWidget> createState() =>
      _MunicipalitySelectionWidgetState(municipalities: this.municipalities);
}

class _MunicipalitySelectionWidgetState extends State<MunicipalitySelectionWidget> {
  final GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  final List<String> municipalities;
  final TextEditingController _textController = TextEditingController();

  _MunicipalitySelectionWidgetState({@required this.municipalities})
      : assert(municipalities != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar municipio'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.format_list_bulleted),
            onPressed: () async {
              final municipality = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MunicipalityList(
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
                        suggestions: this.municipalities,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Municipio',
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
