import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:weather_forecast/data/datamodel/Forecast.dart';
import 'package:weather_forecast/utils/Utils.dart';
import 'package:weather_icons/weather_icons.dart';

import 'WeatherIcon.dart';

class CurrentForecast extends StatelessWidget {
  final Forecast forecast;

  const CurrentForecast({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String description = forecast.current.weather.description[0].toUpperCase() +
        forecast.current.weather.description.substring(1);
    return ListView(
      children: [
        // Weather
        Card(
          margin: EdgeInsets.fromLTRB(12, 24, 12, 12),
          elevation: 8,
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    WeatherIcon(
                      icon: forecast.current.weather.icon,
                    ),
                    Text(
                      getTemp(forecast.current.temp),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Text(description),
                SizedBox(height: 8),
                Text('Feels Like: ' + getTemp(forecast.current.feels_like)),
              ],
            ),
          ),
        ),
        // Details row
        Container(
          padding: EdgeInsets.fromLTRB(24, 8, 0, 8),
          child: Text(
            'Today Details',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Wind
              Expanded(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WindIcon(
                          degree: forecast.current.wind_deg,
                        ),
                        Text('Wind speed: ' +
                            getSpeed(forecast.current.wind_speed)),
                        getWindGust(forecast.current.wind_gust),
                      ],
                    ),
                  ),
                ),
              ),
              // Pressure
              Expanded(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        'Pressure: ' + getPressure(forecast.current.pressure),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // Humidity
            children: [
              Expanded(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Humidity: ' +
                            toPercentage(forecast.current.humidity)),
                        Text('Dew Point: ' +
                            getTemp(forecast.current.dew_point)),
                      ],
                    ),
                  ),
                ),
              ),
              // Uvi
              Expanded(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Uvi index'),
                        Text(forecast.current.uvi.toString()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Clouds
              Expanded(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                          'Clouds: ' + toPercentage(forecast.current.clouds)),
                    ),
                  ),
                ),
              ),
              // Visibility
              Expanded(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        'Visibility: ' +
                            toDistance(forecast.current.visibility),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Precipitation
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 150,
              child: charts.BarChart(
                forecast.getMinutely(),
                animate: false,
                behaviors: [
                  charts.SeriesLegend(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getWindGust(double gust) {
    if (gust < 0)
      return Text('');
    else
      return Text('Gusts: ' + getSpeed(gust));
  }
}
