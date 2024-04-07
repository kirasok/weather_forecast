import 'dart:convert';

import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;

import '../datamodel/Coordinates.dart';
import '../datamodel/Forecast.dart';

Future<Coordinates> fetchCoordinates(http.Client client) async {
  final city = Settings.getValue<String>('city') ?? 'London';
  final key = Settings.getValue<String>('api-key') ?? '';

  final response = await client.get(
    Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$key'),
  );

  if (response.statusCode == 200) {
    return parseCoordinates(response.body);
  } else if (response.statusCode == 400 ||
      response.statusCode == 401 ||
      response.statusCode == 404) {
    throw Exception(response.statusCode);
  } else {
    throw Exception("Failed to load coordinates ${response.statusCode}");
  }
}

Coordinates parseCoordinates(String responseBody) =>
    Coordinates.fromJson(jsonDecode(responseBody));

Future<Forecast> fetchForecast(http.Client client) async {
  final lat = Settings.getValue<String>('lat');
  final lon = Settings.getValue<String>('lon');
  final key = Settings.getValue<String>('api-key');

  final response = await client.get(
    Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=alerts&appid=$key'),
  );

  if (response.statusCode == 200) {
    return parseForecast(response.body);
  } else if (response.statusCode == 400 || response.statusCode == 404) {
    throw Exception(response.statusCode);
  } else {
    throw Exception('Failed to load forecast ${response.body}');
  }
}

Forecast parseForecast(String responseBody) =>
    Forecast.fromJson(jsonDecode(responseBody));
