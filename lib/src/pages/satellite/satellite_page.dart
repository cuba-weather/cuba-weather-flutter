import 'dart:math';

import 'package:flutter/material.dart';

import 'package:story_view/story_view.dart';

class SatellitePage extends StatefulWidget {
  final String satelliteType;
  final String pageTitle;

  SatellitePage({
    Key key,
    @required this.satelliteType,
    @required this.pageTitle,
  })  : assert(satelliteType != null),
        super(key: key);

  @override
  _SatellitePageState createState() => _SatellitePageState();
}

class _SatellitePageState extends State<SatellitePage>
    with TickerProviderStateMixin {
  AnimationController fadeController;
  Animation<double> fadeAnimation;
  final storyController = StoryController();

  String url = 'http://www.insmet.cu/SATELITE/TMP/';
  List<int> imgsIndex = List<int>();
  List<String> imgs = [
    '020617.jpg',
    '020647.jpg',
    '020717.jpg',
    '020719.jpg',
    '020747.jpg',
    '020817.jpg',
    '020847.jpg',
    '020917.jpg',
    '020947.jpg',
    '021017.jpg'
  ];
  List<StoryItem> storyItems =  List();
  @override
  void initState() {
    var rng = new Random();
    for (var i = 0; i < 10; i++) {
      imgsIndex.add(rng.nextInt(imgs.length));
    }
    imgsIndex.sort();
    for (var i = 0; i < imgsIndex.length; i++) {
      storyItems.add(StoryItem.pageGif(url + imgs[imgsIndex[i]],
          caption: imgs[imgsIndex[i]],
          controller: storyController,
          duration: Duration(milliseconds: 500)));
    }
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.pageTitle),
        centerTitle: true,
      ),
      body: StoryView(
        storyItems,
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          print("Completed a cycle");
        },
        progressPosition: ProgressPosition.top,
        repeat: true,
        controller: storyController,
      ),
    );
  }
}
