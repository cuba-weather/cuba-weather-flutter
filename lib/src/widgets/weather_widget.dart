import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';

import 'package:cuba_weather/src/blocs/blocs.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';
import 'package:cuba_weather/src/pages/pages.dart';
import 'package:cuba_weather/src/utils/constants.dart';
import 'package:cuba_weather/src/utils/app_state_notifier.dart';

class WeatherWidget extends StatefulWidget {
  final String initialMunicipality;
  final List<String> municipalities;
  final bool darkMode;

  WeatherWidget({
    Key key,
    @required this.municipalities,
    @required this.initialMunicipality,
    @required this.darkMode,
  })  : assert(municipalities != null),
        super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState(
        municipalities: this.municipalities,
        initialMunicipality: this.initialMunicipality,
        darkMode: this.darkMode,
      );
}

class _WeatherWidgetState extends State<WeatherWidget> {
  SystemUiOverlayStyle _currentStyle = SystemUiOverlayStyle.light;
  String initialMunicipality;
  bool darkMode;
  final List<String> municipalities;
  Completer<void> _refreshCompleter;
  String appName = '';
  String version = '';

  _WeatherWidgetState({
    @required this.municipalities,
    @required this.initialMunicipality,
    @required this.darkMode,
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

  Future<void> setValueDarkMode(bool newValue) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constants.darkMode, newValue);
    this.darkMode = newValue;
  }

  void start() async {
    var packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      version = packageInfo.version;
    });
    try {
      var prefs = await SharedPreferences.getInstance();
      this.initialMunicipality = prefs.getString(Constants.municipality);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (darkMode) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.grey[800],
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.blue[300],
        ),
      );
    }
    var hour = new DateTime.now().hour;
    return AnnotatedRegion(
      value: _currentStyle,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
              ExpansionTile(
                title: Text('Pronóstico marino'),
                children: <Widget>[
                  _createDrawerItem(
                    context,
                    icon: Icons.line_style,
                    text: 'Mares adyacentes',
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MarineForecastPage(
                            forecastType: 'marine',
                            pageTitle: 'Pronóstico marino',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              _createDrawerItem(
                context,
                icon: Icons.my_location,
                text: 'Municipio actual',
                onTap: () {
                  Navigator.of(context).pop();
                  BlocProvider.of<WeatherBloc>(context).add(
                    FindLocationWeather(),
                  );
                },
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
                icon: Icons.card_giftcard,
                text: 'Donantes',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonorsListWidget(),
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
                    'Yo uso $appName: la app meteorológica de '
                    'Cuba para Cuba. https://cubaweather.app',
                    subject: '$appName App',
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
                      var fallbackUrl =
                          "https://www.facebook.com/cubaweatherapp";
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
          backgroundColor: Theme.of(context).appBarTheme.color,
          elevation: 0.0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Constants.appLogo,
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
            Switch(
              value: Provider.of<AppStateNotifier>(context).isDarkModeOn,
              onChanged: (boolVal) {
                Provider.of<AppStateNotifier>(context, listen: false)
                    .updateTheme(boolVal);
                setState(() {
                  if (boolVal) {
                    _currentStyle = SystemUiOverlayStyle.dark.copyWith(
                      systemNavigationBarIconBrightness: Brightness.light,
                      systemNavigationBarColor: Colors.grey[800],
                    );
                  } else {
                    _currentStyle = SystemUiOverlayStyle.light.copyWith(
                      systemNavigationBarIconBrightness: Brightness.dark,
                      systemNavigationBarColor: Colors.blue[300],
                    );
                  }
                  setValueDarkMode(boolVal);
                });
              },
            ),
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
                if (state is WeatherFindingLocation) {
                  return GradientContainerWidget(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Icon(
                                    Icons.my_location,
                                    color: Colors.white,
                                    size: 100,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Text(
                                'Buscando el municipio actual',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }
                if (state is WeatherEmpty) {
                  return GradientContainerWidget(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 50,
                            bottom: 50,
                          ),
                          child: Text(
                            '¡Bienvenido a $appName!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Icon(
                              Icons.my_location,
                              color: Colors.white,
                              size: 100,
                            ),
                          ),
                          onTap: () {
                            BlocProvider.of<WeatherBloc>(context).add(
                              FindLocationWeather(),
                            );
                          },
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: GFButton(
                            text: 'BUSCAR MUNICIPIO ACTUAL',
                            textColor: Colors.white,
                            color: Colors.white,
                            size: GFSize.large,
                            shape: GFButtonShape.pills,
                            type: GFButtonType.outline2x,
                            fullWidthButton: true,
                            onPressed: () {
                              BlocProvider.of<WeatherBloc>(context).add(
                                FindLocationWeather(),
                              );
                            },
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 50,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Nota: Este cálculo se hace con respecto '
                              'al centro del municipio, por lo que si se '
                              'encuentra en la periferia de un municipio '
                              'puede que la aplicación le indique que se '
                              'encuentra en un municipio aledaño al que se '
                              'encuentra realmente.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (state is WeatherLoading) {
                  return GradientContainerWidget(
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
                    child: ListView(
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
                        Card(
                          margin: EdgeInsets.all(20),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              state.errorMessage,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _createHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        appName,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      accountEmail: Text(
        Constants.appSlogan,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundImage: ExactAssetImage(Constants.appLogo),
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
          Icon(
            icon,
            color: Theme.of(context).iconTheme.color,
          ),
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
