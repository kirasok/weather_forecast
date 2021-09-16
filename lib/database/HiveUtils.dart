import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';

import '../Constants.dart';

void putForecast(Forecast forecast) {
  Hive.box(Constants.forecast_box)
      .put(DateTime.now().toUtc().toIso8601String(), forecast);
}
