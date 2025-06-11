import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/weather_model.dart';

class WeatherService {
  final String _baseUrl = 'http://api.weatherapi.com/v1';
  final String? _apiKey = dotenv.env['API_KEY'];

  Future<Weather> fetchWeather(String cityName) async {
    if (_apiKey == null) {
      throw Exception('API Key not found in .env file');
    }

    final url = Uri.parse('$_baseUrl/forecast.json?key=$_apiKey&q=$cityName&aqi=no&alerts=no');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}