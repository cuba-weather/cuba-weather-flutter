import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:cuba_weather/src/utils/utils.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

import 'blocs/blocs.dart';

class SatellitePage extends StatefulWidget {
  final String satelliteType;
  final String pageTitle;

  SatellitePage({
    Key key,
    @required this.satelliteType,
    @required this.pageTitle,
  })  : assert(satelliteType != null),
        super(key: key);

  @override
  SatellitePageState createState() => SatellitePageState();
}

class SatellitePageState extends State<SatellitePage>
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
        create: (context) => SatelliteBloc(api: CubaWeather()),
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            elevation: 0,
            title: Text(widget.pageTitle),
            centerTitle: true,
          ),
          body: FadeTransition(
            opacity: fadeAnimation,
            child: BlocBuilder<SatelliteBloc, SatelliteState>(
              builder: (context, state) {
                if (state is SatelliteInitial) {
                  fadeController.reset();
                  fadeController.forward();
                  BlocProvider.of<SatelliteBloc>(context).add(FetchSatellite(
                    widget.satelliteType,
                  ));
                }
                if (state is SatelliteLoading) {
                  if (state.showAnimation) {
                    fadeController.reset();
                    fadeController.forward();
                  }
                  return Center(child: CircularProgressIndicator());
                }
                if (state is SatelliteError) {
                  fadeController.reset();
                  fadeController.forward();
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
                if (state is SatelliteLoaded) {
                  if (state.showAnimation) {
                    fadeController.reset();
                    fadeController.forward();
                  }
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
                                  // Text(
                                  //   state.forecast.centerName,
                                  //   style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   state.forecast.forecastName,
                                  //   style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   state.forecast.forecastDate,
                                  //   style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  // Divider(),
                                  // state.forecast.forecastTitle != ""
                                  //     ? SizedBox(height: 5.0)
                                  //     : Container(),
                                  // state.forecast.forecastTitle != ""
                                  //     ? Text(
                                  //         state.forecast.forecastTitle,
                                  //         style: TextStyle(
                                  //           fontStyle: FontStyle.italic,
                                  //           color: Colors.white,
                                  //         ),
                                  //       )
                                  //     : Container(),
                                  // state.forecast.forecastTitle != ""
                                  //     ? SizedBox(height: 8.0)
                                  //     : Container(),
                                  // Text(
                                  //   state.forecast.forecastText,
                                  //   textAlign: TextAlign.justify,
                                  //   style: TextStyle(
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container(
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceAround,
                                //     children: buildAuthors(state.forecast),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
                                      'Fuente: ${state.satellite.dataSource}',
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
                          Image.network( state.satellite.imageUrl)
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
}
