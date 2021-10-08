import 'package:cached_network_image/cached_network_image.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';
import 'package:weather_forecast/utils/Utils.dart';
import 'package:weather_icons/weather_icons.dart';

class CurrentForecast extends StatelessWidget {
  final Forecast forecast;

  const CurrentForecast({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount: 4,
      staggeredTiles: [
        StaggeredTile.fit(4),
        StaggeredTile.fit(4),
        StaggeredTile.fit(2),
        StaggeredTile.fit(2),
        StaggeredTile.fit(2),
        StaggeredTile.fit(2),
        StaggeredTile.fit(2),
        StaggeredTile.fit(2),
        StaggeredTile.fit(4),
      ],
      children: getWidgets(forecast, context),
    );
  }

  List<Widget> getWidgets(Forecast forecast, BuildContext context) {
    List<Widget> widgets = [];

    // Weather
    String description = forecast.current.weather.description[0].toUpperCase() +
        forecast.current.weather.description.substring(1);
    widgets.add(
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
                  CachedNetworkImage(
                    imageUrl:
                        'https://openweathermap.org/img/wn/${forecast.current.weather.icon}@2x.png',
                    placeholder: (_, __) => SizedBox(
                      height: 100,
                      width: 100,
                    ),
                    errorWidget: (_, __, ___) => SizedBox(
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Text(
                    getTemp(forecast.current.temp),
                    style: Theme.of(context).textTheme.headline6,
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
    );

    // Details row
    widgets.add(
      Container(
        padding: EdgeInsets.fromLTRB(24, 8, 0, 8),
        child: Text(
          'Today Details',
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    );

    // Wind
    widgets.add(
      Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WindIcon(
              degree: forecast.current.wind_deg,
            ),
            Text('Wind speed: ' + getSpeed(forecast.current.wind_speed)),
            getWindGust(forecast.current.wind_gust),
          ],
        ),
      ),
    );

    // Pressure
    widgets.add(
      Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Text(
              'Pressure: ' + getPressure(forecast.current.pressure),
            ),
          ),
        ),
      ),
    );

    // Humidity
    widgets.add(
      Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Humidity: ' + toPercentage(forecast.current.humidity)),
              Text('Dew Point: ' + getTemp(forecast.current.dew_point)),
            ],
          ),
        ),
      ),
    );

    // Uvi
    widgets.add(
      Card(
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
    );

    // Clouds
    widgets.add(
      Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Text('Clouds: ' + toPercentage(forecast.current.clouds)),
          ),
        ),
      ),
    );

    // Visibility
    widgets.add(
      Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Text(
              'Visibility: ' + toDistance(forecast.current.visibility),
            ),
          ),
        ),
      ),
    );

    // Precipitation
    widgets.add(Card(
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
    ));

    return widgets;
  }

  Widget getWindGust(double gust) {
    if (gust < 0)
      return Text('');
    else
      return Text('Gusts: ' + getSpeed(gust));
  }
}
