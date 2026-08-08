import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';
import '../utils/language.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  Future<WeatherModel> loadWeather() async {
    // Get live location
    Position position = await LocationService().getCurrentLocation();

    print("Latitude : ${position.latitude}");
    print("Longitude: ${position.longitude}");

    // Fetch weather
    return await WeatherService().getWeather(
      position.latitude,
      position.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherModel>(
      future: loadWeather(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        // Error
        if (snapshot.hasError) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              snapshot.error.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          );
        }

        // No Data
        if (!snapshot.hasData) {
          return Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                "No Weather Data",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          );
        }

        final weather = snapshot.data!;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.green.shade700,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isTelugu ? "నేటి వాతావరణం" : "Today's Weather",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Image.network(
                    weather.icon,
                    width: 70,
                    height: 70,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.cloud,
                      size: 70,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Text(
                    "${weather.temperature.toStringAsFixed(1)}°C",
                    style: const TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Text(
                "${weather.description} • ${weather.city}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "💧 Humidity: ${weather.humidity}%",
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    "💨 Wind: ${weather.windSpeed.toStringAsFixed(1)} km/h",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Text(
                "🤗 ${isTelugu ? "అనిపించే ఉష్ణోగ్రత" : "Feels Like"} : ${weather.feelsLike.toStringAsFixed(1)}°C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}