import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

class CoordinatePage extends StatefulWidget {
  const CoordinatePage({super.key});

  @override
  State<CoordinatePage> createState() => _CoordinatePageState();
}

class _CoordinatePageState extends State<CoordinatePage> {
  String? _address;
  String? _coordinates;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Address: $_address',
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Coordinates: $_coordinates',
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24.0),
              GestureDetector(
                onTap: () async {
                  await getAddressFromCoordinates(
                      latitude: 20.241806, longitude: 85.765834);
                  await getCoordinatesFromAddress('Bhubaneswar');
                  setState(() {});
                },
                child: Container(
                  width: double.infinity,
                  height: 56.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.deepPurple,
                  ),
                  child: const Text(
                    'Convert',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getAddressFromCoordinates(
      {required double latitude, required double longitude}) async {
    try {
      List<Placemark> placemark =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemark.isNotEmpty) {
        Placemark place = placemark[0];
        _address =
            '${place.administrativeArea}, ${place.country}, ${place.locality}';

        return _address?.trim() ?? '';
      } else {
        return 'No address found for the provided coordinates';
      }
    } on PlatformException catch (e) {
      if (e.code == 'NOT_FOUND') {
        return 'No address found for the provided coordinates';
      } else {
        return 'Error occurred: ${e.message}';
      }
    } catch (e) {
      return 'Error occurred: $e';
    }
  }

  Future<List<Location>> getCoordinatesFromAddress(String address) async {
    List<Location> location = await locationFromAddress(address);
    _coordinates = location.toString();

    return location;
  }
}
