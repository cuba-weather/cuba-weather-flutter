import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

import 'package:cuba_weather/src/blocs/blocs.dart';
import 'package:cuba_weather/src/pages/pages.dart';
import 'package:cuba_weather/src/utils/utils.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  Completer<void> refreshCompleter;
  String appName = '';
  String version = '';
  int hour;

  @override
  void initState() {
    super.initState();
    refreshCompleter = Completer<void>();
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
    hour = new DateTime.now().hour;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            createDrawerHeader(context),
            actualMunicipalityDrawerItem(),
            municipalitiesDrawerItem(),
            nationalForecastsDrawerItem(),
            actualWeatherDrawerItem(),
            marineForecastsDrawerItem(),
            donatesDrawerItem(),
            socialNetworksDrawerItem(),
            sharerDrawerItem(),
            settingDrawerItem(),
            informationDrawerItem(),
            reportBugDrawerItem(),
            versionAppDrawerItem(),
          ],
        ),
      ),
      appBar: AppBar(
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
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              var municipality = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MunicipalitySelectionPage(),
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
              refreshCompleter?.complete();
              refreshCompleter = Completer();
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherEmpty) {
                return WeatherEmptyWidget();
              }
              if (state is WeatherInitial) {
                BlocProvider.of<WeatherBloc>(context).add(FetchWeather(
                  municipality: state.municipality,
                ));
              }
              if (state is WeatherFindingLocation) {
                return WeatherFindingLocationWidget();
              }
              if (state is WeatherLoading) {
                return WeatherLoadingWidget();
              }
              if (state is WeatherLoaded) {
                return GradientContainerWidget(
                  child: RefreshIndicator(
                    displacement: 80,
                    onRefresh: () {
                      BlocProvider.of<WeatherBloc>(context).add(
                        RefreshWeather(municipality: state.weather.cityName),
                      );
                      return refreshCompleter.future;
                    },
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: NameMunicipalityWidget(
                            municipality: state.weather.cityName,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(),
                          child: CombinedWeatherWidget(
                            weather: state.weather,
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
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget createDrawerHeader(BuildContext context) {
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
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            );
          },
        ),
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

  Widget createDrawerItem(
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

  Widget actualMunicipalityDrawerItem() {
    return createDrawerItem(
      context,
      icon: Icons.my_location,
      text: 'Municipio actual',
      onTap: () {
        Navigator.of(context).pop();
        BlocProvider.of<WeatherBloc>(context).add(
          FindLocationWeather(),
        );
      },
    );
  }

  Widget municipalitiesDrawerItem() {
    return createDrawerItem(
      context,
      icon: Icons.location_on,
      text: 'Municipios',
      onTap: () async {
        Navigator.of(context).pop();
        var municipality = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MunicipalityListPage(),
          ),
        );
        if (municipality != null) {
          BlocProvider.of<WeatherBloc>(context).add(FetchWeather(
            municipality: municipality.toString(),
          ));
        }
      },
    );
  }

  Widget nationalForecastsDrawerItem() {
    return ExpansionTile(
      title: Text('Pronósticos nacionales'),
      children: <Widget>[
        createDrawerItem(
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
            ? createDrawerItem(
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
    );
  }

  Widget actualWeatherDrawerItem() {
    return ExpansionTile(
      title: Text('Tiempo actual'),
      children: <Widget>[
        createDrawerItem(
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
    );
  }

  Widget marineForecastsDrawerItem() {
    return ExpansionTile(
      title: Text('Pronóstico marino'),
      children: <Widget>[
        createDrawerItem(
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
    );
  }

  Widget donatesDrawerItem() {
    return ExpansionTile(
      title: Text('Donaciones'),
      children: <Widget>[
        createDrawerItem(
          context,
          icon: FontAwesomeIcons.donate,
          text: 'Donar',
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DonatePage(),
              ),
            );
          },
        ),
        createDrawerItem(
          context,
          icon: Icons.card_giftcard,
          text: 'Donantes',
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DonorsPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget socialNetworksDrawerItem() {
    return ExpansionTile(
      title: Text('Redes Sociales'),
      children: <Widget>[
        createDrawerItem(
          context,
          icon: FontAwesomeIcons.facebook,
          text: 'Facebook',
          onTap: () async {
            var fbProtocolUrl = 'fb://page/113097883578567';
            var fallbackUrl = 'https://www.facebook.com/cubaweatherapp';
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
        createDrawerItem(
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
        createDrawerItem(
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
        createDrawerItem(
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
      ],
    );
  }

  Widget sharerDrawerItem() {
    return createDrawerItem(
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
    );
  }

  Widget settingDrawerItem() {
    return createDrawerItem(
      context,
      icon: Icons.settings,
      text: 'Configuración',
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingsPage(),
          ),
        );
      },
    );
  }

  Widget informationDrawerItem() {
    return createDrawerItem(
      context,
      icon: Icons.info,
      text: 'Información',
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InformationPage(),
          ),
        );
      },
    );
  }

  Widget reportBugDrawerItem() {
    return createDrawerItem(
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
    );
  }

  Widget versionAppDrawerItem() {
    return ListTile(
      title: Text(
        'v$version',
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 10),
      ),
      onTap: () {},
    );
  }
}
