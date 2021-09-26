import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_forecast/Constants.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';
import 'package:weather_forecast/utils/Utils.dart';
import 'package:weather_icons/weather_icons.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(Constants.forecast_box).listenable(),
      builder: (context, Box box, _) {
        Forecast forecast = box.values.last;
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
          ],
          children: getWidgets(forecast),
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
              Text('Humidity: ' + forecast.current.humidity.toString() + '%'),
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
            child: Text('Clouds: ' + forecast.current.clouds.toString() + '%'),
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
            child: Text('Visibility: ' +
                forecast.current.visibility.toString() +
                ' km'),
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
