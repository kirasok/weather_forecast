import 'package:flutter/material.dart';
import 'package:weather_forecast/page/MyHomePage.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        cardTheme: CardTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          elevation: 5,
          margin: EdgeInsets.all(12),
        ),
      ),
      home: MyHomePage(title: 'Weather'),
    );
  }
}
