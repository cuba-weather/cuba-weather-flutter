import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cuba_weather/src/blocs/blocs.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

class WeatherWidget extends StatefulWidget {
  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
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
                return Center(child: Text('Please Select a Location'));
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
