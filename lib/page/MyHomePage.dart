import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/api/OpenWeatherMapApi.dart';
import 'package:weather_forecast/database/HiveUtils.dart';

import 'ForecastPage.dart';
import 'SettingsPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    fetchForecast(http.Client()).then((value) => putForecast(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              ).then(onGoBack);
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: ForecastPage(),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
}
