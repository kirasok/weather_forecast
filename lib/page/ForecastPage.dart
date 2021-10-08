import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/Constants.dart';
import 'package:weather_forecast/api/OpenWeatherMapApi.dart';
import 'package:weather_forecast/database/HiveUtils.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';
import 'package:weather_forecast/widget/ForecastWidget.dart';

import 'SettingsPage.dart';

class ForecastPage extends StatefulWidget {
  ForecastPage({Key? key}) : super(key: key);

  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  void initState() {
    super.initState();

    fetchForecast(http.Client()).then((value) => putForecast(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: [
          IconButton(
            onPressed: () async {
              await fetchForecast(http.Client())
                  .then((value) => putForecast(value));
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
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
      body: ValueListenableBuilder(
        valueListenable: Hive.box(Constants.forecast_box).listenable(),
        builder: (context, Box box, _) {
          Forecast forecast = box.values.last;
          return DefaultTabController(
            length: 3,
            child: ForecastWidget(forecast: forecast),
          );
        },
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
}
