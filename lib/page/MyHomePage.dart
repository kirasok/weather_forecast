import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/api/OpenWeatherMapApi.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';

import '../database/HiveUtils.dart';
import 'ForecastPage.dart';
import 'SettingsPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Forecast> forecast;

  @override
  void initState() {
    super.initState();

    forecast = fetchForecast(http.Client());
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
                );
              },
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        body: FutureBuilder<Forecast>(
          future: forecast,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              putForecast(snapshot.data!);
              return ForecastPage();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ));
  }
}
