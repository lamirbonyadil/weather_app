import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:weather_app/service/weather_service.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/weather_card.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final _cityController = TextEditingController();
  final _weatherService = WeatherService();

  bool? _isConnected;
  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Perform the connectivity check on startup
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      setState(() {
        _isConnected = true;
      });
    } else {
      setState(() {
        _isConnected = false;
      });
    }
  }

  Future<void> _fetchWeather() async {
    if (_cityController.text.isEmpty) {
      // Clear previous results if the search is empty
      setState(() {
        _weather = null;
        _errorMessage = "Please enter a city name";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Fetch weather from the service
      final weatherData = await _weatherService.fetchWeather(_cityController.text);

      setState(() {
        _weather = weatherData;
        _isLoading = false;
      });

    } catch (e) {

      setState(() {
        _errorMessage = "Could not find weather for this city.";
        _weather = null;
        _isLoading = false;
      });

    }
  }

  // A widget to decide what to display based on the current state
  Widget _buildWeatherDisplay() {
    // Loading State
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(32.0),
        child: CircularProgressIndicator(color: Colors.white),
      );
    }
    // Error State
    if (_errorMessage != null && _weather == null) {
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(_errorMessage!, style: const TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center),
      );
    }
    // Fetched Weather
    if (_weather != null) {
      return WeatherCard(weather: _weather!);
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnected == null) {
      // loading screen While checking
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2090F1), Color(0xFF37B7FE)],
              )
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.white),
                SizedBox(height: 20),
                Text('Checking Connectivity...', style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),
        ),
      );
    } else if (_isConnected == false) {
      // If not connected => "No Internet" screen with a retry button
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2090F1), Color(0xFF37B7FE)],
              )
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, color: Colors.white, size: 80),
                const SizedBox(height: 20),
                const Text('No Internet Connection', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _checkConnectivity, // The button calls the check again
                  child: const Text('Retry'),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      // If connected => Home Page
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Weather",
            style: TextStyle(
              fontFamily: "RobotoFlex",
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 50),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2090F1),
                  Color(0xFF37B7FE)
                ],
              )
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 25),
                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF4F7A96)),
                        hintText: "Search for a city",
                        fillColor: const Color(0xFFE8EDF2),
                        filled: true,
                        hintStyle: const TextStyle(color: Color(0xFF4F7A96), fontFamily: 'RobotoFlex', fontSize: 16),
                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                // Button
                ElevatedButton.icon(
                  onPressed: _fetchWeather,
                  icon: Icon(
                      Icons.location_on
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Color from image
                    foregroundColor: Colors.white,
                    iconSize: 22,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  label: const Text(
                    'Find Weather', // Text from image
                    style: TextStyle(fontSize: 20, fontFamily: 'RobotoFlex', fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                _buildWeatherDisplay(),
              ],
            ),
          ),
        ),
      );
    }
  }
}