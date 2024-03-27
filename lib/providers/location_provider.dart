import 'package:flutter/foundation.dart';
import 'package:google_map_01/models/location_model.dart';

class LocationProvider extends ChangeNotifier {
  LatLongModel? _latLong;
  LatLongModel? get latLong => _latLong;

  void setLatLong(LatLongModel value) {
    _latLong = value;
    notifyListeners();
  }
}
