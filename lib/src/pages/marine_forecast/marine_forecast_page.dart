import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

import 'package:cuba_weather/src/pages/marine_forecast/blocs/blocs.dart';
import 'package:cuba_weather/src/utils/utils.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

class MarineForecastPage extends StatefulWidget {
  final String forecastType;
  final String pageTitle;

  MarineForecastPage({
    Key key,
    @required this.forecastType,
    @required this.pageTitle,
  })  : assert(forecastType != null),
        super(key: key);

  @override
  MarineForecastPageState createState() => MarineForecastPageState();
}

class MarineForecastPageState extends State<MarineForecastPage>
    with TickerProviderStateMixin {
  AnimationController fadeController;
  Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    fadeAnimation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MarineForecastBloc(api: CubaWeather()),
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            elevation: 0,
            title: Text(widget.pageTitle),
            centerTitle: true,
          ),
          body: FadeTransition(
            opacity: fadeAnimation,
            child: BlocBuilder<MarineForecastBloc, MarineForecastState>(
              builder: (context, state) {
                fadeController.reset();
                fadeController.forward();
                if (state is MarineForecastInitial) {
                  BlocProvider.of<MarineForecastBloc>(context)
                      .add(FetchMarineForecast(
                    widget.forecastType,
                  ));
                }
                if (state is MarineForecastLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is MarineForecastError) {
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
                if (state is MarineForecastLoaded) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.forecast.centerName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    state.forecast.forecastName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    state.forecast.forecastDate,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SITUACIÓN METEOROLÓGICA SIGNIFICATIVA:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Divider(),
                                  Text(
                                    state.forecast.significantSituation,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'GOLFO DE MÉXICO:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Divider(),
                                  Text(
                                    state.forecast.areaGulfOfMexico,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PUERTO RICO Y LA FLORIDA HASTA LAS BERMUDAS:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Divider(),
                                  Text(
                                    state.forecast.areaRest,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Text(
                                    'Autores',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: _buildAuthors(state.forecast),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
                                      'Fuente: ${state.forecast.dataSource}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return EmptyWidget();
              },
            ),
          ),
        ));
  }

  List<Widget> _buildAuthors(InsmetMarineForecastModel forecast) {
    return forecast.authors.length > 1
        ? [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  forecast.authors[0] != ""
                      ? CircleAvatar(
                          backgroundImage: ExactAssetImage(
                              Constants.authorsPlaceHolderImageAssetURL),
                          radius: 30.0,
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      forecast.authors[0],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: ExactAssetImage(
                        Constants.authorsPlaceHolderImageAssetURL),
                    radius: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      forecast.authors[1],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
        : [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: ExactAssetImage(
                        Constants.authorsPlaceHolderImageAssetURL),
                    radius: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      forecast.authors[0],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ];
  }
}
