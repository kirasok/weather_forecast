import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_forecast/Constants.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';
import 'package:weather_forecast/utils/Utils.dart';

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
          staggeredTiles: List.filled(9, StaggeredTile.fit(2)),
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
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                  'https://openweathermap.org/img/wn/${forecast.current.weather.icon}@2x.png'),
              Text(description),
            ],
          ),
        ),
      ),
    );

    // Temp
    widgets.add(
      Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(getTemp(forecast.current.temp)),
            Text('Feels Like: ' + getTemp(forecast.current.feels_like)),
          ],
        ),
      ),
    );

    // Pressure
    widgets.add(
      Card(
        child: Text(forecast.current.pressure.toString()),
      ),
    );

    // Humidity
    widgets.add(
      Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(forecast.current.humidity.toString()),
            Text(forecast.current.dew_point.toString()),
          ],
        ),
      ),
    );

    // Uvi
    widgets.add(
      Card(
        child: Text(forecast.current.uvi.toString()),
      ),
    );

    // Clouds
    widgets.add(
      Card(
        child: Text(forecast.current.clouds.toString()),
      ),
    );

    // Visibility
    widgets.add(
      Card(
        child: Text(forecast.current.visibility.toString()),
      ),
    );

    // Wind
    widgets.add(
      Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(forecast.current.wind_deg.toString()),
            Text(forecast.current.wind_speed.toString()),
            Text(forecast.current.wind_gust.toString()),
          ],
        ),
      ),
    );

    // Precipitation
    widgets.add(
      Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(forecast.current.rain.toString()),
            Text(forecast.current.snow.toString()),
          ],
        ),
      ),
    );

    return widgets;
  }
}
