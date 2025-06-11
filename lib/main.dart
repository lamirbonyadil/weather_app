import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load .env into memory
  await dotenv.load(fileName: ".env");

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Main(),
  ));
}
