import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

import 'package:cuba_weather/src/blocs/blocs.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';
import 'package:cuba_weather/src/pages/pages.dart';

class WeatherWidget extends StatefulWidget {
  final String initialMunicipality;
  final List<String> municipalities;

  WeatherWidget({
    Key key,
    @required this.municipalities,
    @required this.initialMunicipality,
  })  : assert(municipalities != null),
        super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState(
        municipalities: this.municipalities,
        initialMunicipality: this.initialMunicipality,
      );
}

class _WeatherWidgetState extends State<WeatherWidget> {
  final String initialMunicipality;
  final List<String> municipalities;
  Completer<void> _refreshCompleter;
  String appName = '';
  String version = '';

  _WeatherWidgetState({
    @required this.municipalities,
    @required this.initialMunicipality,
  }) : assert(municipalities != null);

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    if (this.initialMunicipality != null) {
      BlocProvider.of<WeatherBloc>(context).add(FetchWeather(
        municipality: this.initialMunicipality,
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
    var hour = new DateTime.now().hour;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(context),
            ExpansionTile(
              title: Text('Pronósticos nacionales'),
              children: <Widget>[
                _createDrawerItem(
                  context,
                  icon: Icons.filter_drama,
                  text: 'Hoy',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForecastPage(
                          forecastType: 'today',
                          pageTitle: 'Pronóstico para hoy',
                        ),
                      ),
                    );
                  },
                ),
                hour >= 15
                    ? _createDrawerItem(
                        context,
                        icon: Icons.filter_drama,
                        text: 'Mañana',
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForecastPage(
                                forecastType: 'tomorrow',
                                pageTitle: 'Pronóstico para mañana',
                              ),
                            ),
                          );
                        },
                      )
                    : Container(),
              ],
            ),
            ExpansionTile(
              title: Text('Tiempo actual'),
              children: <Widget>[
                _createDrawerItem(
                  context,
                  icon: Icons.gradient,
                  text: 'Perspectivas',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForecastPage(
                          forecastType: 'perspectives',
                          pageTitle: 'Perspectivas del Tiempo',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            _createDrawerItem(
              context,
              icon: Icons.location_on,
              text: 'Municipios',
              onTap: () {
                Navigator.of(context).pop();
                getMunicipality(context).then(
                  (municipality) {
                    if (municipality != null) {
                      BlocProvider.of<WeatherBloc>(context).add(FetchWeather(
                        municipality: municipality.toString(),
                      ));
                    }
                  },
                );
              },
            ),
            _createDrawerItem(
              context,
              icon: Icons.info,
              text: 'Información',
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InformationWidget(),
                  ),
                );
              },
            ),
            _createDrawerItem(
              context,
              icon: FontAwesomeIcons.donate,
              text: 'Donar',
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonateWidget(),
                  ),
                );
              },
            ),
            _createDrawerItem(
              context,
              icon: Icons.share,
              text: 'Compartir',
              onTap: () async {
                Share.share(
                  'Yo uso Cuba Weather: la app meteorológica de '
                  'Cuba para Cuba. https://cubaweather.app',
                  subject: 'Cuba Weather App',
                );
              },
            ),
            ExpansionTile(
              title: Text('Redes Sociales'),
              children: <Widget>[
                _createDrawerItem(
                  context,
                  icon: FontAwesomeIcons.chrome,
                  text: 'Web',
                  onTap: () async {
                    const url = 'https:cubaweather.app';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      log('Could not launch $url');
                    }
                  },
                ),
                _createDrawerItem(
                  context,
                  icon: FontAwesomeIcons.facebook,
                  text: 'Facebook',
                  onTap: () async {
                    var fbProtocolUrl = 'fb://page/113097883578567';
                    var fallbackUrl = "https://www.facebook.com/cubaweatherapp";
                    try {
                      await launch(fbProtocolUrl, forceSafariVC: false);
                    } catch (e) {
                      if (await canLaunch(fallbackUrl)) {
                        await launch(fallbackUrl);
                      } else {
                        log('Could not launch $fallbackUrl');
                      }
                    }
                  },
                ),
                _createDrawerItem(
                  context,
                  icon: FontAwesomeIcons.twitter,
                  text: 'Twitter',
                  onTap: () async {
                    const url = 'https://twitter.com/cubaweatherapp';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      log('Could not launch $url');
                    }
                  },
                ),
                _createDrawerItem(
                  context,
                  icon: FontAwesomeIcons.telegram,
                  text: 'Telegram',
                  onTap: () async {
                    const url = 'https://t.me/cubaweather';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      log('Could not launch $url');
                    }
                  },
                ),
              ],
            ),
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
        backgroundColor: Colors.blue[700],
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
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final municipality = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MunicipalitySelectionWidget(
                    municipalities: this.municipalities,
                  ),
                ),
              );
              if (municipality != null) {
                BlocProvider.of<WeatherBloc>(context).add(FetchWeather(
                  municipality: municipality,
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
                        'Por favor, seleccione un municipio presionando '
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
                    displacement: 80,
                    onRefresh: () {
                      BlocProvider.of<WeatherBloc>(context).add(
                        RefreshWeather(municipality: weather.cityName),
                      );
                      return _refreshCompleter.future;
                    },
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: NameMunicipalityWidget(
                              municipalities: municipalities,
                              municipality: weather.cityName),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(),
                          child: CombinedWeatherWidget(
                            weather: weather,
                          ),
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

  Widget _createDrawerItem(
    BuildContext context, {
    IconData icon,
    String text,
    GestureTapCallback onTap,
  }) {
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
      onTap: onTap,
    );
  }

  Future getMunicipality(BuildContext context) async {
    final municipality = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MunicipalityList(
          municipalities: this.municipalities,
        ),
      ),
    );
    return municipality;
  }
}
