import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  static const LatLng cairoCoordinates = LatLng(30.0444, 31.2357);

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('cairo_marker'),
      position: cairoCoordinates,
      infoWindow: InfoWindow(title: 'Cairo Government'),
    ),
  };

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: cairoCoordinates,
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        markers: _markers,
      ),
    );
  }
}
