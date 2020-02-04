import 'package:cuba_weather/src/models/forecast_model.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart';
import 'package:html/dom.dart';
import 'dart:developer';

class WeatherClient {
  Future<ForecastModel> todayForecast(BaseClient client) async {
    print("todayForecast " + DateTime.now().toString());

    ForecastModel forecast = new ForecastModel();

    forecast.authors = new List<String>();
    try {
      String url = "http://www.insmet.cu/asp/link.asp?PRONOSTICO";

      Response response = await client.get(url);

      if (response.statusCode != 200) {
        throw BadRequestException(response.body);
      }

      var document = parse(response.body);
      List<Element> tabs =
          document.getElementsByTagName('table.contenidoPagina');

      Element autor1Element = document.getElementById('name1');
      if (autor1Element != null) {
        forecast.authors.add(autor1Element.text);
      }

      Element autor2Element = document.getElementById('name2');
      if (autor2Element != null) {
        forecast.authors.add(autor2Element.text);
      }
      String leading = tabs[0].outerHtml.toString();

      var index = leading.indexOf('<b>');
      leading = leading.replaceRange(0, index, '');

      index = leading.indexOf('<br>');
      forecast.centerName = leading.substring(3, index);
      leading = leading.replaceRange(0, index + 4, '');

      index = leading.indexOf('<br>');
      forecast.forecastName = leading.substring(0, index);
      leading = leading.replaceRange(0, index + 4, '');

      index = leading.indexOf('<br>');
      forecast.forecastDate = leading.substring(0, index);
      leading = leading.replaceRange(0, index + 4, '');

      index = leading.indexOf('<i>');
      leading = leading.replaceRange(0, index + 3, '');

      index = leading.indexOf('</i>');
      forecast.forecastTitle = leading.substring(0, index);
      forecast.forecastTitle = forecast.forecastTitle.replaceAll("", "...");
      leading = leading.replaceRange(0, index + 4, '');

      index = leading.indexOf('<br>');
      leading = leading.replaceRange(0, index + 4, '');

      index = leading.indexOf('</p>');
      forecast.forecastText = leading.substring(0, index);
      forecast.forecastText = forecast.forecastText.replaceAll("<br>", "\n");

      forecast.dataSource = 'www.insmet.cu';
      return forecast;
    } catch (e) {
      log(e.toString());
      throw ParseException(e.toString());
    }
  }

  Future<ForecastModel> tomorrowForecast(BaseClient client) async {
    ForecastModel forecast = new ForecastModel();
    forecast.authors = new List<String>();
    try {
      String url =
          'http://www.insmet.cu/asp/genesis.asp?TB0=PLANTILLAS&TB1=PTM&TB2=/Pronostico/Ptm.txt';
      Response response = await client.get(url);

      if (response.statusCode != 200) {
        throw BadRequestException(response.body);
      }

      var document = parse(response.body);
      List<Element> tabs =
          document.getElementsByTagName('table.contenidoPagina');

      Element autor1Element = document.getElementById('name1');
      if (autor1Element != null) {
        forecast.authors.add(autor1Element.text);
      }

      Element autor2Element = document.getElementById('name2');
      if (autor2Element != null) {
        forecast.authors.add(autor2Element.text);
      }
      String leading = tabs[0].outerHtml.toString();

      var index = leading.indexOf('<b>');
      leading = leading.replaceRange(0, index, '');

      index = leading.indexOf('<br>');
      forecast.centerName = leading.substring(3, index);
      leading = leading.replaceRange(0, index + 4, '');

      index = leading.indexOf('<br>');
      forecast.forecastName = leading.substring(0, index);
      leading = leading.replaceRange(0, index + 4, '');

      index = leading.indexOf('<br>');
      forecast.forecastDate = leading.substring(0, index);
      leading = leading.replaceRange(0, index + 4, '');

      index = leading.indexOf('<i>');
      leading = leading.replaceRange(0, index + 3, '');

      index = leading.indexOf('</i>');
      forecast.forecastTitle = leading.substring(0, index);
      forecast.forecastTitle = forecast.forecastTitle.replaceAll("", "...");
      leading = leading.replaceRange(0, index + 4, '');

      index = leading.indexOf('<br>');
      leading = leading.replaceRange(0, index + 4, '');

      index = leading.indexOf('</p>');
      forecast.forecastText = leading.substring(0, index);
      forecast.forecastText = forecast.forecastText.replaceAll("<br>", "\n");

      forecast.dataSource = 'www.insmet.cu';
      return forecast;
    } catch (e) {
      log(e.toString());
      throw ParseException(e.toString());
    }
  }

  Future<ForecastModel> perspectiveForecast(BaseClient client) async {
    ForecastModel forecast = new ForecastModel();
    forecast.authors = new List<String>();
    forecast.forecastTitle = "";
    try {
      String url =
          'http://www.insmet.cu/asp/genesis.asp?TB0=PLANTILLAS&TB1=PERSPECTIVASTT';
      Response response = await client.get(url);

      if (response.statusCode != 200) {
        throw BadRequestException(response.body);
      }

      var document = parse(response.body);

      List<Element> tabs = document.getElementsByTagName('td.contenidoPagina');

      String leading = tabs[3].outerHtml.toString();

      var index = leading.indexOf('<b>');
      leading = leading.replaceRange(0, index + 3, '');

      index = leading.indexOf('<br>');
      forecast.forecastName = leading.substring(0, index);
      leading = leading.replaceRange(0, index + 4, '');

      index = leading.indexOf('<br>');
      forecast.centerName = leading.substring(0, index);
      leading = leading.replaceRange(0, index + 4, '');

      index = leading.indexOf('<br>');
      forecast.forecastDate = leading.substring(0, index);

      String forecastText = tabs[5].innerHtml.toString();

      index = forecastText.indexOf('>');
      forecastText = forecastText.replaceRange(0, index + 1, '');

      index = forecastText.indexOf('</p>');
      forecast.forecastText = forecastText.substring(0, index);
      forecast.forecastText = forecast.forecastText.replaceAll("<br>", "\n");

      List<Element> tableAutors =
          document.getElementsByTagName('table.contenidoPagina');

      List<Element> tableAutors1 = tableAutors[0].getElementsByTagName('td');

      Element autor1Element;
      try {
        autor1Element = tableAutors1[2];
        if (autor1Element != null) {
          forecast.authors.add(autor1Element.text);
        }
      } catch (e) {}
      Element autor2Element;
      try {
        autor2Element = tableAutors1[3];
        if (autor2Element != null) {
          forecast.authors.add(autor2Element.text);
        }
      } catch (e) {}

      forecast.dataSource = 'www.insmet.cu';
      return forecast;
    } catch (e) {
      log(e.toString());
      throw ParseException(e.toString());
    }
  }

  String imgMeteorologo(String name) {
    name = name.replaceAll(' ', '');
    name = name.replaceAll('.', '');
    String url = "http://www.insmet.cu/Imagenes/Meteorologos/";
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
      default:
        return url + 'unknown.jpg';
    }
  }
}

class BadRequestException implements Exception {
  final String message;

  BadRequestException(this.message);
}

class InvalidSourceException implements Exception {
  final String message;

  InvalidSourceException(this.message);
}

class ParseException implements Exception {
  final String message;

  ParseException(this.message);
}
