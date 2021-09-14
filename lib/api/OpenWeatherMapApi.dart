import 'dart:convert';

import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/datamodel/Coordinates.dart';

Future<Coordinates> fetchCoordinates(http.Client client) async {
  String city = Settings.getValue<String>('city', 'London');
  String key = Settings.getValue<String>('api-key', '');

  final response = await client.get(
    Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$key'),
  );

  if (response.statusCode == 200) {
    return parseCoordinates(response.body);
  } else {
    throw Exception("Failed to lad coordinates");
  }
}

Coordinates parseCoordinates(String responseBody) {
  return Coordinates.fromJson(jsonDecode(responseBody));
}
