class Constants {
  // Errors
  static final String errorMessage = 'Ha ocurrido un error';
  static final String errorMessageBadRequestException = 'No se ha podido establecer conexión con la red nacional. Por favor, revise su conexión y vuelva a intentarlo.';
  static final String errorMessageParseException = 'La fuente de datos a cambiado el formato. Espere una nueva actualización de la aplicación para adaptarse a este.';

  static final String appName = 'Cuba Weather';
  static final String appLogo = 'images/logo.png';
  static final String appSlogan = 'De CUBA para CUBA';
  static final String appSloganLong = 'Tu app meteorológica de CUBA para CUBA';
  static final String authorsPlaceHolderImageAssetURL = 'images/no-image.png';
  static final String loadingPlaceholder = 'images/loading.gif';
  static final String locale = "es_ES";
  // static final String fontFamily = "Exo2";
  static final String fontFamily = "GoogleSans";

  static final String insmetForecastSource = 'www.insmet.cu';

  // INSMET Urls
  static final String insmetURL = 'http://www.insmet.cu';
  static final String insmetUrlAuthorsImg = 'http://www.insmet.cu/Imagenes/Meteorologos/';
  static final String insmetUrlTodayForecast = 'http://www.insmet.cu/asp/link.asp?PRONOSTICO';
  static final String insmetUrlTomorrowForecast = 'http://www.insmet.cu/asp/genesis.asp?TB0=PLANTILLAS&TB1=PTM&TB2=/Pronostico/Ptm.txt';
  static final String insmetUrlPerspectives = 'http://www.insmet.cu/asp/genesis.asp?TB0=PLANTILLAS&TB1=PERSPECTIVASTT';
  static final String insmetUrlMarineForecast = 'http://www.insmet.cu/asp/genesis.asp?TB0=PLANTILLAS&TB1=MAR&TB2=/Pronostico/Marady.txt';

  // SharedPreferences
  static String carouselWasSeen = 'carouselWasSeen';
  static String municipality = 'municipality';
  static String showImageForecastPage = 'showImageForecastPage';
  static String themeMode = 'themeMode';
}
