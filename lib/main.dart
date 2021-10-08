import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_forecast/Constants.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';
import 'package:weather_forecast/utils/MyCacheProvider.dart';

import 'app/MainApp.dart';

// TODO: on scroll up update forecast
// TODO: add welcome screen where user sets key and city
// TODO: add about screen
// TODO: add more datetime formats
// TODO: use local stored weather icons, not from network

void main() async {
  await Settings.init(cacheProvider: MyCacheProvider());
  await Hive.initFlutter();
  await registerAdapters();
  await Hive.openBox(Constants.forecast_box);
  runApp(MainApp());
}

Future<void> registerAdapters() async {
  Hive.registerAdapter(ForecastAdapter());
  Hive.registerAdapter(WeatherAdapter());
  Hive.registerAdapter(CurrentAdapter());
  Hive.registerAdapter(MinutelyAdapter());
  Hive.registerAdapter(HourlyAdapter());
  Hive.registerAdapter(TempAdapter());
  Hive.registerAdapter(FeelslikeAdapter());
  Hive.registerAdapter(DailyAdapter());
}