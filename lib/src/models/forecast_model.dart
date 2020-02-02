class ForecastModel {
  String pageTitle;
  String centerName;
  String forecastName;
  String forecastDate;
  String forecastTitle;
  String forecastText;
  List<String> authors = new List<String>();
  String dataSource;

  ForecastModel({
    this.pageTitle,
    this.centerName,
    this.forecastName,
    this.forecastDate,
    this.forecastTitle,
    this.forecastText,
    this.authors,
    this.dataSource,
  });
}
