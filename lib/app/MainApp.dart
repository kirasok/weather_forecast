import 'package:flutter/material.dart';
import 'package:weather_forecast/page/MyHomePage.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Colors.lightBlue.shade800,
            secondary: Colors.deepOrangeAccent.shade700,
          ),
      cardTheme: CardTheme.of(context).copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        elevation: 5,
        margin: EdgeInsets.all(12),
      ),
    );

    return MaterialApp(
      title: 'Weather Forecast',
      theme: theme,
      home: MyHomePage(title: 'Weather'),
    );
  }
}
