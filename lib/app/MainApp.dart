import 'package:flutter/material.dart';
import 'package:weather_forecast/page/MyHomePage.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amberAccent,
      ),
      home: MyHomePage(title: 'Weather'),
    );
  }
}