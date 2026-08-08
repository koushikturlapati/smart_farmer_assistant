import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    // Check if GPS is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception("Location services are disabled. Please enable GPS.");
    }

    // Check current permission
    LocationPermission permission = await Geolocator.checkPermission();

    print("Current Permission: $permission");

    // Request permission if denied
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("Permission After Request: $permission");
    }

    if (permission == LocationPermission.denied) {
      throw Exception("Location permission denied.");
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        "Location permission permanently denied. Enable it from phone settings.",
      );
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    // Debug prints
    print("Latitude : ${position.latitude}");
    print("Longitude: ${position.longitude}");

    return position;
  }
}