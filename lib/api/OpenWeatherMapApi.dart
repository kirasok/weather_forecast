import 'dart:convert';

import 'package:flutter/foundation.dart';
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
  return compute(parseCoordinates, response.body);
}

Coordinates parseCoordinates(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Coordinates>(
    (json) => Coordinates.fromJson(json),
  );
}
