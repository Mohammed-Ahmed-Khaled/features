import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  List<Marker> markers = <Marker>[];
  bool mapLoading = true;
  Position? currentPosition;
  late CameraPosition currentCameraPosition;
  static const CameraPosition cairoPosition = CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 14,
  );

  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    currentPosition = await Geolocator.getCurrentPosition();
    currentCameraPosition = CameraPosition(
      target: LatLng(
        currentPosition?.latitude ?? 0.0,
        currentPosition?.longitude ?? 0.0,
      ),
      zoom: 14,
    );
    mapLoading = false;
    markers.add(
      Marker(
        markerId: const MarkerId('My Location'),
        position: LatLng(
          currentPosition?.latitude ?? 0.0,
          currentPosition?.longitude ?? 0.0,
        ),
        infoWindow: const InfoWindow(title: 'My Location'),
      ),
    );
    setState(() {});
  }

  Future<void> goToTheLocation() async {
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(cairoPosition));
  }

  @override
  void initState() {
    super.initState();
    determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mapLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: currentCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.of(markers),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: goToTheLocation,
        label: const Text('To the Location'),
        icon: const Icon(Icons.directions),
      ),
    );
  }
}
