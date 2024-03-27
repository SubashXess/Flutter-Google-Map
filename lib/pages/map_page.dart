import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({super.key});

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  late final Completer<GoogleMapController> _controller;
  late final CameraPosition _cameraPosition;
  // final List<Marker> _markers = [
  //   const Marker(
  //     markerId: MarkerId('marker-1'),
  //     position: LatLng(20.242077, 85.765787),
  //     infoWindow: InfoWindow(title: 'Current position'),
  //   ),
  //   const Marker(
  //     markerId: MarkerId('marker-2'),
  //     position: LatLng(20.238438, 85.766927),
  //     infoWindow: InfoWindow(title: 'Down Hill'),
  //   ),
  // ];
  final List<Marker> _marker = [];
  Uint8List? _markerIcon;
  String? _mapTheme;

  @override
  void initState() {
    super.initState();
    mapThemeBuilder();
    _controller = Completer<GoogleMapController>();
    _cameraPosition =
        const CameraPosition(target: LatLng(20.242077, 85.765787), zoom: 16.0);
    // _marker.addAll(_markers);
  }

  void mapThemeBuilder() {
    DefaultAssetBundle.of(context)
        .loadString('assets/map-theme.json')
        .then((value) {
      setState(() {
        _mapTheme = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (controller) {
          controller.setMapStyle(_mapTheme);
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _markerIcon = await getBytesFromAssets('assets/pin.png', 200);
          setState(() {});
          await getCurrentPosition().then((value) async {
            _marker.add(Marker(
                markerId: const MarkerId('marker-1'),
                icon: BitmapDescriptor.fromBytes(_markerIcon!),
                position: LatLng(value.latitude, value.longitude)));
            CameraPosition cameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude), zoom: 18.0);
            GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
            debugPrint([value]
                .toString()); // Latitude: 20.242002, Longitude: 85.7657908
          });
        },
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(Icons.gps_fixed_rounded),
      ),
    );
  }

  Future<Uint8List> getBytesFromAssets(String path, int size) async {
    ByteData byteData = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        byteData.buffer.asUint8List(),
        targetWidth: size);
    ui.FrameInfo frameInfo = await codec.getNextFrame();

    return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Position> getCurrentPosition() async {
    await checkPermission();

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future<void> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Location permission denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('Location permission denied forever');
      return;
    }
  }
}
