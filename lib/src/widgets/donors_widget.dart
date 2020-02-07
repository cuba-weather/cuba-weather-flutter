import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cuba_weather/src/models/models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListPage();
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List donors;

  @override
  void initState() {
    donors = getDonors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget makeTrailing(Donor donor) {
      return donor.url != null
          ? Icon(
              getSocialIcon(donor.url),
              color: Colors.white,
            )
          : Container();
    }

    ListTile makeListTile(Donor donor) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Icon(
            FontAwesomeIcons.donate,
            color: Colors.yellow,
            size: 40,
          ),
          title: Text(
            donor.name,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(
            "\$" + donor.value.toString() + " CUC",
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          trailing: makeTrailing(donor),
          onTap: () async {
            if (await canLaunch(donor.url)) {
              await launch(donor.url);
            } else {
              log('Could not launch ${donor.url}');
            }
          },
        );

    Card makeCard(Donor donor) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.lightBlue),
            child: makeListTile(donor),
          ),
        );

    final makeBody = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text('Donantes',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.left),
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: donors.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(donors[index]);
          },
        ),
        Padding(padding: EdgeInsets.only(bottom: 30))
      ],
    );

    return makeBody;
  }
}

List getDonors() {
  return [
    Donor(
        name: "BacheCubano",
        value: 10.00,
        url: 'https://twitter.com/BacheCubano'),
    Donor(
        name: "DatosCuba", value: 10.00, url: 'https://twitter.com/DatosCuba'),
    Donor(
        name: "Publicitaria",
        value: 4.00,
        url: 'https://twitter.com/cmolinaf96'),
    Donor(name: "Daxslab", value: 20.00, url: 'https://twitter.com/daxslab'),
    Donor(
        name: "Tecnolike+",
        value: 10.00,
        url: 'https://twitter.com/tecnolikeplus'),
    Donor(name: "Anónimo", value: 1.00, url: ''),
    Donor(
        name: "Proyecto Numerazo", value: 2.00, url: 'https://t.me/Akyra0212'),
    Donor(
        name: "Móvil JA Cuba",
        value: 5.00,
        url: 'https://twitter.com/moviljacuba'),
    Donor(
        name: "St. Pauli Bar",
        value: 40.00,
        url: 'https://www.facebook.com/Stpaulirestaurantstgo'),
  ];
}

IconData getSocialIcon(String url) {
  if (url == null) {
    return null;
  }
  if (url.contains('https://www.facebook.com')) {
    return FontAwesomeIcons.facebook;
  } else if (url.contains('https://twitter.com')) {
    return FontAwesomeIcons.twitter;
  } else if (url.contains('https://t.me')) {
    return FontAwesomeIcons.telegram;
  } else if (url.contains('https://github.com')) {
    return FontAwesomeIcons.github;
  } else if (url.contains('https://www.linkedin.com')) {
    return FontAwesomeIcons.linkedin;
  } else if (url.contains('https://www.youtube.com')) {
    return FontAwesomeIcons.youtube;
  } else if (url.contains('https://www.instagram.com')) {
    return FontAwesomeIcons.instagram;
  } else {
    return null;
  }
}
