import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl_browser.dart';
import 'package:weather_forecast/Constants.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';

import 'app/MainApp.dart';

void main() async {
  await Settings.init();
  await Hive.initFlutter();
  await registerAdapters();
  await Hive.openBox(Constants.forecast_box);
  await findSystemLocale();
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