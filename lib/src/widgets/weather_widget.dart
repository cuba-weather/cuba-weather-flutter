import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cuba_weather/src/blocs/blocs.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class WeatherWidget extends StatefulWidget {
  final String initialLocation;
  final List<String> locations;

  WeatherWidget({
    Key key,
    @required this.locations,
    @required this.initialLocation,
  })  : assert(locations != null),
        super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState(
        locations: this.locations,
        initialLocation: this.initialLocation,
      );
}

class _WeatherWidgetState extends State<WeatherWidget> {
  final String initialLocation;
  final List<String> locations;
  Completer<void> _refreshCompleter;
  String appName = '';
  String version = '';

  _WeatherWidgetState({
    @required this.locations,
    @required this.initialLocation,
  }) : assert(locations != null);

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    if (this.initialLocation != null) {
      BlocProvider.of<WeatherBloc>(context).add(FetchWeather(
        location: this.initialLocation,
      ));
    }
    start();
  }

  void start() async {
    var packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(context),
            _createDrawerItem(context,
                icon: Icons.location_on, text: 'Localizaciones', onTap: () {
              Navigator.of(context).pop();
              getLocation(context).then((location) {
                if (location != null) {
                  BlocProvider.of<WeatherBloc>(context).add(FetchWeather(
                    location: location.toString(),
                  ));
                }
              });
            }),
            _createDrawerItem(context, icon: Icons.info, text: 'Información',
                onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InformationWidget(),
                ),
              );
            }),
            Divider(),
            _createDrawerItem(
              context,
              icon: Icons.bug_report,
              text: 'Reportar un error',
              onTap: () async {
                const url = 'mailto:leynier41@gmail.com';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  log('Could not launch $url');
                }
              },
            ),
            ListTile(
              title: Text(
                'v$version',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 10),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/logo.png',
              fit: BoxFit.cover,
              height: 35.0,
            ),
            Text(
              appName,
              textAlign: TextAlign.center,
            )
          ],
        ),
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
                BlocProvider.of<WeatherBloc>(context).add(FetchWeather(
                  location: location,
                ));
              }
            },
          ),
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
                return GradientContainerWidget(
                  color: Colors.blue,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.only(bottom: 200),
                      child: Text(
                        'Por favor, seleccione una localización presionando '
                        'sobre el ícono de una lupa en la parte superior '
                        'derecha de la pantalla.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }
              if (state is WeatherLoading) {
                return GradientContainerWidget(
                  color: Colors.blue,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
                );
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
                          padding: EdgeInsets.only(top: 20.0),
                          child: Center(
                            child:
                                NameLocationWidget(location: weather.cityName),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.0),
                          child: Center(
                            child: CombinedWeatherWidget(
                              weather: weather,
                            ),
                          ),
                        ),
                         Center(
                          child: LastUpdatedWidget(dateTime: weather.dateTime),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is WeatherError) {
                return GradientContainerWidget(
                  color: Colors.blue,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.only(bottom: 200),
                      child: Text(
                        'Error: ${state.errorMessage}',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _createHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        appName,
        style: TextStyle(fontSize: 20.0),
      ),
      accountEmail: Text("De Cuba para Cuba"),
      currentAccountPicture: CircleAvatar(
        backgroundImage: ExactAssetImage('images/logo.png'),
      ),
      otherAccountsPictures: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  Widget _createDrawerItem(BuildContext context,
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
        title: Row(
          children: <Widget>[
            Icon(icon),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(text),
            )
          ],
        ),
        onTap: onTap);
  }

  Future getLocation(BuildContext context) async {
    final location = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationList(
          locations: this.locations,
        ),
      ),
    );
    return location;
  }
}
