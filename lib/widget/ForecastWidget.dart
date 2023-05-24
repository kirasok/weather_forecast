import 'package:flutter/material.dart';
import 'package:weather_forecast/data/datamodel/Forecast.dart';
import 'package:weather_forecast/widget/CurrentForecast.dart';
import 'package:weather_forecast/widget/DailyForecast.dart';
import 'package:weather_forecast/widget/HourlyForecast.dart';

class ForecastWidget extends StatelessWidget {
  final Forecast forecast;

  const ForecastWidget({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
              HourlyForecast(forecast: forecast),
              // Daily for 7d
              DailyForecast(forecast: forecast),
            ],
          ),
        ),
      ],
    );
  }
}
