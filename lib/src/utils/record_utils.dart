import 'package:preferences/preferences.dart';
import 'constants.dart';

void updateRecords(String municipality) async {
  List<String> actual = PrefService.getStringList(Constants.municipalityRecord)??List<String>();
  actual.remove(municipality);
  actual.insert(0, municipality);
  if(actual.length > Constants.municipalityRecordSize) {
    actual.removeLast();
  }
  PrefService.setStringList(Constants.municipalityRecord, actual);
}
