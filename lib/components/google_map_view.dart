import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static LatLng _latLng = const LatLng(20.2418354, 85.7658413);
  late final CameraPosition _cameraPosition;

  // final List<Marker> _markers = [];
  // final List<Marker> _list = [
  //   Marker(
  //     markerId: const MarkerId('1'),
  //     position: _latLng,
  //     draggable: true,
  //     onDragEnd: (value) {
  //       _latLng = value;
  //     },
  //     infoWindow: const InfoWindow(title: 'Patrapada'),
  //   ),
  //   const Marker(
  //     markerId: MarkerId('2'),
  //     position: LatLng(20.256948, 85.757094),
  //     infoWindow: InfoWindow(title: 'Subudhipur'),
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
    _cameraPosition = CameraPosition(target: _latLng, zoom: 14.0);
    // _markers.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _cameraPosition,
      onMapCreated: (controller) => _onMapCreated(controller),
      mapType: MapType.normal,
      // markers: Set<Marker>.of(_markers),
      markers: <Marker>{
        Marker(
          markerId: const MarkerId('1'),
          position: _latLng,
          draggable: true,
          onDragEnd: (value) {
            setState(() {
              _latLng = value;
            });
          },
          infoWindow: const InfoWindow(title: 'Patrapada'),
        ),
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) =>
      _controller.complete(controller);
}
