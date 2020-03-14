import 'package:cuba_weather_dart/cuba_weather_dart.dart' as cwd;

class WeatherModel extends cwd.WeatherModel {
  cwd.WeatherForecastModel getTodayForecast() {
    var now = DateTime.now();
    return forecasts.firstWhere((x) => x.day == now.day, orElse: () => forecasts.first);
  }

  List<cwd.WeatherForecastModel> getForecasts() {
    var now = DateTime.now();
    var day = now.day;
    var ascendant = true;
    for (var i = 1; i < forecasts.length; ++i) {
      if (forecasts[i].day < forecasts[i - 1].day) {
        ascendant = false;
      }
    }
    var result = List<cwd.WeatherForecastModel>();
    if (ascendant) {
      result.addAll(forecasts.where((forecast) => forecast.day > day));
    } else {
      var isLeft = true;
      var left = List<cwd.WeatherForecastModel>();
      var right = List<cwd.WeatherForecastModel>();
      left.add(forecasts[0]);
      for (var i = 1; i < forecasts.length; ++i) {
        if (forecasts[i - 1].day > forecasts[i].day) {
          isLeft = false;
        }
        if (isLeft) {
          left.add(forecasts[i]);
        } else {
          right.add(forecasts[i]);
        }
      }
      if (day > right.last.day) {
        result.addAll(left.where((item) => day < item.day));
        result.addAll(right);
      } else {
        result.addAll(right.where((item) => day < item.day));
      }
    }
    return result;
  }

  static WeatherModel getModel(cwd.WeatherModel _weather) {
    var weather = WeatherModel();
    weather.cityName = _weather.cityName;
    weather.temperature = _weather.temperature;
    weather.dateTime = _weather.dateTime;
    weather.pressure = _weather.pressure;
    weather.humidity = _weather.humidity;
    weather.windVelocity = _weather.windVelocity;
    weather.windDirection = _weather.windDirection;
    weather.windDirectionDescription = _weather.windDirectionDescription;
    weather.windDirectionDegree = _weather.windDirectionDegree;
    weather.windDirectionRadians = _weather.windDirectionRadians;
    weather.weatherForecast = _weather.weatherForecast;
    weather.droughtStatus = _weather.droughtStatus;
    weather.forecasts = _weather.forecasts;
    return weather;
  }
}
