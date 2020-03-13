import 'package:flutter/material.dart';

import 'package:cuba_weather/src/pages/pages.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  ResponsiveScreen size;
  List<Widget> pages;

  OnBoardingPageState() {
    pages = [
      IntroPage(
        image: 'images/image5.png',
        title: 'Cuba Weather',
        text: 'Es un proyecto pionero en Cuba de código abierto, '
            'multiplataforma y sin ánimo de lucro.',
      ),
      IntroPage(
        image: 'images/image3.png',
        title: 'Los objetivos son',
        text: 'Brindar a los residentes en Cuba una manera cómoda de acceder '
            'a información meteorológica utilizando solo navegación nacional.',
      ),
      IntroPage(
        image: 'images/image1.png',
        title: 'Mostramos información',
        text: 'De las principales variables meteorológicas como la temperatura'
            ', la presión atmosférica, la humedad, etc.',
      ),
      IntroPage(
        image: 'images/image4.png',
        title: 'Pronósticos oficiales',
        text: 'Para los próximos días, perpéctivas del tiempo, estado de los '
            'mares, etc obtenidos del Instituto de Meteorología de Cuba.',
        isLast: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    size = ResponsiveScreen(MediaQuery.of(context).size);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
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
      child: DotsIndicatorWidget(
        controller: controller,
        itemCount: pages.length,
        color: Colors.white,
        onPageSelected: (int page) {
          controller.animateToPage(
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
        controller: controller,
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          return pages[index % pages.length];
        },
      ),
    );
  }
}
