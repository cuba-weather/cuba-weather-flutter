import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cuba_weather/src/models/models.dart';

class DonorWidget extends StatelessWidget {
  const DonorWidget();

  @override
  Widget build(BuildContext context) {
    return ListPage();
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
          ? Icon(getSocialIcon(donor.url), color: Colors.blue)
          : Container();
    }

    ListTile makeListTile(Donor donor) => ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          title: Text(
            donor.name,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            donor.value,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
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
          margin: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 6.0,
          ),
          child: Container(
            child: makeListTile(donor),
          ),
        );

    final makeBody = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(bottom: 10)),
        Column(
          children: donors.map((item) {
            return makeCard(item);
          }).toList(),
        ),
        Padding(padding: EdgeInsets.only(bottom: 10)),
      ],
    );

    return makeBody;
  }
}

List getDonors() {
  return [
    Donor(
      name: "BacheCubano",
      value: '250.00 CUP',
      url: 'https://www.bachecubano.com',
    ),
    Donor(
      name: "DatosCuba",
      value: '10.00 CUC (Saldo)',
      url: 'https://play.google.com/store/apps/details?id=com.cjamcu.datoscuba',
    ),
    Donor(
      name: "Publicitaria",
      value: '100.00 CUP',
      url: 'https://twitter.com/cmolinaf96',
    ),
    Donor(
      name: "Daxslab",
      value: '20.00 CUC',
      url: 'https://www.daxslab.com',
    ),
    Donor(
      name: "Tecnolike+",
      value: '125.00 CUP',
      url: 'https://tecnolikecuba.com',
    ),
    Donor(
      name: "Anónimo",
      value: '25.00 CUP',
      url: '',
    ),
    Donor(
      name: "Proyecto Numerazo",
      value: '2.00 CUC (Saldo)',
      url: 'https://t.me/Akyra0212',
    ),
    Donor(
      name: "Móvil JA Cuba",
      value: '125.00 CUP',
      url: 'https://moviljacuba.wordpress.com',
    ),
    Donor(
      name: "St. Pauli Bar",
      value: '960.00 CUP',
      url: 'https://www.facebook.com/Stpaulirestaurantstgo',
    ),
    Donor(
      name: "Tecnolike+",
      value: '125.00 CUP',
      url: 'https://tecnolikecuba.com',
    ),
    Donor(
      name: "Anónimo",
      value: '75.00 CUP',
      url: '',
    ),
    Donor(
      name: "Juventud Técnica",
      value: '125.00 CUP',
      url: 'https://medium.com/juventud-t%C3%A9cnica',
    ),
  ];
}

IconData getSocialIcon(String url) {
  if (url == null || url.isEmpty) {
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
  } else if (url.contains('https://medium.com')) {
    return FontAwesomeIcons.medium;
  } else if (url.contains('https://play.google.com')) {
    return FontAwesomeIcons.android;
  } else {
    return FontAwesomeIcons.chrome;
  }
}
