import 'dart:convert';

import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/datamodel/Coordinates.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';

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
  Map<String, dynamic> map = jsonDecode(responseBody);
  if (map.containsKey('cod'))
    if (map['cod'] == 401)
      throw Exception(map['cod']);
  return Coordinates.fromJson(map);
}

Future<Forecast> fetchForecast(http.Client client) async {
  String lat = Settings.getValue('lat', '');
  String lon = Settings.getValue('lon', '');
  String key = Settings.getValue<String>('api-key', '');

  final response = await client.get(
    Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=alerts&appid=$key'),
  );

  if (response.statusCode == 200) {
    return parseForecast(response.body);
  } else {
    throw Exception('Failed to load forecast');
  }
}

Forecast parseForecast(String responseBody) {
  return Forecast.fromJson(jsonDecode(responseBody));
}
