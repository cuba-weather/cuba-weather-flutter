import 'dart:developer';
import 'dart:io';

import 'package:cuba_weather/src/models/models.dart';
import 'package:cuba_weather/src/utils/constants.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart' show parse;

class WeatherClient {
  Future<ForecastModel> todayForecast(BaseClient client) async {
    print("todayForecast " + DateTime.now().toString());

    var forecast = new ForecastModel();

    forecast.authors = new List<String>();
    try {
      var url = Constants.insmetUrlTodayForecst;

      var response = await client.get(url);

      if (response.statusCode != 200) {
        throw BadRequestException(response.body);
      }

      var document = parse(response.body);
      var tabs = document.getElementsByTagName('table.contenidoPagina');

      var author1Element = document.getElementById('name1');
      if (author1Element != null) {
        forecast.authors.add(author1Element.text);
      }

      var author2Element = document.getElementById('name2');
      if (author2Element != null) {
        forecast.authors.add(author2Element.text);
      }
      var leading = tabs[0].outerHtml.toString();

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

      forecast.dataSource = Constants.insmetForecastSource;
      return forecast;
    } on SocketException catch (e) {
      log(e.toString());
      throw BadRequestException(e.toString());
    } catch (e) {
      log(e.toString());
      throw ParseException(e.toString());
    }
  }

  Future<ForecastModel> tomorrowForecast(BaseClient client) async {
    var forecast = new ForecastModel();
    forecast.authors = new List<String>();
    try {
      var url = Constants.insmetUrlTomorrowForecst;
      var response = await client.get(url);

      if (response.statusCode != 200) {
        throw BadRequestException(response.body);
      }

      var document = parse(response.body);
      var tabs = document.getElementsByTagName('table.contenidoPagina');

      var author1Element = document.getElementById('name1');
      if (author1Element != null) {
        forecast.authors.add(author1Element.text);
      }

      var author2Element = document.getElementById('name2');
      if (author2Element != null) {
        forecast.authors.add(author2Element.text);
      }
      var leading = tabs[0].outerHtml.toString();

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

      forecast.dataSource = Constants.insmetForecastSource;
      return forecast;
    } on SocketException catch (e) {
      log(e.toString());
      throw BadRequestException(e.toString());
    } catch (e) {
      log(e.toString());
      throw ParseException(e.toString());
    }
  }

  Future<ForecastModel> perspectiveForecast(BaseClient client) async {
    var forecast = new ForecastModel();
    forecast.authors = new List<String>();
    forecast.forecastTitle = "";
    try {
      var url = Constants.insmetUrlPerspectives;
      var response = await client.get(url);

      if (response.statusCode != 200) {
        throw BadRequestException(response.body);
      }

      var document = parse(response.body);

      var tabs = document.getElementsByTagName('td.contenidoPagina');

      var leading = tabs[3].outerHtml.toString();

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

      var tableAuthors = document.getElementsByTagName('table.contenidoPagina');

      var tableAuthors1 = tableAuthors[0].getElementsByTagName('td');

      Element author1Element;
      try {
        author1Element = tableAuthors1[2];
        if (author1Element != null) {
          forecast.authors.add(author1Element.text);
        }
      } catch (e) {}
      Element author2Element;
      try {
        author2Element = tableAuthors1[3];
        if (author2Element != null) {
          forecast.authors.add(author2Element.text);
        }
      } catch (e) {}

      forecast.dataSource = Constants.insmetForecastSource;
      var hour = DateTime.now().hour;
      if (hour >= 4 && hour < 12) {
        forecast.imageUrl = 'http://www.insmet.cu/Pronostico/tv06.jpg';
      } else if (hour >= 12 && hour < 16) {
        forecast.imageUrl = 'http://www.insmet.cu/Pronostico/tv12.jpg';
      } else {
        forecast.imageUrl = 'http://www.insmet.cu/Pronostico/tv18.jpg';
      }
      return forecast;
    } on SocketException catch (e) {
      log(e.toString());
      throw BadRequestException(e.toString());
    } catch (e) {
      log(e.toString());
      throw ParseException(e.toString());
    }
  }

  Future<MarineForecastModel> marineForecast(BaseClient client) async {
    var forecast = new MarineForecastModel();
    forecast.authors = new List<String>();
    forecast.centerName =
        "CENTRO DE METEOROLOGÍA MARINA. INSTITUTO DE METEOROLOGÍA (C.I.T.M.A)";
    forecast.forecastName =
        "PRONÓSTICO HIDROMETEOROLÓGICO MARINO PARA LOS MARES ADYACENTES A CUBA";

    try {
      var url = Constants.insmetUrlMarineForecst;
      var response = await client.get(url);

      if (response.statusCode != 200) {
        throw BadRequestException(response.body);
      }

      var document = parse(response.body);

      var tabs = document.getElementsByTagName('table.contenidoPagina');

      var leading = tabs[0].outerHtml.toString();

      var index = leading.indexOf('VÁLIDO DESDE');
      leading = leading.replaceRange(0, index, '');

      index = leading.indexOf('HASTA');
      forecast.validSince = leading.substring(0, index).trim();
      leading = leading.replaceRange(0, index, '');

      index = leading.indexOf('<br>');
      forecast.validUntil = leading.substring(0, index);

      leading = leading.replaceRange(0, index, '');

      index = leading.indexOf('<b>');
      leading = leading.replaceRange(0, index + 3, '');
      index = leading.indexOf('<table>');
      forecast.significantSituation = leading.substring(0, index);
      forecast.significantSituation =
          forecast.significantSituation.replaceAll("<br>", "\n");
      forecast.significantSituation =
          forecast.significantSituation.replaceAll("</b>", "");
      forecast.significantSituation =
          forecast.significantSituation.replaceAll("</td>", "");
      forecast.significantSituation =
          forecast.significantSituation.replaceAll("</tr>", "");
      forecast.significantSituation =
          forecast.significantSituation.replaceAll("</tbody>", "");
      forecast.significantSituation =
          forecast.significantSituation.replaceAll("</table>", "");

      index = leading.indexOf('contenidopagina');
      leading = leading.replaceRange(0, index + 20, '');
      index = leading.indexOf('<table>');
      forecast.areaGulfOfMexico = leading.substring(0, index);
      forecast.areaGulfOfMexico =
          forecast.areaGulfOfMexico.replaceAll("<br>", "\n");
      forecast.areaGulfOfMexico =
          forecast.areaGulfOfMexico.replaceAll("</b>", "");
      forecast.areaGulfOfMexico =
          forecast.areaGulfOfMexico.replaceAll("</td>", "");
      forecast.areaGulfOfMexico =
          forecast.areaGulfOfMexico.replaceAll("</tr>", "");
      forecast.areaGulfOfMexico =
          forecast.areaGulfOfMexico.replaceAll("</tbody>", "");
      forecast.areaGulfOfMexico =
          forecast.areaGulfOfMexico.replaceAll("</table>", "");
      forecast.areaGulfOfMexico =
          forecast.areaGulfOfMexico.replaceAll("GOLFO DE MÉXICO:", "");

      leading = leading.replaceRange(0, index, '');
      index = leading.indexOf('contenidopagina');
      leading = leading.replaceRange(0, index + 20, '');
      index = leading.indexOf('Pronosticador: ');
      forecast.areaRest = leading.substring(0, index);
      forecast.areaRest = forecast.areaRest.replaceAll("<br>", "\n");
      forecast.areaRest = forecast.areaRest.replaceAll("</b>", "");
      forecast.areaRest = forecast.areaRest.replaceAll("</td>", "");
      forecast.areaRest = forecast.areaRest.replaceAll("</tr>", "");
      forecast.areaRest = forecast.areaRest.replaceAll("</tbody>", "");
      forecast.areaRest = forecast.areaRest.replaceAll("</table>", "");
      forecast.areaRest = forecast.areaRest.replaceAll("PUERTO RICO Y LA FLORIDA HASTA LAS BERMUDAS:", "");

      leading = leading.replaceRange(0, index + 15, '');
      leading = leading.replaceAll("<br>", "");
      leading = leading.replaceAll("</b>", "");
      leading = leading.replaceAll("</td>", "");
      leading = leading.replaceAll("</tr>", "");
      leading = leading.replaceAll("</tbody>", "");
      leading = leading.replaceAll("</table>", "");

      List<String> list = leading.split('/');

      for (var item in list) {
        forecast.authors.add(item.trim());
      }

      forecast.forecastDate = forecast.validSince + " " + forecast.validUntil;
      forecast.dataSource = Constants.insmetForecastSource;
      return forecast;
    } on SocketException catch (e) {
      log(e.toString());
      throw BadRequestException(e.toString());
    } catch (e) {
      log(e.toString());
      throw ParseException(e.toString());
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
