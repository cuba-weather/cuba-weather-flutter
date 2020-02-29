import 'dart:developer';

import 'package:cuba_weather/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:cuba_weather/src/utils/constants.dart';
import 'package:cuba_weather/src/widgets/dots_indicator.dart';
import 'package:cuba_weather/src/pages/intro_page.dart';
import 'package:cuba_weather/src/widgets/responsive_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  final String initialMunicipality;
  OnBoardingPage({
    Key key,
    @required this.initialMunicipality,
  }) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _controller = PageController();
  bool leadingVisibility = false;
  ResponsiveScreen size;

  final List<Widget> _pages = [
    IntroPage("images/logo.png", "",
        "Cuba Weather es un proyecto pionero en Cuba de código abierto, multiplataforma y sin ánimo de lucro, cuyo objetivo es brindar a los residentes en Cuba una manera cómoda de acceder a información meteorológica obtenida de fuentes nacionales utilizando solo navegación nacional (por ejemplo, el bono de 300 megabytes nacionales de los paquetes de datos)."),
    IntroPage("images/logo.png", "Estado actual",
        "Visualización de los valores actuales las principales variables meteorológicas."),
    IntroPage("images/logo.png", "Pronósticos",
        "Pronósticos extendidos para los próximos 5 días"),
    IntroPage("images/logo.png", "Alertas",
        "Proximamente...\n\nAvisos Especiales y Notas Informativas."),
    IntroPage("images/logo.png", "Noticias",
        "Proximamente...\n\nNoticias del acontecer meteorológico en Cuba y el resto mundo."),
  ];
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = ResponsiveScreen(MediaQuery.of(context).size);
    bool isLastPage = currentPageIndex == _pages.length - 1;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Stack(
            children: <Widget>[
              pageViewFillWidget(),
              appBarWithButton(isLastPage, context),
              bottomDotsWidget()
            ],
          ),
        ));
  }

  Positioned bottomDotsWidget() {
    return Positioned(
        bottom: size.getWidthPx(20),
        left: 0.0,
        right: 0.0,
        child: DotsIndicator(
          controller: _controller,
          itemCount: _pages.length,
          color: Constants.clr_gradient_max,
          onPageSelected: (int page) {
            _controller.animateToPage(
              page,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ));
  }

  Positioned appBarWithButton(bool isLastPage, BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: new SafeArea(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          primary: false,
          centerTitle: true,
          leading: Visibility(
              visible: leadingVisibility,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _controller.animateToPage(currentPageIndex - 1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                },
              )),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: size.getWidthPx(16),
                  right: size.getWidthPx(12),
                  bottom: size.getWidthPx(12)),
              child: RaisedButton(
                child: Text(
                  isLastPage ? 'LISTO' : 'SIGUIENTE',
                  style: TextStyle(
                      fontFamily: Constants.fontFamily,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey.shade700),
                ),
                onPressed: isLastPage
                    ? () async {
                        // Last Page Done Click
                        try {
                          var prefs = await SharedPreferences.getInstance();
                          await prefs.setString(Constants.isOnBoard, "1");
                        } catch (e) {
                          log(e.toString());
                        }
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                    initialMunicipality:
                                        widget.initialMunicipality)));
                      }
                    : () {
                        _controller.animateToPage(currentPageIndex + 1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Positioned pageViewFillWidget() {
    return Positioned.fill(
        child: PageView.builder(
      controller: _controller,
      itemCount: _pages.length,
      itemBuilder: (BuildContext context, int index) {
        return _pages[index % _pages.length];
      },
      onPageChanged: (int p) {
        setState(() {
          currentPageIndex = p;
          if (currentPageIndex == 0) {
            leadingVisibility = false;
          } else {
            leadingVisibility = true;
          }
        });
      },
    ));
  }
}
