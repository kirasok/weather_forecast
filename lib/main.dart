import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl_standalone.dart';
import 'package:weather_forecast/Constants.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';
import 'package:weather_forecast/utils/MyCacheProvider.dart';

import 'app/MainApp.dart';

// TODO: add one time intro screen where user sets key and city
// TODO: add splash screen
// TODO: use local stored weather icons, not from network (wait till weather_icon implement feature)

void main() async {
  await Settings.init(cacheProvider: MyCacheProvider());
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
