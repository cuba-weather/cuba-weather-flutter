import 'package:cuba_weather/src/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cuba_weather/src/pages/municipality_record/blocs/blocs.dart';
import 'package:cuba_weather/src/pages/municipality_selection/municipality_selection_page.dart';
import 'package:cuba_weather/src/pages/municipality_list/municipality_list_page.dart';
import 'package:cuba_weather/src/utils/utils.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class MunicipalityRecordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MunicipalityRecordPageState();
}

class MunicipalityRecordPageState extends State<MunicipalityRecordPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MunicipalityRecordBloc(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text('Municipios'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final municipality = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MunicipalitySelectionPage(),
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
          ],
        ),
        body: BlocBuilder<MunicipalityRecordBloc, MunicipalityRecordState>(
          builder: (context, state) {
            if (state is MunicipalityRecordInitial) {
              BlocProvider.of<MunicipalityRecordBloc>(context)
                  .add(FetchMunicipalityRecordEvent());
            }
            if (state is MunicipalityRecordLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is MunicipalityRecordError) {
              return ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 150,
                    ),
                  ),
                  Text(
                    Constants.errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        state.errorMessage,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is MunicipalityRecordLoaded) {
              if(state.municipalities.length == 0) {
                return ListView(
                  children: <Widget>[
                    Text(
                      "No hay Historial",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                );
              }
              return ListView.separated(
                itemBuilder: (context, index) {
                  var p = 10.0;
                  return FlatButton(
                    child: Container(
                      padding: index == 0
                          ? EdgeInsets.only(
                              left: p, right: p, bottom: p, top: p * 2)
                          : index == state.municipalities.length - 1
                              ? EdgeInsets.only(
                                  left: p, right: p, bottom: p * 2, top: p)
                              : EdgeInsets.all(p),
                      child: Text(
                        state.municipalities[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        updateRecords(state.municipalities[index]);
                        Navigator.pop(
                            context, state.municipalities[index]);
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.white,
                  );
                },
                itemCount: state.municipalities.length,
              );
            }
            return EmptyWidget();
          },
        ),
      ),
    );
  }
}
