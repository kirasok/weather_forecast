import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_forecast/Constants.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';

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
          children: [
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(forecast.current.weather.id.toString()),
                  Text(forecast.current.weather.main.toString()),
                  Text(forecast.current.weather.description.toString()),
                  Text(forecast.current.weather.icon.toString()),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(forecast.current.temp.toString()),
                  Text('Feels Like: ' + forecast.current.feels_like.toString()),
                ],
              ),
            ),
            Card(
              child: Text(forecast.current.pressure.toString()),
            ),
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
            Card(
              child: Text(forecast.current.uvi.toString()),
            ),
            Card(
              child: Text(forecast.current.clouds.toString()),
            ),
            Card(
              child: Text(forecast.current.visibility.toString()),
            ),
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
          ],
        );
      },
    );
  }
}
