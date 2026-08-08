class WeatherModel {
  final String city;
  final double temperature;
  final double feelsLike;
  final String description;
  final int humidity;
  final double windSpeed;
  final String icon;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.feelsLike,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json["location"]["name"] as String,
      temperature: (json["current"]["temp_c"] as num).toDouble(),
      feelsLike: (json["current"]["feelslike_c"] as num).toDouble(),
      description: json["current"]["condition"]["text"] as String,
      humidity: json["current"]["humidity"] as int,
      windSpeed: (json["current"]["wind_kph"] as num).toDouble(),
      icon: "https:${json["current"]["condition"]["icon"]}",
    );
  }
}