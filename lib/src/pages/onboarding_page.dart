import 'package:flutter/material.dart';
import 'package:cuba_weather/src/widgets/dots_indicator.dart';
import 'package:cuba_weather/src/pages/pages.dart';
import 'package:cuba_weather/src/widgets/responsive_screen.dart';

class OnBoardingPage extends StatefulWidget {
  final String initialMunicipality;
  final bool darkMode;

  OnBoardingPage({
    Key key,
    @required this.initialMunicipality,
    @required this.darkMode,
  }) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState(
        initialMunicipality: initialMunicipality,
        darkMode: darkMode,
      );
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _controller = PageController();
  final String initialMunicipality;
  final bool darkMode;
  ResponsiveScreen size;
  int currentPageIndex = 0;
  List<Widget> _pages;

  _OnBoardingPageState({
    @required this.initialMunicipality,
    @required this.darkMode,
  }) {
    _pages = [
      IntroPage(
          "images/image5.png",
          "Cuba Weather",
          "Es un proyecto pionero en Cuba de código abierto, multiplataforma y "
              "sin ánimo de lucro.",
          initialMunicipality,
          false,
          darkMode),
      IntroPage(
          "images/image3.png",
          "Los objetivos son",
          "Brindar a los residentes en Cuba una manera cómoda de acceder a "
              "información meteorológica utilizando solo navegación nacional.",
          initialMunicipality,
          false,
          darkMode),
      IntroPage(
          "images/image1.png",
          "Mostramos información",
          "De las principales variables meteorológicas como la temperatura"
              ", la presión atmosférica, la humedad, etc.",
          initialMunicipality,
          false,
          darkMode),
      IntroPage(
          "images/image4.png",
          "Pronósticos oficiales",
          "Para los próximos días, perpéctivas del tiempo, estado de los mares, "
              "etc obtenidos del Instituto de Meteorología de Cuba.",
          initialMunicipality,
          true,
          darkMode),
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = ResponsiveScreen(MediaQuery.of(context).size);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Stack(
            children: <Widget>[
              pageViewFillWidget(),
              bottomDotsWidget(),
            ],
          ),
        ));
  }

  Positioned bottomDotsWidget() {
    return Positioned(
      bottom: size.getWidthPx(20),
      left: 0,
      right: 0,
      child: DotsIndicator(
        controller: _controller,
        itemCount: _pages.length,
        color: Colors.white,
        onPageSelected: (int page) {
          _controller.animateToPage(
            page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
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
        });
      },
    ));
  }
}
