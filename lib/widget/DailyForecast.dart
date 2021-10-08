import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';

class DailyForecast extends StatelessWidget {
  final Forecast forecast;

  const DailyForecast({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
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
    );
  }
}
