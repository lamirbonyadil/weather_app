import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';

String _getImageForCondition(String condition) {
  String conditionLower = condition.toLowerCase();

  if (conditionLower.contains('sunny') || conditionLower.contains('clear')) {
    return "images/sun.png";
  } else if (conditionLower.contains('cloudy')) {
    return "images/cloudy.png";
  } else if (conditionLower.contains('rain') || conditionLower.contains('drizzle')) {
    return "images/rain.png";
  } else if (conditionLower.contains('snow') || conditionLower.contains('sleet')) {
    return "images/snow.png";
  } else if (conditionLower.contains('mist') || conditionLower.contains('fog')) {
    return "images/mist.png";
  } else if (conditionLower.contains('thunderstorm') || conditionLower.contains('thunder')) {
    return "images/lightning.png";
  } else {
    return "Null";
  }
}


class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({
    super.key,
    required this.weather
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: const Color(0xFFE8EDF2).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                // Condition icon
                Image.asset(
                  width: 152,
                  height: 152,
                  _getImageForCondition(weather.condition),
                ),
                // City Name
                Text(
                  style: const TextStyle(

                      fontFamily: "RobotoFlex",
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  weather.cityName,
                ),
                // Temp
                Text(
                  style: const TextStyle(
                      fontFamily: "RobotoFlex",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  '${weather.temperatureCelsius.round()}°C',
                ),
                // Condition
                Text(
                  style: const TextStyle(
                      fontFamily: "RobotoFlex",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  weather.condition,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Humidity
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                        width: 30,
                        height: 30,
                        'images/humidity.png'
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      style: TextStyle(
                          fontFamily: 'RobotoFlex',
                          fontSize: 16
                      ),
                      "Humidity: ${weather.humidity}%",
                    ),
                  ],
                ),
                // Wind Speed
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      width: 30,
                      height: 30,
                      'images/windy.png'
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      style: const TextStyle(fontFamily: "RobotoFlex", fontSize: 16),
                      "Wind Speed: ${weather.windKph} Km/h",
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Sunrise
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                        width: 40,
                        height: 40,
                        "images/sunrise.png"),
                    const Text(
                        style: TextStyle(
                          fontFamily: 'RobotoFlex',
                          fontSize: 16
                        ),
                        "Sunrise"
                    ),
                    Text(
                        style: TextStyle(
                            fontFamily: 'RobotoFlex',
                            fontSize: 16
                        ),
                        weather.sunrise
                    )
                  ],
                ),
                // Sunset
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                        width: 40,
                        height: 40,
                        "images/sunset.png"),
                    const Text(
                        style: TextStyle(
                            fontFamily: 'RobotoFlex',
                            fontSize: 16
                        ),
                        "Sunset"
                    ),
                    Text(
                        style: TextStyle(
                            fontFamily: 'RobotoFlex',
                            fontSize: 16
                        ),
                        weather.sunset
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}