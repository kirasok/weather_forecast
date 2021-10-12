import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:weather_forecast/page/ForecastPage.dart';
import 'package:weather_forecast/page/WelcomePage.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeLight = ThemeData.light().copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Colors.lightBlue.shade800,
        secondary: Colors.deepOrangeAccent.shade700,
      ),
      cardTheme: CardTheme.of(context).copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        elevation: 5,
        margin: EdgeInsets.all(8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
      ),
    );

    var themeDark = ThemeData.dark().copyWith(
      colorScheme: ThemeData.dark().colorScheme.copyWith(
        secondary: Colors.deepOrangeAccent.shade100,
      ),
      cardTheme: CardTheme.of(context).copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        elevation: 5,
        margin: EdgeInsets.all(8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
      ),
    );

    var isIntroPlayed = Settings.getValue<bool>('isIntroPlayed', false);
    Widget home;

    if (isIntroPlayed)
      home = ForecastPage();
    else
      home = WelcomePage();

    return MaterialApp(
      title: 'Weather Forecast',
      theme: themeLight,
      darkTheme: themeDark,
      themeMode: ThemeMode.system,
      home: home,
    );
  }
}
