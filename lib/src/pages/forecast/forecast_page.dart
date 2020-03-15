import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

import 'package:cuba_weather/src/pages/forecast/blocs/blocs.dart';
import 'package:cuba_weather/src/utils/utils.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

class ForecastPage extends StatefulWidget {
  final String forecastType;
  final String pageTitle;

  ForecastPage({
    Key key,
    @required this.forecastType,
    @required this.pageTitle,
  })  : assert(forecastType != null),
        super(key: key);

  @override
  ForecastPageState createState() => ForecastPageState();
}

class ForecastPageState extends State<ForecastPage>
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
        create: (context) => ForecastBloc(api: CubaWeather()),
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            elevation: 0,
            title: Text(widget.pageTitle),
            centerTitle: true,
          ),
          body: FadeTransition(
            opacity: fadeAnimation,
            child: BlocBuilder<ForecastBloc, ForecastState>(
              builder: (context, state) {
                if (state is ForecastInitial) {
                  fadeController.reset();
                  fadeController.forward();
                  BlocProvider.of<ForecastBloc>(context).add(FetchForecast(
                    widget.forecastType,
                  ));
                }
                if (state is ForecastLoading) {
                  if (state.showAnimation) {
                    fadeController.reset();
                    fadeController.forward();
                  }
                  return Center(child: CircularProgressIndicator());
                }
                if (state is ForecastError) {
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
                if (state is ForecastLoaded) {
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
                                  Divider(),
                                  state.forecast.forecastTitle != ""
                                      ? SizedBox(height: 5.0)
                                      : Container(),
                                  state.forecast.forecastTitle != ""
                                      ? Text(
                                          state.forecast.forecastTitle,
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Container(),
                                  state.forecast.forecastTitle != ""
                                      ? SizedBox(height: 8.0)
                                      : Container(),
                                  Text(
                                    state.forecast.forecastText,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                    children: buildAuthors(state.forecast),
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
                          state.forecast.imageUrl != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('Mostrar imagen',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                    Switch(
                                      value: state.showImage,
                                      onChanged: (value) {
                                        BlocProvider.of<ForecastBloc>(context)
                                            .add(
                                          SetShowImageForecast(
                                            forecast: state.forecast,
                                            showImage: value,
                                          ),
                                        );
                                      },
                                      activeTrackColor: Colors.lightBlueAccent,
                                      activeColor: Colors.white,
                                    ),
                                  ],
                                )
                              : Container(),
                          state.forecast.imageUrl != null
                              ? state.showImage
                                  ? FadeInImage.assetNetwork(
                                      placeholder: Constants.loadingPlaceholder,
                                      image: state.forecast.imageUrl,
                                    )
                                  : Container()
                              : Container()
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

  static List<Widget> buildAuthors(InsmetForecastModel forecast) {
    return forecast.authors[0] != ""
        ? [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  forecast.authors[0] != ""
                      ? CircleAvatar(
                          backgroundImage:
                              meteorologistImg(forecast.authors[0]) != null
                                  ? NetworkImage(
                                      meteorologistImg(forecast.authors[0]))
                                  : ExactAssetImage(Constants
                                      .authorsPlaceHolderImageAssetURL),
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
                    backgroundImage: meteorologistImg(forecast.authors[1]) !=
                            null
                        ? NetworkImage(meteorologistImg(forecast.authors[1]))
                        : ExactAssetImage(
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
                    backgroundImage: meteorologistImg(forecast.authors[1]) !=
                            null
                        ? NetworkImage(meteorologistImg(forecast.authors[1]))
                        : ExactAssetImage(
                            Constants.authorsPlaceHolderImageAssetURL),
                    radius: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      forecast.authors[1],
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

  static String meteorologistImg(String name) {
    name = name.replaceAll(' ', '');
    name = name.replaceAll('.', '');
    String url = Constants.insmetUrlAuthorsImg;
    switch (name) {
      case 'AVarela':
        return url + 'A.Varela.jpg';
        break;
      case 'YBermúdez':
        return url + 'Yinelis.jpg';
        break;
      case 'MAHernández':
        return url + 'MAHernandez.jpg';
        break;
      case 'MAHernandez':
        return url + 'MAHernandez.jpg';
        break;
      case 'AJustiz':
        return url + 'A.Justiz.jpg';
        break;
      case 'YArias':
        return url + 'Y.Arias.jpg';
        break;
      case 'JRubiera':
        return url + 'JRubiera.jpg';
        break;
      case 'GAcosta':
        return url + 'G.Acosta.jpg';
        break;
      case 'ACaymares':
        return url + 'ACaymares.jpg';
        break;
      case 'ASanchez':
        return url + 'ASanchez.jpg';
        break;
      case 'ALima':
        return url + 'ALima.jpg';
        break;
      case 'JASerrano':
        return url + 'JASerrano.jpg';
        break;
      case 'GAguilar':
        return url + 'GAguilar.jpg';
        break;
      case 'NFournier':
        return url + 'NFournier.jpg';
        break;
      case 'JGonzález':
        return url + 'JGonzález.jpg';
        break;
      case 'Amengana':
        return url + 'Amengana.jpg';
        break;
      case 'Miri':
        return url + 'Miri.jpg';
        break;
      case 'Yinelis':
        return url + 'Yinelis.jpg';
        break;
      case 'GEstevez':
        return url + 'GEstevez.jpg';
        break;
      case 'YCedeno':
        return url + 'YCedeno.jpg';
        break;
      case 'JPalacios':
        return url + 'JPalacios.jpg';
        break;
      case 'AEspinosa':
        return url + 'A.Espinosa.jpg';
        break;
      case 'YMartinez':
        return url + 'Y.Martinez.jpg';
        break;
      case 'EVázquez':
        return url + 'E. Vázquez.JPG';
        break;
      case 'AOtero':
        return url + 'A.Otero.jpg';
        break;
      case 'AMiro':
        return url + 'A.Miro.jpg';
        break;
      case 'AWong':
        return url + 'A.Wong.jpg';
        break;
      default:
        return null;
    }
  }
}
