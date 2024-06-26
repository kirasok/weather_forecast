import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/Constants.dart';

import '../api/OpenWeatherMapApi.dart';
import '../datamodel/Forecast.dart';

Future<void> putForecast(Forecast forecast) async {
  Hive.box(Constants.forecast_box)
      .put(DateTime.now().toUtc().toIso8601String(), forecast);
}

Future<void> fetchThenPutForecast() async {
  fetchForecast(http.Client()).then((value) => putForecast(value));
}
