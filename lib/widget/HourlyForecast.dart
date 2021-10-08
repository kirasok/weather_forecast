import 'package:flutter/material.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';
import 'package:weather_forecast/widget/HourlyListTile.dart';

class HourlyForecast extends StatelessWidget {
  final Forecast forecast;

  const HourlyForecast({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: forecast.hourly.length,
      itemBuilder: (context, index) =>
          HourlyListTile(hourly: forecast.hourly[index]),
    );
  }
}
