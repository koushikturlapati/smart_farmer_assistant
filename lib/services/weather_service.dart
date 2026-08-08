import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherService {
  // Replace with your VALID WeatherAPI key
  static const String apiKey = "d220bd55e5e74430bbc183105260408";

  Future<WeatherModel> getWeather(
      double latitude,
      double longitude,
      ) async {
    try {
      final url = Uri.parse(
        "https://api.weatherapi.com/v1/current.json"
            "?key=$apiKey"
            "&q=$latitude,$longitude"
            "&aqi=no",
      );

      print("Weather URL: $url");

      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return WeatherModel.fromJson(json);
      } else {
        throw Exception(
          "HTTP ${response.statusCode}\n${response.body}",
        );
      }
    } catch (e) {
      print("Weather Error: $e");
      rethrow;
    }
  }
}