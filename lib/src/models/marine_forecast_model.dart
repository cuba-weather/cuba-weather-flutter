class MarineForecastModel {
  String centerName;
  String forecastName;
  String forecastDate;
  String validSince;
  String validUntil;
  String significantSituation;
  List<String> authors = new List<String>();
  String dataSource;
  String areaGulfOfMexico;
  String areaRest;

  MarineForecastModel({
    this.centerName,
    this.forecastName,
    this.forecastDate,
    this.significantSituation,
    this.authors,
    this.dataSource,
    this.areaGulfOfMexico,
    this.areaRest,
    this.validSince,
    this.validUntil,
  });
}
