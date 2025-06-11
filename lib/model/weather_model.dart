class Weather {
  final String cityName;
  final double temperatureCelsius;
  final String condition;
  final int humidity;
  final double windKph;
  final String sunrise;
  final String sunset;

  Weather({
    required this.cityName,
    required this.temperatureCelsius,
    required this.condition,
    required this.humidity,
    required this.windKph,
    required this.sunrise,
    required this.sunset
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json["location"]["name"],
        temperatureCelsius: json["current"]["temp_c"],
        condition: json["current"]["condition"]["text"],
        humidity: json["current"]["humidity"],
        windKph: json["current"]["wind_kph"],
        sunrise: json["forecast"]["forecastday"][0]["astro"]["sunrise"],
        sunset: json["forecast"]["forecastday"][0]["astro"]["sunset"]
    );
  }
}