import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

import 'package:cuba_weather/src/pages/pages.dart';
import 'package:cuba_weather/src/utils/utils.dart';

class MunicipalitySelectionPage extends StatefulWidget {
  @override
  State<MunicipalitySelectionPage> createState() =>
      MunicipalitySelectionPageState();
}

class MunicipalitySelectionPageState extends State<MunicipalitySelectionPage> {
  final GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  final textController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).autofocus(focusNode);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text('Seleccionar municipio'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.format_list_bulleted),
            onPressed: () async {
              final municipality = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MunicipalityListPage(),
                ),
              );
              if (municipality != null) {
                setState(() {
                  Navigator.pop(context, municipality);
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () async {
              final municipality = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MunicipalityRecordPage(),
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
      body: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: SimpleAutoCompleteTextField(
                      key: key,
                      controller: textController,
                      suggestions: municipalities.map((m) => m.name).toList(),
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Inserte aquí el municipio deseado',
                      ),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      clearOnSubmit: false,
                      textSubmitted: (text) => setState(() {
                        updateRecords(text);
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
    );
  }
}
