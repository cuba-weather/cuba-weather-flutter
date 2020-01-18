import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cuba_weather/src/blocs/blocs.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

class WeatherWidget extends StatefulWidget {
  final List<String> locations;

  WeatherWidget({Key key, @required this.locations})
      : assert(locations != null),
        super(key: key);

  @override
  State<WeatherWidget> createState() =>
      _WeatherWidgetState(locations: this.locations);
}

class _WeatherWidgetState extends State<WeatherWidget> {
  final List<String> locations;
  Completer<void> _refreshCompleter;

  _WeatherWidgetState({@required this.locations}) : assert(locations != null);

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    start();
  }

  void start() async {
    String _value;
    try {
      var prefs = await SharedPreferences.getInstance();
      _value = prefs.getString('location');
      BlocProvider.of<WeatherBloc>(context)
          .add(FetchWeather(location: _value));
    } catch (e) {
      log(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuba Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final location = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationSelectionWidget(),
                ),
              );
              if (location != null) {
                BlocProvider.of<WeatherBloc>(context)
                    .add(FetchWeather(location: location));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherLoaded) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherEmpty) {
                return Center(child: Text('Por favor, seleccione una localización.'));
              }
              if (state is WeatherLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is WeatherLoaded) {
                final weather = state.weather;

                return GradientContainerWidget(
                  color: Colors.blue,
                  child: RefreshIndicator(
                    onRefresh: () {
                      BlocProvider.of<WeatherBloc>(context).add(
                        RefreshWeather(location: weather.cityName),
                      );
                      return _refreshCompleter.future;
                    },
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 100.0),
                          child: Center(
                            child:
                                NameLocationWidget(location: weather.cityName),
                          ),
                        ),
                        Center(
                          child: LastUpdatedWidget(dateTime: weather.dt.date),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.0),
                          child: Center(
                            child: CombinedWeatherWidget(
                              weather: weather,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            },
          ),
        ),
      ),
    );
  }
}
