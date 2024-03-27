import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  Future<String?> getPlacemarks(
      {required double latitude, required double longitude}) async {
    String? address;
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        address = ', $address ${placemarks.first.street ?? ''}';
        address = ', $address ${placemarks.first.subLocality ?? ''}';
        address = ', $address ${placemarks.first.locality ?? ''}';
        address = ', $address ${placemarks.first.subAdministrativeArea ?? ''}';
        address = ', $address ${placemarks.first.administrativeArea ?? ''}';
        address = ', $address ${placemarks.first.postalCode ?? ''}';
        address = ', $address ${placemarks.first.country ?? ''}';
      }
      return address;
    } catch (e) {
      debugPrint('Location Error: $e');
      return 'No address';
    }
  }
}
