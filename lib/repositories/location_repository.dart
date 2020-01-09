import 'dart:async';

import 'package:cuba_weather/repositories/data_providers/data_providers.dart';

class LocationRepository {
  LocationRepository() {
    locations.sort((a, b) => b.length - a.length);
  }

  Future<String> getLocation(String locationQuery) async {
    var locationQueryLowerCase = locationQuery.toLowerCase();
    for (var location in locations) {
      if (location.toLowerCase().contains(locationQueryLowerCase)) {
        return location;
      }
    }
    throw Exception('$locationQuery not found in the database');
  }
}
