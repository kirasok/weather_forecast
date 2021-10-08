import 'dart:async';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/Constants.dart';
import 'package:weather_forecast/api/OpenWeatherMapApi.dart';
import 'package:weather_forecast/database/HiveUtils.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';
import 'package:weather_forecast/widget/CurrentForecast.dart';
import 'package:weather_forecast/widget/HourlyListTile.dart';

import 'SettingsPage.dart';

class ForecastPage extends StatefulWidget {
  ForecastPage({Key? key, required this.title}) : super(key: key);

  final String title;

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
      body: ValueListenableBuilder(
        valueListenable: Hive.box(Constants.forecast_box).listenable(),
        builder: (context, Box box, _) {
          Forecast forecast = box.values.last;
          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: TabPageSelector(
                    indicatorSize: 6,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Current
                      CurrentForecast(forecast: forecast),
                      // Hourly for 48h
                      ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: forecast.hourly.length,
                        itemBuilder: (context, index) =>
                            HourlyListTile(hourly: forecast.hourly[index]),
                      ),
                      // Daily for 7d
                      ListView(
                        padding: EdgeInsets.all(24),
                        children: [
                          SizedBox(
                            height: 500,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: charts.TimeSeriesChart(
                                  forecast.getTempData(),
                                  animate: false,
                                  defaultRenderer: charts.LineRendererConfig(),
                                  behaviors: [
                                    charts.SeriesLegend(
                                      desiredMaxColumns: 3,
                                      desiredMaxRows: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: charts.TimeSeriesChart(
                                  forecast.getWindSpeedData(),
                                  animate: false,
                                  defaultRenderer: charts.LineRendererConfig(),
                                  behaviors: [
                                    charts.SeriesLegend(
                                      desiredMaxColumns: 1,
                                      desiredMaxRows: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: charts.TimeSeriesChart(
                                  forecast.getPressureData(),
                                  animate: false,
                                  defaultRenderer: charts.LineRendererConfig(),
                                  behaviors: [
                                    charts.SeriesLegend(
                                      desiredMaxColumns: 1,
                                      desiredMaxRows: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: charts.TimeSeriesChart(
                                  forecast.getOtherData(),
                                  animate: false,
                                  defaultRenderer: charts.LineRendererConfig(),
                                  behaviors: [
                                    charts.SeriesLegend(
                                      desiredMaxColumns: 1,
                                      desiredMaxRows: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
}
