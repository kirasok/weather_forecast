import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_forecast/Constants.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';
import 'package:weather_forecast/utils/Utils.dart';
import 'package:weather_forecast/widget/HourlyListTile.dart';
import 'package:weather_icons/weather_icons.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
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
                    StaggeredGridView.count(
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
                      ],
                      children: getWidgets(forecast),
                    ),
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
                          height: 300,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: charts.TimeSeriesChart(
                                forecast.getTempData(),
                                animate: false,
                                defaultRenderer: charts.LineRendererConfig(),
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
    );
  }

  List<Widget> getWidgets(Forecast forecast) {
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
                  Image.network(
                      'https://openweathermap.org/img/wn/${forecast.current.weather.icon}@2x.png'),
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

    return widgets;
  }

  Widget getWindGust(double gust) {
    if (gust < 0)
      return Text('');
    else
      return Text('Gusts: ' + getSpeed(gust));
  }
}
